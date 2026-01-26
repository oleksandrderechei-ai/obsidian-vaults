
# Markdown Table Instructions for Medium

Medium does not support markdown tables. Convert tables to readable sections or lists.

## Conversion Strategies

### 1. Definition Lists (Best for Key-Value Data)

**Original Table:**

```markdown
| Feature | Description |
|---------|-------------|
| Caching | Reduces API calls |
| Batching | Groups requests |
```

**Converted:**

```markdown
**Caching** — Reduces API calls

**Batching** — Groups requests
```

---

### 2. Bullet Lists (Best for Simple Comparisons)

**Original Table:**

```markdown
| Model | Context | Price |
|-------|---------|-------|
| Claude 3 | 200K | $15 |
| GPT-4 | 128K | $30 |
```

**Converted:**

```markdown
- **Claude 3**: 200K context, $15
- **GPT-4**: 128K context, $30
```

---

### 3. Numbered Lists (Best for Ranked/Ordered Data)

**Original Table:**

```markdown
| Rank | Provider | Score |
|------|----------|-------|
| 1 | Anthropic | 95 |
| 2 | OpenAI | 90 |
```

**Converted:**

```markdown
1. **Anthropic** — Score: 95
2. **OpenAI** — Score: 90
```

---

### 4. Grouped Sections (Best for Complex Multi-Column Tables)

**Original Table:**

```markdown
| Category | Feature | Status | Notes |
|----------|---------|--------|-------|
| Security | Encryption | ✅ | AES-256 |
| Security | MFA | ✅ | Required |
| Compliance | SOC2 | ✅ | Certified |
```

**Converted:**

```markdown
**Security**
- Encryption: ✅ (AES-256)
- MFA: ✅ (Required)

**Compliance**
- SOC2: ✅ (Certified)
```

---

## Selection Guide

| Table Type | Recommended Format |
| ------------ | ------------------- |
| 2 columns (key-value) | Definition lists |
| 3+ columns (simple) | Bullet lists |
| Ranked/ordered data | Numbered lists |
| Grouped categories | Sectioned lists |
| Complex comparisons | Multiple sections with headers |

## Tips

- Use **bold** for the primary identifier (name, key, category)
- Use em dash (—) or colon (:) as separators
- Keep each item on a single line when possible
- Group related items under subheadings for large tables
