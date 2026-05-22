---
name: implementation-planner
description: Turn a technical design, architecture plan, feature spec, or implementation approach into an execution plan. Use when Codex is asked questions like "基于这份技术方案怎么拆开发任务", "给我开发计划、验收标准和测试计划", "把这个系统拆成阶段、任务和交付检查点", or needs to produce implementation phases, work breakdown, task dependencies, acceptance criteria, validation checklist, and release-readiness plans. Do not use when the main job is product ideation, technical architecture design, or bug root-cause analysis.
---

# Implementation Planner

## Overview

Treat the technical direction as sufficiently decided to plan execution. The goal is to convert design into an ordered, testable, reviewable implementation plan that reduces ambiguity during build-out.

Make the plan actionable. Avoid vague project-management language that does not tell engineering what to build first, how to verify it, or what "done" means.

## Trigger Phrases

Use this skill when the request sounds like:

- "基于这份技术设计，给我开发计划。"
- "把这个方案拆成开发任务和阶段。"
- "帮我写验收标准和测试计划。"
- "这个系统应该先做什么、后做什么？"
- "把实现顺序、依赖关系和交付检查点列出来。"

## Working Stance

- Plan from dependency order, not from document order.
- Break work into units that are implementable and verifiable.
- Attach acceptance criteria to every meaningful deliverable.
- Include test thinking during planning, not after implementation.
- Keep early phases biased toward reducing uncertainty and enabling integration.

## Core Workflow

1. Read the design and identify the build spine.
   Find the minimum technical path that unlocks the rest of implementation.
2. Cut the work into phases.
   Separate foundation, vertical slices, integrations, hardening, and release preparation where appropriate.
3. Break phases into tasks.
   Each task should have a clear output, owner shape, dependency, and verification path.
4. Add acceptance criteria.
   Define what must be true for the task to count as done.
5. Add test planning.
   Specify what should be covered by unit, integration, end-to-end, manual QA, or release checks.
6. Call out blockers and sequencing risks.
   Surface hidden dependencies, external approvals, migrations, or environment constraints.
7. Package the result.
   Deliver a plan that a team or solo builder can execute without reinterpreting the design from scratch.

## Default Output

Unless the user asks for a narrower format, organize the answer around:

1. Build strategy
2. Execution phases
3. Task breakdown by phase
4. Dependencies and sequencing
5. Acceptance criteria
6. Test plan
7. Delivery checkpoints
8. Risks and open items

## Decision Rules

- If a task cannot be verified, it is too vague and needs to be rewritten.
- If a task spans multiple domains with different dependencies, split it.
- If a feature has user-visible behavior, include acceptance criteria and at least one test strategy.
- If an integration or migration can block progress, schedule it earlier than downstream work.
- If the system is MVP-stage, prefer fewer larger phases with sharp checkpoints instead of overproduced project bureaucracy.

## Use The References

- Read [references/planning-workflow.md](references/planning-workflow.md) for the end-to-end implementation planning sequence.
- Read [references/acceptance-and-testing.md](references/acceptance-and-testing.md) for task completion and validation rules.
- Read [references/task-shaping-rules.md](references/task-shaping-rules.md) to keep task granularity and sequencing clean.

## Boundaries

Do not use this skill when the main job is:

- deciding what product to build
- designing system architecture from scratch
- debugging implementation failures after coding starts
- writing the code itself

For those cases, use the product, technical-design, or bug-fixing skills instead.
