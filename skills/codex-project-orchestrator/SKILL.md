---
name: codex-project-orchestrator
description: Initialize and run a repository-local project memory workflow for Codex multi-thread development. Use when the user wants a main thread to analyze project progress, turn a PRD into feature tracking, coding milestones, task boards, thread handoffs, validation logs, progress audits, or coordinate multiple Codex threads without corrupting each other's work. Pairs with $project-memory-manager, which owns docs/project-memory persistence.
---

# Codex Project Orchestrator

## Overview

Use this skill to make Codex project work explicit, trackable, and safe across multiple threads. The skill provides the orchestration workflow; the current repository's `docs/project-memory` directory stores the project state.

Core distinction:

- Skill = reusable process, rules, prompts, and templates.
- `docs/project-memory` = repository-local facts: PRD/product brief, feature status, task ownership, decisions, handoffs, validation, session snapshots.
- `$project-memory-manager` = the only skill that owns project-memory initialization, file schema, session snapshots, validation, and handoff persistence.
- Default invocation = main thread, not development thread.

Project-memory authority model:

- Main thread owns core state files.
- Worker and new development threads submit facts through `inbox/thread-updates/`, `07-thread-handoff.md`, and `08-validation-log.md`.
- Main thread reviews inbox updates and then changes `00-start-here.md`, `02-feature-map.md`, `03-milestones.md`, `04-task-board.md`, `05-architecture-map.md`, `06-decision-log.md`, and `09-open-questions.md`.

## Trigger Phrases

Use this skill when the user asks for:

- "根据 PRD 生成开发里程碑"
- "把产品文档拆成任务看板"
- "创建 Codex 多线程开发流程"
- "不同 Codex 线程怎么协作"
- "初始化项目控制台"
- "盘点当前开发进度"
- "作为主线程分析项目"
- "作为开发线程领取任务"
- "作为集成线程合并和验收"

## Thread Role Model

When this skill is invoked without an explicit role, act as the main thread.

Main thread responsibilities:

- Analyze PRD, project scope, progress, dependencies, blockers, and sequencing.
- Initialize and maintain `docs/project-memory` through `$project-memory-manager`.
- Split PRD into feature map, milestones, and task board.
- Assign clear task boundaries for development threads.
- Read handoffs and produce integration readiness analysis.
- Report current progress and next recommended tasks.

Main thread restrictions:

- Do not modify product source code, tests, migrations, runtime config, or implementation files.
- Do not silently switch into a development or integration thread.
- Only edit repository-local project memory documents unless the user explicitly changes role.
- If the user asks for implementation while still in main-thread mode, create or update the task entry and provide the exact development-thread prompt to run next.
- Do not create speculative worker/thread suggestions. Only propose threads for READY tasks with clear ownership, validation, and direct relevance to the user's current goal.
- Do not turn commit/push, verification, or narrow status tasks into broad project roadmaps unless the user asks for a progress audit.

Development thread mode starts only when the user explicitly says they are starting a development thread and provides a task ID or a narrow task boundary.

Integration thread mode starts only when the user explicitly asks for integration, merge validation, release readiness, or cross-thread consolidation.

## Project Memory Files

Default target path: `docs/project-memory`.

Required files:

- `00-start-here.md`: first-read entry for new threads.
- `01-product-brief.md`: product target, users, scope, dependencies, acceptance stance.
- `02-feature-map.md`: full feature tracking matrix.
- `03-milestones.md`: dependency-ordered coding milestones.
- `04-task-board.md`: thread-sized executable tasks.
- `05-architecture-map.md`: modules, key files, call chains, shared-file risks.
- `06-decision-log.md`: product, technical, and acceptance decisions.
- `07-thread-handoff.md`: append-only thread and worker communication log.
- `08-validation-log.md`: test, build, interface, browser, and real-environment evidence.
- `09-open-questions.md`: unresolved questions and blockers.
- `inbox/thread-updates/`: worker/new-thread fact reports awaiting main-thread review.
- `sessions/`: session snapshots for important work.

To initialize the files, run:

```bash
bash "${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/init_project_memory.sh" .
```

The script refuses to overwrite existing files unless called with `--force`.

Legacy `docs/project` directories are read-only context until the user explicitly asks to migrate them into `docs/project-memory`.

## Workflow

### 1. Initialize Project Memory

When the user asks to create the workflow in a repo:

1. Inspect the current working directory and existing `docs/project-memory` and legacy `docs/project` files.
2. Run `"${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/init_project_memory.sh" <repo-root>` if the files do not already exist.
3. If files already exist, read them and continue from current state instead of overwriting.
4. Run `"${CODEX_HOME:-$HOME/.codex}/skills/project-memory-manager/scripts/validate_project_memory.sh" <repo-root>` after initialization or structural edits.
5. Tell the user which files were created or already present.

### 2. Convert PRD Into Feature Map

Read `01-product-brief.md` and create or update `02-feature-map.md`.

Rules:

- Extract all user-facing, backend, admin, data, permission, integration, configuration, testing, and documentation requirements.
- Every feature must have ID, module, priority, status, dependencies, acceptance criteria, and verification record.
- Do not mark real external capabilities as complete unless they are actually integrated and verified.
- Split vague or bundled requirements until each item can be validated.

### 3. Create Milestones

Read `02-feature-map.md` and update `03-milestones.md`.

Rules:

- Order by dependency, not document order.
- Prioritize the P0 main path.
- Include foundations, vertical slices, integrations, hardening, docs, and final validation.
- Each milestone must have completion criteria that can be checked.

### 4. Create Task Board

Read `02-feature-map.md` and `03-milestones.md`, then update `04-task-board.md`.

Rules:

- Each task should fit one Codex thread.
- Mark file ownership and likely shared-file risks.
- Separate shared surfaces such as migrations, route registration, OpenAPI, global state, and common components.
- Use `READY` only when dependencies and validation are clear.

### 5. Run A Development Thread

Only enter this mode when explicitly requested. When acting as a development thread:

1. Read `00-start-here.md`, `02-feature-map.md`, `03-milestones.md`, `04-task-board.md`, `06-decision-log.md`, and `07-thread-handoff.md`.
2. Confirm the selected task ID and file boundary.
3. Understand project structure and call chain before editing.
4. Modify only the task's necessary scope.
5. Validate locally.
6. Append or return a standard `inbox/thread-updates/` report plus handoff/validation evidence.
7. The main thread reviews inbox updates and records status, validation, and accepted facts through `$project-memory-manager`.

Do not let a development thread silently expand scope or integrate other threads' work.

### 6. Run An Integration Thread

Only enter this mode when explicitly requested. When acting as an integration thread:

1. Read all project memory files.
2. Identify tasks in `REVIEW` or `VERIFIED`.
3. Inspect handoff entries and changed file ranges.
4. Merge carefully, preserving correct business behavior.
5. Run full validation appropriate to the repo.
6. Update feature map, milestones, task board, validation log, handoff log, and decision log when needed.
7. Report what is truly done, blocked, and not started.

## State Rules

Use only these task and feature states:

| State | Meaning |
| --- | --- |
| TODO | Identified but not ready to start |
| READY | Clear enough to start |
| IN_PROGRESS | Currently being built |
| REVIEW | Code changed, awaiting review or integration |
| VERIFIED | Locally validated but not fully integrated |
| DONE | Integrated, verified, and documented |
| BLOCKED | Cannot proceed; reason must be recorded |

`DONE` requires implementation, acceptance evidence, verification record, required docs, and no hidden external dependency.

## Parallel Thread Rules

- Prefer one Git branch or worktree per thread.
- One thread owns one task or one vertical slice.
- Avoid concurrent edits to the same shared core files.
- Use `07-thread-handoff.md`, not chat history, as the communication channel.
- Use `inbox/thread-updates/` for worker facts that need main-thread review.
- Use `04-task-board.md` for ownership and writable scope.
- Use one integration thread to combine work and settle conflicts.

## Noise Control

When producing project memory or thread advice:

- Record direct facts, current task state, validation evidence, blockers, and confirmed next actions.
- Avoid generic future work such as broad refactors, module migration plans, pressure testing, launch checklists, or unrelated worker suggestions unless the user asks for those.
- If a historical session is only a commit/push or verification thread, summarize it as such; do not expand it into a project strategy.

## Output Style

When reporting to the user, keep it short:

- What changed
- Why it was structured that way
- How to verify or continue
- Which items remain blocked or unfinished

## Boundaries

This skill does not store project progress inside the skill directory. It must not be used as a substitute for Git branch isolation, code review, tests, or repository-local project state.
