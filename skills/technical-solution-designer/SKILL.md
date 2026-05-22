---
name: technical-solution-designer
description: Turn a product plan, PRD, feature spec, or MVP definition into a concrete technical design. Use when Codex is asked to answer questions like "基于这个产品方案，技术上该怎么设计", "把这份 PRD 转成技术文档", "给我系统架构、数据模型、接口和模块拆分", or needs to produce architecture, services, data structures, APIs, state flow, integration points, technical risks, and implementation-ready engineering decisions. Do not use when the main goal is product ideation, market validation, or task-by-task project scheduling.
---

# Technical Solution Designer

## Overview

Treat the product direction as already defined enough to design against. The goal is to translate product intent into engineering structure, interfaces, constraints, and delivery-grade technical decisions.

Produce designs that are specific enough for implementation and review. Avoid generic architecture talk that does not resolve concrete system boundaries or data behavior.

## Trigger Phrases

Use this skill when the request sounds like:

- "基于这份产品文档，给我技术方案。"
- "把这个产品方案转成技术设计文档。"
- "这个系统应该怎么做架构、接口和数据表？"
- "帮我设计模块边界、状态流和数据模型。"
- "从工程实现角度把这个 MVP 落下来。"

## Working Stance

- Start from product behavior, then derive architecture.
- Prefer explicit boundaries: source of truth, ownership, interface contracts, lifecycle.
- Keep the design proportional to the product stage. MVP systems do not need enterprise ceremony.
- Surface tradeoffs instead of pretending one stack choice is universally correct.
- Resolve the minimum set of decisions needed for implementation to proceed cleanly.

## Core Workflow

1. Read the product intent.
   Capture target users, core flows, non-negotiable features, expected scale, and business constraints.
2. Identify the technical shape.
   Determine client surfaces, backend responsibilities, storage needs, external integrations, and operational concerns.
3. Model the core objects.
   Define entities, state, relationships, and invariants that make the product work.
4. Design the request and event flow.
   Specify how data enters, changes, synchronizes, and is exposed to different parts of the system.
5. Cut the modules.
   Separate domains, services, components, and integration boundaries clearly enough to avoid overlap and accidental coupling.
6. Choose the critical technical patterns.
   Decide auth, caching, background work, real-time updates, offline behavior, and error handling only where the product actually needs them.
7. Expose the risks.
   Call out scale limits, security/privacy risks, consistency risks, and implementation traps.
8. Package the output.
   Deliver a document an engineer can build from and a reviewer can challenge.

## Default Output

Unless the user asks for a narrower format, organize the answer around:

1. System overview
2. Technical goals and constraints
3. Architecture and major components
4. Data model
5. API or service interface design
6. Core flows and state transitions
7. Third-party integrations
8. Security, permissions, and privacy boundaries
9. Performance and scale considerations
10. Implementation sequence
11. Risks and open questions

## Decision Rules

- If the product doc is vague, make assumptions explicit instead of hiding them.
- If the product is early-stage, prefer simpler architecture that preserves changeability.
- If a design choice only matters at later scale, mention it as a future concern rather than overbuilding v1.
- If the user asks for technical design, include data and interface design, not just stack names.
- If the system touches payments, health, identity, or sensitive user data, raise security and privacy requirements as first-class design constraints.

## Use The References

- Read [references/solution-workflow.md](references/solution-workflow.md) for the end-to-end technical design sequence.
- Read [references/output-framework.md](references/output-framework.md) for reusable output patterns.
- Read [references/design-rules.md](references/design-rules.md) for architecture and scoping rules.

## Boundaries

Do not use this skill when the main job is:

- inventing the product concept from scratch
- judging whether the product is viable enough to pursue
- producing sprint-by-sprint project management plans
- writing production code directly

For those cases, use a separate product or implementation-planning skill.
