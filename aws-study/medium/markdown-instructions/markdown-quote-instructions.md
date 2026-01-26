
# Markdown Quote Instructions for Medium

Medium only supports standard blockquotes. Remove callout syntax like `[!note]`, `[!tip]`, `[!warning]`, etc.

## Conversion Rules

| Original Syntax | Convert To |
| ----------------- | ------------ |
| `> [!note]` | `>` (plain blockquote) |
| `> [!tip]` | `> 💡` or `> **Tip:**` |
| `> [!important]` | `> ⚠️` or `> **Important:**` |
| `> [!warning]` | `> ⚠️` or `> **Warning:**` |
| `> [!caution]` | `> 🚨` or `> **Caution:**` |

---

## Examples

### Basic Note → Plain Blockquote

**Original:**

```markdown
> [!note]
> This is important information.
```

**Converted:**

```markdown
> This is important information.
```

---

### Tip → Prefixed Blockquote

**Original:**

```markdown
> [!tip]
> Use caching to improve performance.
```

**Converted:**

```markdown
> 💡 **Tip:** Use caching to improve performance.
```

---

### Warning → Emphasized Blockquote

**Original:**

```markdown
> [!warning]
> This action cannot be undone.
```

**Converted:**

```markdown
> ⚠️ **Warning:** This action cannot be undone.
```

---

### Multi-line Callout

**Original:**

```markdown
> [!important]
> First line of content.
> Second line of content.
```

**Converted:**

```markdown
> **Important:**
> First line of content.
> Second line of content.
```

---

## Emoji Reference

| Type | Emoji | Alternative |
| ------ | ------- | ------------- |
| Note | 📝 | **Note:** |
| Tip | 💡 | **Tip:** |
| Important | ⚠️ | **Important:** |
| Warning | ⚠️ | **Warning:** |
| Caution | 🚨 | **Caution:** |

## Best Practices

1. **Remove all callout tags** — Delete `[!note]`, `[!tip]`, etc.
2. **Add context prefix** — Use emoji or bold text to indicate type
3. **Merge lines** — Combine callout tag line with content when short
4. **Keep it simple** — For general notes, plain blockquotes work fine
