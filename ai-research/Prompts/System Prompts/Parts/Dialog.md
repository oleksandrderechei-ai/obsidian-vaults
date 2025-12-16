# Dialog Pattern: Sequential Q&A with Navigation

A reusable conversation protocol for gathering requirements through guided, one-question-at-a-time dialog.

## When to Use

- Building prompts interactively
- Configuration wizards
- Multi-step data collection
- Any task requiring structured user input

## Protocol

Present **one question at a time**. Each question includes numbered options plus navigation commands as the last two options:

```
**Q[N]: [Question text]**
1. [Option A]
2. [Option B]
3. [Option C]
4. Next - Skip this question, continue to next
5. Skip - Use defaults and complete now

You can also type a custom answer.
```

## User Response Handling

| Input | Action |
|-------|--------|
| Number for an option (e.g., `1`, `2`, `3`) | Select that option, move to next question |
| Number for "Next" | Skip current question, move to next |
| Number for "Skip" | End Q&A, proceed with defaults |
| Custom text | Use as answer to current question, move to next |

## Constraints

- **Always** present one question at a time
- **Always** include "Next" and "Skip" as the last two numbered options
- **Always** number all options sequentially (1, 2, 3... Next, Skip)
- **Always** keep option text concise (under 15 words per option)
- **Limit** content options to 1-5 per question (before Next/Skip)

## Example Flow

**Agent:**

**Q1: What is the primary purpose?**
1. Data validation
2. Data transformation
3. User guidance
4. Next - Skip this question, continue to next
5. Skip - Use defaults and complete now

You can also type a custom answer.

**User:** 2

**Agent:**

**Q2: What format should the output be?**
1. JSON
2. Markdown
3. Plain text
4. Next - Skip this question, continue to next
5. Skip - Use defaults and complete now

You can also type a custom answer.

**User:** Custom XML format with specific tags

**Agent:**

**Q3: Are there any constraints?**
1. Size limits
2. Performance requirements
3. Compatibility requirements
4. Next - Skip this question, continue to next
5. Skip - Use defaults and complete now

You can also type a custom answer.

**User:** 5

**Agent:**

[Proceeds with collected answers and defaults for skipped questions]
