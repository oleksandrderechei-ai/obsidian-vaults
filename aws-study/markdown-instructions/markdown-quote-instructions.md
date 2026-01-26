
# Markdown Quote Instructions

Use appropriate callout types based on the content purpose.

## Selection Rules

1. **For compliance/regulatory content**: Use `[!important]` for requirements, `[!warning]` for review items
2. **For technical notices**: Use `[!note]` for general info, `[!tip]` for optimization
3. **For risk communication**: Use `[!warning]` for medium risk, `[!caution]` for high risk
4. **Avoid overuse**: Don't use callouts for every paragraph - reserve for truly notable items

## Syntax

**IMPORTANT**: Callout syntax requires two lines:

1. **First line**: Callout type declaration (e.g., `> [!note]`)
2. **Second line**: Content text (e.g., `> Information callout`)

```markdown
> [!note]
> Information callout
```

## Examples

> [!note]
> Information callout
___
> [!tip]
> Helpful suggestion
___
> [!important]
> Critical information
___
> [!warning]
> Warning (yellow)
___
> [!caution]
> Strong warning
