# Obsidian Vaults

This repository contains my Obsidian vaults and a template for creating new ones.

## Common Practices

1. **Link Early and Often**: Use `[[WikiLinks]]` to connect ideas. Don't worry about structure initially; let it emerge.
2. **Daily Notes**: Use them as a scratchpad. Enable the "Daily Notes" core plugin.
3. **Maps of Content (MOC)**: Create index notes that link to other notes to organize topics (e.g., `[[AWS MOC]]`).
4. **Atomic Notes**: Keep notes focused on a single concept.
5. **Refactoring**: If a note gets too long, split it into smaller notes and link them back.

## How to Setup a New Vault

To create a new vault with the standard structure and templates, simply copy the `vault-template` folder.

**Terminal Command:**

```bash
# Replace 'new-vault-name' with your desired vault name
cp -r vault-template new-vault-name
```

After copying, open Obsidian and "Open folder as vault" selecting your new folder.

## Templates & Metadata

A default template is located at `./_templates/default-note.md`.

To use it:

1. Enable the **Templates** core plugin in Obsidian settings.
2. Set the "Template folder location" to `_templates`.
3. Use the command `Insert template` (or configured hotkey) in a new note.

### Tags, Aliases, and Custom Attributes

We use **YAML Frontmatter** (the block between `---` at the top of the file) to define metadata.

#### Aliases

Allow you to refer to a note by different names.

```yaml
aliases: ["AI", "Artificial Intelligence"]
```

Now `[[AI]]` and `[[Artificial Intelligence]]` will both link to this note.

#### Tags

Help categorize notes. You can use nested tags for hierarchy.

```yaml
tags: [topic/aws, cloud]
```

Or inline in the text: `#topic/aws`.

#### Custom Attributes

You can define any key-value pair for use with plugins like **Dataview**.

```yaml
status: in-progress
priority: high
reviewer: "Alex"
```

### Example Frontmatter

```yaml
---
aliases: [My Note, Important Concept]
tags: [project/alpha, status/active]
date_created: 2023-10-27
priority: high
---
```

