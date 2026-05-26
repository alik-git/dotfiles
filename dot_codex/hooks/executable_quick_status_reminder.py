#!/usr/bin/env python3
"""Add a short model-visible Codex reminder for quick-status."""

import json
import sys


def main() -> None:
    # Consume the hook payload so broken JSON is the only thing this hook ignores.
    try:
        json.load(sys.stdin)
    except json.JSONDecodeError:
        pass

    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "UserPromptSubmit",
            "additionalContext": (
                "When repo, worktree, GitHub CI, or Python environment state matters, "
                "use `quick-status` first when its snapshot fits before reconstructing "
                "the same facts with ad hoc commands."
            ),
        }
    }))


if __name__ == "__main__":
    main()
