#!/usr/bin/env python3
"""Remind Codex to use quick-status for redundant status commands."""

from __future__ import annotations

import json
import re
import shlex
import shutil
import sys


_ENV_ASSIGNMENT = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*=.*$")
_FORBIDDEN_SHELL_CHARS = ("|", ";", "<", ">", "`", "$(")

_TRIGGERS = {
    ("git", "status"): "quick-status repo --plain",
    ("git", "status", "--short"): "quick-status repo --plain",
    ("git", "status", "--short", "--branch"): "quick-status repo --plain",
    ("git", "status", "--porcelain"): "quick-status repo --plain",
    ("git", "branch"): "quick-status repo --plain",
    ("git", "branch", "--show-current"): "quick-status repo --plain",
    ("git", "remote", "-v"): "quick-status repo --plain",
    ("git", "rev-parse", "--show-toplevel"): "quick-status repo --plain",
    ("git", "submodule", "status"): "quick-status repo --plain",
    ("git", "worktree", "list"): "quick-status repo --plain --worktrees",
    ("git", "worktree", "list", "--porcelain"): "quick-status repo --plain --worktrees",
    ("gh", "pr", "status"): "quick-status repo --plain --github",
    ("gh", "pr", "checks"): "quick-status repo --plain --github",
    ("gh", "run", "list"): "quick-status repo --plain --github",
    ("gh", "release", "list"): "quick-status repo --plain --github",
    ("gh", "run", "view"): "quick-status ci --plain",
    ("gh", "run", "view", "--log"): "quick-status ci --plain --log-tail 40",
    ("which", "python"): "quick-status env --plain --show-tools",
    ("which", "python3"): "quick-status env --plain --show-tools",
    ("which", "pip"): "quick-status env --plain --show-tools",
    ("which", "pip3"): "quick-status env --plain --show-tools",
    ("which", "conda"): "quick-status env --plain --show-tools",
    ("which", "uv"): "quick-status env --plain --show-tools",
    ("which", "devpy"): "quick-status env --plain --show-tools",
    ("python", "--version"): "quick-status env --plain --show-tools",
    ("python3", "--version"): "quick-status env --plain --show-tools",
    ("pip", "--version"): "quick-status env --plain --show-tools",
    ("pip3", "--version"): "quick-status env --plain --show-tools",
    ("conda", "info"): "quick-status env --plain --show-tools",
    ("conda", "env", "list"): "quick-status env --plain --show-tools",
    ("uv", "tool", "list"): "quick-status env --plain --show-tools",
    ("uv", "python", "list"): "quick-status env --plain --show-tools",
    ("uv", "python", "dir"): "quick-status env --plain --show-tools",
    ("devpy", "info"): "quick-status env --plain --show-tools",
}


def _load_payload() -> dict:
    try:
        payload = json.load(sys.stdin)
    except json.JSONDecodeError:
        return {}
    return payload if isinstance(payload, dict) else {}


def _is_env_assignment(token: str) -> bool:
    return bool(_ENV_ASSIGNMENT.match(token))


def _strip_leading_assignments(tokens: list[str]) -> list[str] | None:
    remaining = list(tokens)
    while remaining and _is_env_assignment(remaining[0]):
        if remaining[0] == "QUICK_STATUS_BYPASS=1":
            return None
        remaining.pop(0)
    return remaining


def _simple_command_tokens(command: str) -> list[str] | None:
    command = command.strip()
    if not command or "\n" in command:
        return None
    if any(marker in command for marker in _FORBIDDEN_SHELL_CHARS):
        return None

    try:
        tokens = shlex.split(command)
    except ValueError:
        return None

    if not tokens:
        return None
    if any(token == "quick-status" or token.endswith("/quick-status") for token in tokens):
        return None

    if "&&" in tokens:
        if tokens.count("&&") != 1:
            return None
        separator = tokens.index("&&")
        prefix = tokens[:separator]
        suffix = tokens[separator + 1 :]
        if prefix[:1] != ["cd"]:
            return None
        if len(prefix) not in {2, 3}:
            return None
        if len(prefix) == 3 and prefix[1] != "--":
            return None
        tokens = suffix

    if any(token in {"&&", "||", "&"} for token in tokens):
        return None

    return _strip_leading_assignments(tokens)


def _suggestion_for(command: str) -> str | None:
    if shutil.which("quick-status") is None:
        return None
    tokens = _simple_command_tokens(command)
    if not tokens:
        return None
    return _TRIGGERS.get(tuple(tokens))


def main() -> int:
    payload = _load_payload()
    if payload.get("hook_event_name") != "PreToolUse":
        return 0
    if payload.get("tool_name") != "Bash":
        return 0

    tool_input = payload.get("tool_input")
    if not isinstance(tool_input, dict):
        return 0
    command = tool_input.get("command")
    if not isinstance(command, str):
        return 0

    suggestion = _suggestion_for(command)
    if suggestion is None:
        return 0

    reason = (
        f"Use `{suggestion}` first for this status snapshot. "
        "If raw output is still needed afterward, rerun the command with "
        "`QUICK_STATUS_BYPASS=1`."
    )
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PreToolUse",
            "permissionDecision": "deny",
            "permissionDecisionReason": reason,
        }
    }))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
