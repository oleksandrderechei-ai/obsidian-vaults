# Markdown Headings Instructions for Medium

Medium only supports H1 (`#`) and H2 (`##`) headings. Convert deeper heading levels to alternative formatting.

## Conversion Rules

- `#` H1 → Keep as `#` (article title only)
- `##` H2 → Keep as `##` (main sections)
- `###` H3 → **Bold text** on its own line
- `####` H4 → **Bold text** with em dash
- `#####` H5+ → *Italic bold* or inline bold

---

## Examples

### H3 → Bold Text

**Original:**

```markdown
## API Configuration

### Authentication
Content here...

### Rate Limiting
Content here...
```

**Converted:**

```markdown
## API Configuration

**Authentication**

Content here...

**Rate Limiting**

Content here...
```

---

### H4 → Bold with Separator

**Original:**

```markdown
### Security Settings

#### Encryption
Details...

#### Access Control
Details...
```

**Converted:**

```markdown
**Security Settings**

**Encryption** — Details...

**Access Control** — Details...
```

---

### Deep Nesting → Indented Lists

**Original:**

```markdown
## Features

### Compute

#### EC2

##### Instance Types
- t3.micro
- t3.small
```

**Converted:**

```markdown
## Features

**Compute**

- **EC2**
  - *Instance Types*: t3.micro, t3.small
```

---

## Best Practices

1. **Flatten hierarchy** — Aim for maximum 3 logical levels (H2 → Bold → List)
2. **Use H1 sparingly** — Reserve for article title only
3. **Add spacing** — Insert blank line before and after bold "headings"
4. **Combine short sections** — Merge related H3/H4 sections when possible
5. **Use lists for H4+** — Convert deep nesting to structured bullet points

## Quick Reference

```markdown
# Article Title (H1 - use once)

## Main Section (H2 - primary divisions)

**Subsection** (replaces H3)

Content paragraph...

**Another Subsection** (replaces H3)

- **Item Category** — Description (replaces H4+)
- **Another Category** — Description
```
