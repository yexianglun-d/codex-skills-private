# 刘颖 Skill 更新协议

Use this file when updating the skill from a newer WeFlow export or new chat snippets.

## Goals

- Preserve stable long-term profile.
- Add recent changes without overfitting to one bad day.
- Keep raw private chat out of the skill except for very short, necessary evidence snippets.
- Mark facts and inferences with confidence.

## Update Frequency

- Normal: every 2-4 weeks.
- Immediate: after major conflict, meeting, birthday/anniversary, work change, relationship-stage change, or repeated "not like her" outputs.
- Recent state: update with the latest 14-30 days when daily reply quality matters.

## Procedure

1. Inspect export metadata: date range, message count, sender identity.
2. Compare new window against existing files:
   - `relationship-knowledge.md`: facts, preferences, dislikes, gifts, dates.
   - `style-profile.md`: wording, endings, nicknames, reply rhythm.
   - `inner-model.md`: deep needs and stable relationship logic.
   - `conflict-playbook.md`: new conflict patterns and repair lessons.
   - `scenario-playbook.md`: new daily scenarios.
   - `recent-state.md`: recent stressors and short-term mood.
   - `intimacy-model.md`: intimacy signals, consent, boundaries.
3. Update only changed or newly supported claims.
4. For uncertain items, place under `待确认`.
5. Avoid adding long raw messages; summarize and include date-level evidence when useful.
6. Run skill validation.

## Confidence Rules

- `确定`: directly stated and not contradicted, or confirmed repeatedly.
- `高置信`: repeated behavior or strong pattern.
- `推断`: likely inner logic; must be phrased as inference.
- `待确认`: insufficient evidence, old state, or contradictory signals.

## Commands

Validate:

```bash
python3 /Users/deng/.codex/skills/.system/skill-creator/scripts/quick_validate.py /Users/deng/.codex/skills/liu-ying-chat-style
```

Useful local source:

```text
/Users/deng/Desktop/私聊_可爱颖宝宝.json
```

## Do Not

- Do not overwrite the stable profile with only the newest day's mood.
- Do not infer consent from old sexual or intimate messages.
- Do not claim "刘颖一定会..." for inner motives.
- Do not expose full private chat excerpts in normal answers.
