# NotebookLM Prompt: Corporate AI Governance and Responsible Usage Guidelines

## 🎯 Objective

Generate a comprehensive **Corporate AI Governance and Responsible Usage Guidelines** report. This document should serve as:
- An official policy document for organizational AI governance
- An educational resource accessible to employees at all levels
- A practical guide for day-to-day AI decision-making
- A compliance reference aligned with international regulations

---

## 📋 Document Structure

Generate the report with the following structure, using proper markdown formatting throughout:

---

### Cover Page
```
# Corporate AI Governance and Responsible Usage Guidelines

**Version:** 1.0  
**Effective Date:** [Current Date]  
**Document Owner:** AI Governance Team  
**Classification:** Internal Use Only

---

> "Empowering innovation through responsible AI — balancing opportunity with accountability."

---
```

---

### Table of Contents

Generate a clickable table of contents with all major sections and subsections using markdown anchor links.

---

### 1. Executive Summary

Provide a concise overview (300-400 words) covering:
- Why AI governance is a strategic imperative
- The five pillars of this policy: Responsible AI, Reputation Management, Governance & Compliance, Risk Management, Innovation
- Key obligations for all employees
- The balance between enabling innovation and managing risk

**Format:** Use a callout box for 3-5 key takeaways.

---

### 2. Responsible AI: Ethical Foundations

#### 2.1 What is Responsible AI?
Define responsible AI in a corporate context. Explain why ethics matter beyond compliance.

#### 2.2 Core Ethical Principles
Present as a table with columns: Principle | Description | Example in Practice

| Principle | Description | Example in Practice |
|:----------|:------------|:--------------------|
| **Transparency** | Be open about AI usage | Disclose AI assistance in client reports |
| **Fairness** | Avoid discriminatory outcomes | Audit hiring algorithms for bias |
| **Accountability** | Humans own AI decisions | Review all AI outputs before use |
| **Privacy** | Protect personal data | Never input PII into public AI |
| **Safety** | Prevent harm | Block dangerous content generation |
| **Sustainability** | Consider environmental impact | Prefer efficient AI models |

#### 2.3 Ethical Decision Framework
Present the 5-question framework employees should apply:

> **Before using AI, ask yourself:**
> 1. 🔍 **Transparency Test:** Would I be comfortable if this usage was made public?
> 2. ⚖️ **Fairness Test:** Could this harm or disadvantage anyone?
> 3. 👤 **Accountability Test:** Am I prepared to own the outcome?
> 4. 🔒 **Privacy Test:** Am I protecting all sensitive data?
> 5. ⚖️ **Legal Test:** Does this comply with laws and regulations?

#### 2.4 Real-World Consequences of AI Misuse
Include 3-4 documented case studies in a table:

| Incident | What Happened | Consequence | Lesson |
|:---------|:--------------|:------------|:-------|
| Air Canada Chatbot (2024) | AI provided incorrect refund policy | Company held legally liable | Always verify AI outputs |
| iTutor Group (2023) | AI rejected applicants by age | EEOC discrimination settlement | Audit AI for bias |
| Sports Illustrated (2023) | Published AI-generated fake authors | Massive credibility damage | Disclose AI content |
| Deepfake Elections (2024) | AI audio/video of political candidates | Electoral interference | Never create synthetic media |

---

### 3. Reputation Management: Protecting Trust

#### 3.1 Why Reputation Matters
Explain the connection between AI governance and brand trust.

#### 3.2 Reputational Risks from AI

| Risk Category | Description | Potential Impact |
|:--------------|:------------|:-----------------|
| **Hallucinations** | AI generates false information | Legal liability, client distrust |
| **Bias** | AI produces discriminatory outputs | PR crisis, lawsuits |
| **Data Breaches** | Sensitive data exposed via AI | Regulatory fines, customer loss |
| **Misinformation** | AI spreads inaccurate content | Brand damage, corrections |

#### 3.3 Transparency & Disclosure Guidelines
When and how to disclose AI usage:

| Context | Disclosure Required? | How to Disclose |
|:--------|:--------------------|:----------------|
| Client-facing content | ✅ Yes | "This content was created with AI assistance" |
| Internal documents | ⚠️ Recommended | Note in document metadata |
| Code generation | ✅ Yes | Comment in codebase |
| Creative/marketing | ✅ Yes | Appropriate attribution |

---

### 4. AI Governance & Compliance

#### 4.1 Regulatory Landscape
Present key regulations in a reference table:

| Regulation | Jurisdiction | Key Requirements | URL |
|:-----------|:-------------|:-----------------|:----|
| **GDPR** | EU/EEA | Data protection, consent, rights | gdpr.eu |
| **EU AI Act** | EU | Risk-based AI classification | artificialintelligenceact.eu |
| **CCPA** | California, USA | Consumer data rights | oag.ca.gov/privacy/ccpa |
| **ISO/IEC 42001** | International | AI management systems | iso.org/standard/81230.html |

#### 4.2 "Red Lines": Absolutely Forbidden Uses

> ⚠️ **CRITICAL: The following uses are strictly prohibited and may result in immediate termination.**

Present as a high-visibility table:

| 🚫 Prohibited Use | Description |
|:------------------|:------------|
| **Causing Harm** | AI designed to injure people physically or psychologically |
| **Illegal Activities** | Generating instructions for illegal acts |
| **Human Rights Violations** | Discriminatory surveillance or bias reinforcement |
| **Disinformation** | Creating deepfakes or misleading synthetic media |
| **Circumventing Controls** | Jailbreaking or bypassing AI safety filters |
| **Unauthorized Data Collection** | Scraping data without consent |

#### 4.3 Incident Reporting Process
Flowchart-style guidance:

```
INCIDENT DETECTED
       ↓
   STOP USING AI OUTPUT
       ↓
   DOCUMENT THE INCIDENT
   (Screenshots, prompts, outputs)
       ↓
   REPORT IMMEDIATELY
   → Manager + AI Governance Team
       ↓
   AWAIT INVESTIGATION
```

#### 4.4 Non-Compliance Consequences
Escalating consequences list:
1. Verbal warning
2. Written warning
3. Mandatory retraining
4. Suspension of AI tool access
5. Disciplinary action up to termination
6. Legal action where applicable

---

### 5. Practical Guidance for AI Risk Management

#### 5.1 Data Classification System

| 🔴🟠🟡🟢 | Classification | Examples | AI Usage |
|:---------|:---------------|:---------|:---------|
| 🔴 | **Restricted** | PII, credentials, health data, trade secrets | ❌ Never use with any AI |
| 🟠 | **Confidential** | Source code, strategies, customer lists | ❌ Never use with external AI |
| 🟡 | **Internal** | Business docs, processes, communications | ⚠️ Approved enterprise AI only |
| 🟢 | **Public** | Published content, open-source code | ✅ Can use with AI tools |

#### 5.2 Data Handling Rules
- **Data Minimization:** Only input what's strictly necessary
- **No Personal Data:** Never input names, emails, addresses, photos
- **No Secrets:** Never input passwords, API keys, credentials
- **No Proprietary Code:** Never input source code into public AI

#### 5.3 Data Anonymization Checklist

- [ ] Remove all direct identifiers (names, emails, phone numbers)
- [ ] Generalize quasi-identifiers (use age ranges, regions)
- [ ] Consider synthetic data alternatives
- [ ] Document anonymization methods used
- [ ] Verify re-identification risk is minimal

#### 5.4 Quality Assurance Checklist

Before using any AI-generated output:

- [ ] ✅ **Accuracy:** Facts independently verified
- [ ] ✅ **Completeness:** No critical gaps
- [ ] ✅ **Bias:** No discriminatory content
- [ ] ✅ **Tone:** Matches professional standards
- [ ] ✅ **Copyright:** No unauthorized material
- [ ] ✅ **Attribution:** AI usage disclosed if required

#### 5.5 Human Oversight Requirements

| Output Type | Review Required | Reviewer |
|:------------|:----------------|:---------|
| External communications | Mandatory | Manager or designated reviewer |
| Code for production | Mandatory | Senior developer + security review |
| Financial analysis | Mandatory | Finance team member |
| Legal/compliance content | Mandatory | Legal team |
| Internal drafts | Recommended | Self-review minimum |

---

### 6. Identifying Opportunities for Innovation

#### 6.1 Approved Use Cases

| Department | Approved AI Uses | Restrictions |
|:-----------|:-----------------|:-------------|
| **Development** | Code assistance, debugging, documentation | No proprietary code in public AI |
| **Marketing** | Content drafting, brainstorming, research | Human review required |
| **HR** | Job descriptions, interview templates | No candidate data; human decisions only |
| **Finance** | Report templates, regulatory summaries | No financial data; verify all figures |
| **Operations** | Process documentation, meeting summaries | Approved tools only |

#### 6.2 AI Tool Evaluation Process

To request a new AI tool:

1. **Submit Request** to IT Security with:
   - Tool name and vendor
   - Intended use case
   - Data types to be processed
   - Vendor security documentation

2. **Evaluation Criteria:**
   - Data privacy and security compliance
   - Enterprise-grade access controls
   - Audit logging capabilities
   - Vendor reputation and stability

3. **Approval Timeline:** 2-4 weeks typical

#### 6.3 Innovation Within Guardrails

> **💡 We encourage experimentation!** The goal of this policy is not to restrict AI usage but to enable confident, safe innovation.

**You CAN:**
- Experiment with approved AI tools
- Propose new use cases
- Suggest tools for evaluation
- Share learnings with colleagues

**You MUST:**
- Follow data classification rules
- Review all AI outputs
- Report incidents promptly
- Stay within approved use cases

---

### 7. Frequently Asked Questions (FAQ)

Present 8-10 FAQs in Q&A format with clear, actionable answers. Include questions about:
- Client data in AI tools
- IP ownership of AI-generated work
- Handling biased outputs
- Responsibility for AI errors
- Safety filter blocks
- AI in hiring
- Disclosure requirements
- Requesting new tools

---

### 8. Glossary of Key Terms

| Term | Definition |
|:-----|:-----------|
| **Generative AI** | AI that creates new content (text, images, code) |
| **Hallucination** | AI generating false or nonsensical information |
| **Prompt Injection** | Malicious attempt to override AI instructions |
| **PII** | Personally Identifiable Information |
| **Jailbreaking** | Bypassing AI safety controls |
| **Synthetic Data** | Artificially generated data mimicking real data |

---

## 🎨 Formatting Requirements

1. **Headings:** Use proper hierarchy (# ## ### ####)
2. **Tables:** Use markdown tables with alignment
3. **Callouts:** Use blockquotes (>) for warnings, tips, and important notes
4. **Emojis:** Use sparingly for visual scanning (⚠️ ✅ ❌ 🔴 🟢 💡)
5. **Checklists:** Use `- [ ]` for actionable items
6. **Code blocks:** Use for structured processes or templates
7. **Bold:** Use for key terms and emphasis
8. **Horizontal rules:** Use `---` to separate major sections

---

## 🎯 Key Messages to Reinforce Throughout

1. **Responsible AI** — Ethics and human oversight are non-negotiable
2. **Reputation Management** — AI failures damage trust; prevention is essential
3. **AI Governance** — Compliance protects the organization and individuals
4. **Practical Guidance** — Clear rules enable confident decision-making
5. **Innovation Opportunity** — Guardrails enable, not restrict, innovation

---

## 📚 Authoritative Sources to Reference

| Source | URL | Use For |
|:-------|:----|:--------|
| EU GDPR | gdpr.eu | Data protection requirements |
| EU AI Act | artificialintelligenceact.eu | Risk classification, compliance |
| CCPA | oag.ca.gov/privacy/ccpa | California data rights |
| Google AI Principles | ai.google/responsibility/principles | Ethical framework |
| OECD AI Principles | oecd.ai/en/ai-principles | International standards |
| ISO/IEC 42001 | iso.org/standard/81230.html | AI management systems |

---

## ✅ Output Checklist

Before finalizing, ensure the report includes:

- [ ] Cover page with metadata
- [ ] Clickable table of contents
- [ ] Executive summary with key takeaways
- [ ] All 6 main content sections fully developed
- [ ] Minimum 10 tables for structured information
- [ ] 3+ callout boxes for warnings/tips
- [ ] 2+ checklists for actionable guidance
- [ ] FAQ section with 8+ questions
- [ ] Glossary of terms
- [ ] Document control table
- [ ] Consistent formatting throughout
- [ ] All source URLs included