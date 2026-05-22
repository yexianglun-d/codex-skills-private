# Output Framework

Use one of these patterns depending on how much detail the user needs.

## Pattern A: Lean Technical Design

Use for quick alignment when the user wants a compact technical approach.

Output:

1. System summary
2. Recommended architecture
3. Core modules
4. Data model
5. API/service shape
6. Main risks

## Pattern B: Full Technical Design Doc

Use when the user wants a document that engineering can start from.

Output:

1. Context and assumptions
2. Technical goals and constraints
3. Architecture diagram in prose
4. Major components
5. Data model
6. Interface design
7. Core flows
8. Integration points
9. Security/privacy concerns
10. Performance and scale considerations
11. Failure modes
12. Implementation sequence
13. Open questions

## Pattern C: Feature-Level Solution Spec

Use when the user wants the design for one feature instead of the whole product.

Output:

1. Feature goal
2. Scope
3. Affected components
4. Data changes
5. API/UI contract changes
6. State transitions
7. Error handling
8. Test considerations
9. Rollout notes

## Quality Bar

A strong output should:

- connect architecture to product behavior
- define boundaries clearly
- reduce ambiguity for engineers
- avoid overengineering
- make hidden assumptions visible
