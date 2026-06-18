#!/usr/bin/env python3
"""Check the public dotfiles repo for private work-context leaks."""

from __future__ import annotations

import argparse
import os
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


EXCLUDED_PREFIXES = (
    ".git/",
    "dotfiles_private/",
    "temp/",
)
EXCLUDED_PATHS = {
    "dotfiles_private",
}
MAX_FILE_BYTES = 5 * 1024 * 1024


@dataclass(frozen=True)
class Pattern:
    label: str
    regex: re.Pattern[str]


@dataclass(frozen=True)
class Finding:
    where: str
    label: str


def run_git(repo: Path, args: list[str], *, check: bool = True) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        ["git", *args],
        cwd=repo,
        check=check,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )


def repo_root() -> Path:
    result = subprocess.run(
        ["git", "rev-parse", "--show-toplevel"],
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    return Path(result.stdout.strip())


def load_patterns(repo: Path) -> list[Pattern]:
    denylist_path = Path(
        os.environ.get(
            "DOTFILES_PRIVACY_DENYLIST",
            repo / "dotfiles_private" / "privacy" / "denylist.tsv",
        )
    )
    if not denylist_path.exists():
        # Public-only clones (colleagues without the private companion repo)
        # have no denylist. The dotfiles privacy check is maintainer-only, so
        # skip it cleanly instead of blocking their commits/pushes.
        print(
            f"[privacy] no private denylist at {denylist_path}; "
            "skipping maintainer-only privacy check "
            "(set DOTFILES_PRIVACY_DENYLIST or initialize dotfiles_private to enable).",
            file=sys.stderr,
        )
        raise SystemExit(0)

    patterns: list[Pattern] = []
    for line_number, raw_line in enumerate(denylist_path.read_text(encoding="utf-8").splitlines(), 1):
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if "\t" not in line:
            raise SystemExit(f"[privacy] malformed denylist line {line_number}: expected label<TAB>regex")
        label, regex_text = line.split("\t", 1)
        try:
            regex = re.compile(regex_text, re.IGNORECASE)
        except re.error as exc:
            raise SystemExit(f"[privacy] malformed regex on denylist line {line_number}: {exc}") from exc
        patterns.append(Pattern(label=label, regex=regex))

    if not patterns:
        raise SystemExit("[privacy] private denylist has no active patterns")
    return patterns


def is_public_path(path: str) -> bool:
    path = path.strip("/")
    if path in EXCLUDED_PATHS:
        return False
    return not any(path.startswith(prefix) for prefix in EXCLUDED_PREFIXES)


def split_nul(output: str) -> list[str]:
    return [item for item in output.split("\0") if item]


def candidate_worktree_files(repo: Path) -> list[str]:
    tracked = split_nul(run_git(repo, ["ls-files", "-z"]).stdout)
    untracked = split_nul(run_git(repo, ["ls-files", "--others", "--exclude-standard", "-z"]).stdout)
    return sorted({path for path in [*tracked, *untracked] if is_public_path(path)})


def read_worktree_file(repo: Path, path: str) -> str | None:
    full_path = repo / path
    if not full_path.is_file() or full_path.is_symlink():
        return None
    try:
        if full_path.stat().st_size > MAX_FILE_BYTES:
            return None
        return full_path.read_text(encoding="utf-8", errors="ignore")
    except OSError:
        return None


def scan_text(where: str, text: str, patterns: list[Pattern]) -> list[Finding]:
    findings: list[Finding] = []
    for pattern in patterns:
        if pattern.regex.search(text):
            findings.append(Finding(where=where, label=pattern.label))
    return findings


def scan_worktree(repo: Path, patterns: list[Pattern]) -> list[Finding]:
    findings: list[Finding] = []
    for path in candidate_worktree_files(repo):
        findings.extend(scan_text(f"path:{path}", path, patterns))
        contents = read_worktree_file(repo, path)
        if contents is not None:
            findings.extend(scan_text(f"file:{path}", contents, patterns))
    return findings


def scan_git_config(repo: Path, patterns: list[Pattern]) -> list[Finding]:
    result = run_git(repo, ["config", "--get", "user.email"], check=False)
    if result.returncode != 0:
        return [Finding(where="git-config:user.email", label="missing-user-email")]
    return scan_text("git-config:user.email", result.stdout.strip(), patterns)


def iter_history_blobs(repo: Path) -> list[tuple[str, str, str]]:
    revs = run_git(repo, ["rev-list", "--all"]).stdout.splitlines()
    seen_blobs: set[str] = set()
    blobs: list[tuple[str, str, str]] = []

    for rev in revs:
        tree = run_git(repo, ["ls-tree", "-r", "-z", rev]).stdout
        for entry in split_nul(tree):
            metadata, _, path = entry.partition("\t")
            parts = metadata.split()
            if len(parts) < 3 or parts[1] != "blob" or not is_public_path(path):
                continue
            blob = parts[2]
            if blob in seen_blobs:
                continue
            seen_blobs.add(blob)
            blobs.append((rev, path, blob))
    return blobs


def read_blob(repo: Path, blob: str) -> str | None:
    size_result = run_git(repo, ["cat-file", "-s", blob], check=False)
    if size_result.returncode != 0:
        return None
    try:
        if int(size_result.stdout.strip()) > MAX_FILE_BYTES:
            return None
    except ValueError:
        return None
    blob_result = subprocess.run(
        ["git", "cat-file", "blob", blob],
        cwd=repo,
        check=False,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if blob_result.returncode != 0:
        return None
    return blob_result.stdout.decode("utf-8", errors="ignore")


def scan_history(repo: Path, patterns: list[Pattern]) -> list[Finding]:
    findings: list[Finding] = []
    metadata = run_git(repo, ["log", "--all", "--format=%H%n%an%n%ae%n%cn%n%ce%n%s%n%b%x00"]).stdout
    findings.extend(scan_text("history:commit-metadata", metadata, patterns))

    for rev, path, blob in iter_history_blobs(repo):
        findings.extend(scan_text(f"history-path:{rev[:12]}:{path}", path, patterns))
        contents = read_blob(repo, blob)
        if contents is not None:
            findings.extend(scan_text(f"history-file:{rev[:12]}:{path}", contents, patterns))
    return findings


def render_findings(findings: list[Finding]) -> None:
    print("[privacy] forbidden public dotfiles content found", file=sys.stderr)
    for finding in findings[:50]:
        print(f"  {finding.where} [{finding.label}]", file=sys.stderr)
    if len(findings) > 50:
        print(f"  ... {len(findings) - 50} more findings omitted", file=sys.stderr)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--history",
        action="store_true",
        help="also scan reachable Git history, intended for pre-push/manual checks",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    repo = repo_root()
    patterns = load_patterns(repo)

    findings = []
    findings.extend(scan_git_config(repo, patterns))
    findings.extend(scan_worktree(repo, patterns))
    if args.history:
        findings.extend(scan_history(repo, patterns))

    if findings:
        render_findings(findings)
        return 1
    print("[privacy] ok")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
