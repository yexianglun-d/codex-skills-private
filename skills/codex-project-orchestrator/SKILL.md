---
name: codex-project-orchestrator
description: Initialize and run a repository-local project control workflow for Codex multi-thread development. Use when the user wants to turn a PRD into feature tracking, coding milestones, task boards, thread handoffs, integration logs, progress audits, or when they ask how multiple Codex threads should coordinate without corrupting each other's work.
---

# Codex Project Orchestrator

## Overview

Use this skill to make Codex project work explicit, trackable, and safe across multiple threads. The skill provides the workflow; the current repository's `docs/project` directory stores the project state.

Core distinction:

- Skill = reusable process, rules, prompts, and templates.
- `docs/project` = repository-local facts: PRD, feature status, task ownership, handoffs, integration results.

## Trigger Phrases

Use this skill when the user asks for:

- "根据 PRD 生成开发里程碑"
- "把产品文档拆成任务看板"
- "创建 Codex 多线程开发流程"
- "不同 Codex 线程怎么协作"
- "初始化项目控制台"
- "盘点当前开发进度"
- "作为开发线程领取任务"
- "作为集成线程合并和验收"

## Project Control Files

Default target path: `docs/project`.

Required files:

- `00-prd-intake.md`: original PRD, boundaries, external dependencies, acceptance stance.
- `01-feature-map.md`: full feature tracking matrix.
- `02-milestones.md`: dependency-ordered coding milestones.
- `03-task-board.md`: thread-sized executable tasks.
- `04-thread-handoff.md`: append-only thread communication log.
- `05-integration-log.md`: integration, conflict, validation, and release-readiness log.
- `prompts.md`: reusable prompts for planning, development threads, integration, and progress audits.

To initialize the files, run:

```bash
bash /Users/deng/.codex/skills/codex-project-orchestrator/scripts/init_project_control.sh .
```

The script refuses to overwrite existing files unless called with `--force`.

## Workflow

### 1. Initialize Project Control

When the user asks to create the workflow in a repo:

1. Inspect the current working directory and existing `docs/project` files.
2. Run `scripts/init_project_control.sh <repo-root>` if the files do not already exist.
3. If files already exist, read them and continue from current state instead of overwriting.
4. Tell the user which files were created or already present.

### 2. Convert PRD Into Feature Map

Read `00-prd-intake.md` and create or update `01-feature-map.md`.

Rules:

- Extract all user-facing, backend, admin, data, permission, integration, configuration, testing, and documentation requirements.
- Every feature must have ID, module, priority, status, dependencies, acceptance criteria, and verification record.
- Do not mark real external capabilities as complete unless they are actually integrated and verified.
- Split vague or bundled requirements until each item can be validated.

### 3. Create Milestones

Read `01-feature-map.md` and update `02-milestones.md`.

Rules:

- Order by dependency, not document order.
- Prioritize the P0 main path.
- Include foundations, vertical slices, integrations, hardening, docs, and final validation.
- Each milestone must have completion criteria that can be checked.

### 4. Create Task Board

Read `01-feature-map.md` and `02-milestones.md`, then update `03-task-board.md`.

Rules:

- Each task should fit one Codex thread.
- Mark file ownership and likely shared-file risks.
- Separate shared surfaces such as migrations, route registration, OpenAPI, global state, and common components.
- Use `READY` only when dependencies and validation are clear.

### 5. Run A Development Thread

When acting as a development thread:

1. Read `01-feature-map.md`, `02-milestones.md`, `03-task-board.md`, and `04-thread-handoff.md`.
2. Confirm the selected task ID and file boundary.
3. Understand project structure and call chain before editing.
4. Modify only the task's necessary scope.
5. Validate locally.
6. Update task status and verification notes in `03-task-board.md`.
7. Append a handoff entry to `04-thread-handoff.md`.

Do not let a development thread silently expand scope or integrate other threads' work.

### 6. Run An Integration Thread

When acting as an integration thread:

1. Read all project control files.
2. Identify tasks in `REVIEW` or `VERIFIED`.
3. Inspect handoff entries and changed file ranges.
4. Merge carefully, preserving correct business behavior.
5. Run full validation appropriate to the repo.
6. Update feature map, milestones, task board, and integration log.
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
- Use `04-thread-handoff.md`, not chat history, as the communication channel.
- Use one integration thread to combine work and settle conflicts.

## Output Style

When reporting to the user, keep it short:

- What changed
- Why it was structured that way
- How to verify or continue
- Which items remain blocked or unfinished

## Boundaries

This skill does not store project progress inside the skill directory. It must not be used as a substitute for Git branch isolation, code review, tests, or repository-local project state.
