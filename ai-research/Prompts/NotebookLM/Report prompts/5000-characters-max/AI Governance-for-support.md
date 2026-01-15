# NotebookLM Prompt: AI Governance for Customer Support

## Objective

Generate **AI Governance Guidelines for Customer Support Teams** covering responsible AI use for customer interactions, data protection, response accuracy, and maintaining trust.

---

## Document Structure

### 1. Executive Summary (250 words)

- Why AI governance matters for support teams
- Key risks: incorrect information, customer data exposure, trust erosion
- Balance efficiency with accuracy and empathy

### 2. Approved AI Tools

**2.1 Approved Tools Table:**

| Tool | Use Case | Status |
| ----- | --------- | ------- |
| Company chatbot/copilot | Response drafting, KB search | ✅ Approved |
| Enterprise AI (Claude/GPT) | Complex case research | ✅ Approved |
| CRM-integrated AI | Case summaries, sentiment | ✅ Approved |
| Public AI tools | General learning only | ⚠️ Restricted |

### 3. Shadow AI: Hidden Risks

> ⚠️ **Shadow AI** = Unapproved AI tools used without IT/Security knowledge

**3.1 Shadow AI Risks for Support:**

| Risk | Impact |
| ----- | ------- |
| Customer data exposure | PII leaked to third parties |
| Incorrect responses | Wrong info sent to customers |
| Compliance violation | GDPR/regulatory breach |
| No audit trail | Cannot track what was shared |

**3.2 Shadow AI Policy:**

- ❌ No customer data in unapproved tools
- ❌ No browser extensions without approval
- ❌ No copy-pasting tickets into public AI
- ✅ Request new tools through Support Ops + IT

### 4. Customer Data Protection

**4.1 Never Input Into AI:**

| 🚫 Prohibited | Examples | Risk |
| -------------- | --------- | ----- |
| Customer PII | Names, emails, phone, addresses | Privacy breach |
| Account details | Account numbers, passwords | Security risk |
| Payment info | Card numbers, billing data | PCI violation |
| Support tickets (raw) | Full ticket with customer details | Data exposure |
| Internal customer notes | Sensitive case history | Confidentiality breach |

**4.2 Data Classification:**

| Level | Examples | AI Usage |
| ------ | --------- | --------- |
| 🔴 Restricted | Customer PII, payment data | ❌ Never |
| 🟠 Confidential | Account details, case history | ❌ No external AI |
| 🟡 Internal | Generic procedures, templates | ⚠️ Approved tools only |
| 🟢 Public | Published KB articles, FAQs | ✅ Allowed |

**4.3 Safe AI Usage:**

- ✅ Ask about general product features
- ✅ Draft responses without customer details
- ✅ Research troubleshooting steps
- ✅ Summarize anonymized issues

### 5. Response Quality & Accuracy

**5.1 AI Response Risks:**

| Risk | Description | Mitigation |
| ----- | ------------ | ----------- |
| Hallucinations | AI invents policies or features | Verify against KB |
| Outdated info | AI doesn't know recent changes | Check current docs |
| Wrong tone | Too casual or robotic | Human review |
| Over-promising | AI commits to impossible solutions | Validate capabilities |
| Air Canada case | Chatbot gave wrong refund policy → legal liability | Always verify |

**5.2 Response Checklist:**

- [ ] Information verified against official KB/docs
- [ ] No customer PII in AI prompt
- [ ] Tone appropriate for situation
- [ ] Promises are actually deliverable
- [ ] Escalation path included if needed
- [ ] Human reviewed before sending

### 6. AI Disclosure to Customers

| Scenario | Disclosure? | How |
| --------- | ------------ | ---- |
| AI-drafted response (human reviewed) | ⚠️ Follow company policy | Per guidelines |
| Fully automated chatbot | ✅ Required | Clear bot identification |
| AI-assisted live chat | ⚠️ Recommended | Transparency builds trust |
| Customer asks directly | ✅ Always honest | Acknowledge AI assistance |

### 7. Red Lines: Forbidden Uses

| 🚫 Prohibited | Reason |
| -------------- | ------- |
| Sharing customer data externally | Privacy/legal violation |
| Making unauthorized commitments | Liability risk |
| Diagnosing medical/legal issues | Professional liability |
| Dismissing customer with AI-only response | Customer trust |
| Using AI to deceive customers | Ethics violation |

### 8. Escalation & Incidents

```text
ISSUE DETECTED → STOP AI USE → CORRECT WITH CUSTOMER → DOCUMENT → REPORT → IMPROVE
```

**When to Escalate:**

- AI gave customer wrong information
- Customer data accidentally input into AI
- AI response caused customer complaint
- Unsure if AI response is accurate

### 9. Do's & Don'ts

✅ **Do:** Verify AI responses, protect customer data, maintain empathy, disclose when asked, escalate uncertainties
❌ **Don't:** Use Shadow AI, paste customer details, trust AI blindly, over-promise, replace human judgment

### 10. FAQ

Cover: Using AI for angry customers, AI for technical troubleshooting, handling AI mistakes with customers, customer data boundaries, when to override AI suggestions

### 11. Glossary

Define: Shadow AI, Hallucination, PII, Sentiment analysis, Canned response, Escalation

---

## Formatting

Markdown tables, checklists, blockquotes for warnings, emojis (⚠️✅❌🔴🟢)

## Sources

GDPR, CCPA, PCI-DSS, EU AI Act, Customer service best practices
