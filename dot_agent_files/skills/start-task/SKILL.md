---
name: start-task
description: "Set up the right worklog plan, companion note, and optionally a workset for a coding task. Reads dev-workflow.md and runs the right worklogs command."
---

# Start Task

Read `~/.agent_files/docs/dev-workflow.md` before doing anything else.

When invoked, set up the correct task structure based on the task description
and the three-bucket model from that doc:

## Bucket Classification

**Read-only** — code reviews, investigations, PR checks, reading docs:
- Create a plan + companion note only. No workset. Fast.
- Kind is `codereview` for reviews, `investigation` for investigations,
  `note` for general notes.

**Implement, discuss-first** — coding tasks where scope or approach is unclear:
- Create plan + companion note first.
- Do NOT create the workset yet — discuss the plan with the user first.
- Once the plan is solid and repos/branches are known, attach the workset.

**Implement, upfront** — coding tasks where repos and approach are clear:
- Create plan + companion note + workset in one shot.

## What to Ask If Not Provided

Before running any command, collect what's missing:

1. **Task name slug** — short, lowercase, hyphenated (e.g. `fix-login-bug`)
2. **Scope** — `work` for work, `personal` for tools/personal projects
3. **Repos + branches** — only if creating a workset now
   (e.g. `my-repo:feat/my-feature my-other-repo:main`)

If the task description makes scope obvious, infer it and confirm rather than asking. If it is clearly a read-only task, do not ask about repos.

## Commands to Run

Read-only:
```bash
worklogs new <slug>--<kind> --scope <scope>
```

Implement (discuss first):
```bash
worklogs new <slug>--plan --scope <scope>
# stop here — discuss the plan before attaching a workset
```

Implement (upfront):
```bash
worklogs new <slug>--plan --scope <scope> \
  --workset <repo>:<branch> [--workset <repo>:<branch> ...]
```

Attach workset later (after plan is ready):
```bash
worklogs workset <slug> <repo>:<branch> [<repo>:<branch> ...]
```

## After Creating Files

Print the paths to the created plan and companion note so the user can open
them immediately. If a workset was created, print the workset path too.

## Companion Note Discipline

Remind the agent (yourself) at task start:
- Update the companion note at each significant decision or finding.
- Update it before opening a PR — include the PR link.

The plan file is updated for structural state only:
- Mark phases done (✅), flip `status: done` when finished.
- Record major direction changes that affect the plan structure.

Do NOT use the plan as an execution log — running notes, commands, failures,
and findings go in the companion note, not the plan.
