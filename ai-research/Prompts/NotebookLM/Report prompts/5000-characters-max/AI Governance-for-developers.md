# NotebookLM Prompt: AI Governance for Software Development

## Objective

Generate **AI Governance Guidelines for Software Development Teams** covering responsible AI use, code security, IP protection, MCP governance, and Shadow AI prevention.

---

## Document Structure

### 1. Executive Summary (250 words)

- Why AI governance matters for development teams
- Key risks: IP leakage, vulnerabilities, Shadow AI, MCP misuse, licensing
- Five pillars: Security, Code Quality, IP Protection, Compliance, Innovation

### 2. Approved AI Tools

| Tool | Use Case | Status |
| ---- | -------- | ------ |
| GitHub Copilot Enterprise | Code completion | ✅ Approved |
| Claude/ChatGPT Enterprise | Code review, docs | ✅ Approved |
| Company-hosted LLMs | All dev tasks | ✅ Approved |
| ChatGPT/Claude Free | General queries only | ⚠️ No code |
| AI browser extensions | — | ❌ Prohibited |

### 3. Shadow AI: Hidden Risks

> ⚠️ **Shadow AI** = Unapproved AI tools (personal ChatGPT, browser extensions, unapproved IDE plugins)

**3.1 Shadow AI Risks:**

| Risk | Impact |
| ---- | ------ |
| Data leakage | Proprietary code exposed |
| Model training | Your code trains public AI |
| No audit trail | Incident response impossible |
| License contamination | Copyleft code introduced |

**3.2 Shadow AI Policy:**

- ❌ No proprietary code in unapproved tools
- ❌ No personal AI accounts for work code
- ❌ No unapproved browser extensions/plugins
- ✅ Request new tools through Security + IT

### 4. MCP (Model Context Protocol) Governance

> ⚠️ **MCP** enables AI to access files, execute commands, connect to databases

**4.1 MCP Risks:**

| Risk | Severity |
| ---- | -------- |
| Unauthorized file/DB access | 🔴 Critical |
| Command injection | 🔴 Critical |
| Credential exposure | 🔴 Critical |
| Data exfiltration | 🔴 Critical |

**4.2 MCP Requirements:**

- ✅ Security team approval mandatory
- ✅ Sandboxed environments only
- ✅ Audit logging enabled
- ❌ No production access
- ❌ No secrets/credentials access
- ❌ No customer data access

### 5. Code Security & Data Protection

**5.1 Never Input Into AI:**

| 🚫 Prohibited | Examples |
| ------------- | -------- |
| Proprietary code | Core algorithms, business logic |
| Secrets | API keys, passwords, tokens |
| Customer data | PII, user content |
| Security code | Auth, encryption, access control |
| Infrastructure | Network configs, deployment scripts |

**5.2 Safe Inputs:**

- ✅ Generic patterns (no proprietary impl)
- ✅ Open-source snippets (license-aware)
- ✅ Syntax/framework questions
- ✅ Sanitized error messages

### 6. Code Review Requirements

**6.1 AI Code Risks:**

| Risk | Mitigation |
| ---- | ---------- |
| Security vulnerabilities | SAST + review |
| Hallucinated APIs | Verify against docs |
| License contamination | License scanning |
| Hidden bugs | Thorough testing |

**6.2 Review Checklist:**

- [ ] Security review (OWASP Top 10)
- [ ] Code compiles and runs
- [ ] Unit tests passing
- [ ] No hardcoded secrets
- [ ] License verified
- [ ] Peer review completed
- [ ] AI use documented in commit

### 7. IP & Licensing

| License Type | Risk | Action |
| ------------ | ---- | ------ |
| MIT, Apache, BSD | 🟢 Low | Include attribution |
| GPL, LGPL, AGPL | 🔴 High | Legal review required |
| Unknown | 🟠 Medium | Do not use |

### 8. Incident Response

```text
INCIDENT → STOP AI USE → REVOKE SECRETS → DOCUMENT → REPORT TO SECURITY → REMEDIATE
```

**When to Report:** Secrets in AI, vulnerabilities found, license violations, Shadow AI discovered, unauthorized MCP

### 9. Do's & Don'ts

✅ **Do:** Use approved tools, review all AI code, test thoroughly, document AI in commits, report incidents
❌ **Don't:** Paste proprietary code, input secrets, trust AI blindly, use personal accounts, install unapproved MCP

### 10. FAQ

Cover: Copilot for client projects, copyrighted code suggestions, AI for security-sensitive code, disclosing AI use, Shadow AI consequences, MCP approval process, browser extensions policy

### 11. Glossary

Define: Shadow AI, MCP, SAST, Hallucination, Copyleft, Prompt injection, Code telemetry

---

## Formatting

Markdown tables, checklists, blockquotes for warnings, emojis (⚠️✅❌🔴🟢)

## Sources

OWASP AI Security, GitHub Copilot Trust Center, MCP Specification, GDPR, EU AI Act, ISO 27001