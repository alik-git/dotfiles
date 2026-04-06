---
name: ali-code-review
description: Review code in any software project with a senior-engineer mindset focused on obvious wrongness, unnecessary complexity, redundancy, poor organization, convention drift, outdated docs, and complexity added only for backward compatibility. Use when Codex should identify the worst offenders, suggest simpler or more correct structures, and recommend cleaner patterns that improve long-term maintainability and clarity.
---

# Ali Code Review

Review like a fresh senior engineer reading the code for the first time: assume the people involved are competent, then look for things that still feel clearly wrong, overly complex, badly placed, redundant, awkward, or embarrassing enough that they should be simplified or redone.

## Priorities

- Scope the review to the actual thing being reviewed: a PR, branch, diff, feature, commit range, or local change set, not the whole project unless that is explicitly the task.
- Look first for obvious wrongness: code that a strong engineer would immediately question.
- Treat unnecessary complexity as a major issue.
- Prefer simpler structures, less code, less duplication, and clearer organization.
- Favor long-term maintainability, readability, and clean patterns over preserving awkward legacy behavior.
- Follow the existing project's conventions and style unless they are themselves part of the problem.

## What To Look For

- Logic or structure that is clearly more complicated than needed.
- Redundant code, repeated patterns, needless abstractions, or indirection without payoff.
- Code living in the wrong place, mixed responsibilities, or organization that makes the project harder to understand.
- New compatibility layers, transitional code, or defensive branching that add complexity mainly to preserve backward compatibility.
- Places where a full migration or cleaner break would be a better tradeoff than carrying old behavior forward.
- Docs or README content that no longer match the current code.

## Review Standard

- Use the current conversation and local context to determine the review boundary before judging anything outside it.
- Do not optimize for backward compatibility by default.
- If simplification would break backward compatibility, say that directly and explain why the simplification may still be worth it.
- Prefer high-conviction observations over exhaustive nitpicks.
- Focus on the worst problems and worst offenders first.
- Suggest the cleaner design or refactor direction, not just the complaint.

## Output

Start with the strongest findings first. For each finding, explain:

- what is wrong
- why it is wrong or unnecessarily complex
- what the simpler or more correct approach would be
- whether backward compatibility is the only thing keeping the current design alive

Then include a short section for outdated or missing docs if relevant.
