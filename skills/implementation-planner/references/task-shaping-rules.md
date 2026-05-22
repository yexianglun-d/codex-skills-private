# Task Shaping Rules

Use these rules to keep implementation plans useful.

## Rule 1: Split by dependency, not by document headings

Tasks should follow build order and ownership boundaries, not the order that topics appear in the design doc.

## Rule 2: Prefer vertical slices when possible

A task that produces a thin end-to-end path is often better than many disconnected horizontal tasks.

Examples:

- Better: "Implement workout record creation flow from form to storage to confirmation state"
- Worse: "Do all frontend forms", "do all APIs", "do all database work"

## Rule 3: Keep tasks reviewable

A good task should be understandable, implementable, and reviewable in one pass. If it spans too many moving pieces, split it.

## Rule 4: Attach proof of completion

Each task should imply how completion will be checked:

- command
- test
- screen flow
- API response
- artifact

## Rule 5: Pull risky work forward

Move these earlier in the plan:

- third-party integrations
- migrations
- auth or permissions
- performance-sensitive foundations
- environment setup that can block the whole project

## Rule 6: Separate hardening from initial enablement

First make the core path work. Then improve observability, resilience, edge cases, and release confidence.

## Rule 7: Stop before fake precision

Do not invent day-by-day scheduling or team assignments unless the user asks for that level of detail. This skill should produce a strong implementation plan, not fictional project tracking.
