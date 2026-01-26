# AWS Bedrock Data Residency: Which Models Actually Keep Your Data Safe?

## GDPR, EU AI Act, ISO 42001—here's what enterprise teams need to know about vendor data access, DPAs, and choosing compliant foundation models.

---

"We assumed all Bedrock models were the same for compliance."

That assumption cost one team three months of rework when their legal team discovered the model they'd built on didn't have a proper Data Processing Agreement for EU deployment.

Here's the uncomfortable truth: **not all models in AWS Bedrock are created equal for compliance**. Some are AWS-sold with zero vendor access. Others require vendor EULAs with California jurisdiction. A few are from China-based companies with murky data terms.

This guide breaks down the actual compliance posture of every provider in Bedrock—with direct quotes from source documents.

---

## The Core Distinction: AWS-Sold vs Vendor-Sold

The single most important thing to understand about Bedrock compliance:

**AWS-sold models** = AWS operates everything. The model provider has zero access to your data, prompts, or completions.

**Vendor-sold models** = The vendor's EULA applies. You need to verify their data processing terms, jurisdiction, and DPA availability.

From AWS's own documentation:

> *"Amazon Bedrock has a concept of a Model Deployment Account—in each AWS Region where Amazon Bedrock is available, there is one such deployment account per model provider. These accounts are owned and operated by the Amazon Bedrock service team. Model providers don't have any access to those accounts."*

This is huge. For AWS-sold models, the provider literally cannot access your data—even if they wanted to.

---

## The Quick Reference: Which Models Are Safe for EU?

Here's the bottom line, organized by compliance strictness:

**STRICTEST (GDPR + EU AI Act + ISO 42001)**

- Amazon Nova, Amazon Titan
- Anthropic Claude (EU entity: Ireland, explicit DPA)
- Mistral (EU entity: France, GDPR-native)

**STANDARD (GDPR-compliant)**

- All above, plus:
- Meta Llama (AWS-sold, no vendor access)
- Google Gemma (AWS-sold, no vendor access)
- NVIDIA NeMo (AWS-sold, no vendor access)
- OpenAI GPT-OSS (AWS-sold, open variants only)

**REVIEW REQUIRED**

- DeepSeek (AWS-sold, but China-origin—verify org policy)
- Twelve Labs (strong terms, but US jurisdiction—request DPA)
- Writer AI (strong terms, but US jurisdiction—request DPA)

**ASSESS CAREFULLY**

- MiniMax (China-based, vendor-sold)
- Moonshot AI (China-based, vendor-sold)

---

## AWS's Core Guarantees

Before diving into vendor specifics, here's what AWS guarantees for all Bedrock usage:

**No Logging** — *"Amazon Bedrock doesn't store or log your prompts and completions"*

**No Training** — *"Amazon Bedrock doesn't use your prompts and completions to train any AWS models"*

**No Distribution** — *"[AWS] doesn't distribute them to third parties"*

**Encryption** — *"All data is encrypted in transit using TLS 1.2"*

These apply regardless of which model you use. But vendor-specific terms layer on top.

---

## Provider-by-Provider Analysis

### Anthropic (Claude) — RECOMMENDED for EU

This is the gold standard for third-party compliance on Bedrock.

**Key findings:**

- **Sold by**: Anthropic (vendor-sold, but with strong terms)
- **Vendor data access**: None — *"Anthropic may not train models on Customer Content"*
- **EU entity**: Yes — *"Anthropic Ireland, Limited"* for EEA/Switzerland/UK
- **Jurisdiction**: Ireland (EU) for European customers, California for US
- **DPA**: Explicit DPA with Standard Contractual Clauses

**Why this matters**: Anthropic established an Irish entity specifically for EU compliance. They have a proper DPA with SCCs. Their terms explicitly prohibit training on your data.

**Verdict**: 🟢 Suitable for GDPR, EU AI Act, ISO 42001

---

### Mistral — RECOMMENDED for EU

Perhaps the cleanest option for EU compliance.

**Key findings:**

- **Sold by**: AWS (not Mistral)
- **Vendor data access**: Metadata only — *"AWS may share... Account Information and usage information (but not Your Content)"*
- **EU entity**: Yes — Mistral AI is Paris, France-based (GDPR-native)
- **DPA**: AWS DPA covers (since AWS-sold)

**What's shared**: AWS Account ID, region, model ID, request count, token usage, timestamps.

**What's NOT shared**: Prompts, completions, or any content you send/receive.

**Verdict**: 🟢 Excellent for EU — GDPR-native company, no content shared

---

### Meta (Llama) — SOLID CHOICE

**Key findings:**

- **Sold by**: AWS (not Meta)
- **Vendor data access**: None — Meta has zero access to AWS deployments
- **Training on data**: Not possible — model runs in AWS isolation
- **DPA**: AWS DPA covers (since AWS-sold)

**Note**: Llama models are AWS-sold. Meta has zero access to prompts, completions, or AWS infrastructure.

**Verdict**: 🟢 Excellent — AWS-hosted, open license, no vendor data access

---

### DeepSeek — VERIFY POLICY

**Key findings:**

- **Sold by**: AWS (not DeepSeek)
- **Vendor data access**: None — DeepSeek has zero access to AWS deployments
- **DPA**: AWS DPA covers (since AWS-sold)

**The caveat**: DeepSeek models are developed by Hangzhou DeepSeek AI (China). While AWS-sold with no vendor data access, some organizations have policy restrictions on China-origin AI models.

**Verdict**: 🟢 AWS-sold with no vendor access — verify organizational China-origin policies

---

### Twelve Labs — REVIEW REQUIRED

**Key findings:**

- **Sold by**: Twelve Labs (vendor-sold)
- **Vendor data access**: None — *"Provider will not have access to your Inputs and Outputs"*
- **Training on data**: Prohibited — *"we cannot and will not train, develop, or improve our Services with your Inputs or Outputs"*
- **EU entity**: No — Delaware corporation, USA
- **Jurisdiction**: California, USA
- **DPA**: Not explicitly referenced

**The gap**: Strong data protection terms, but US governing law and no explicit DPA.

**Verdict**: 🟡 Strong data terms — request DPA for EU compliance

---

### Writer AI — REVIEW REQUIRED

**Key findings:**

- **Sold by**: Writer AI (vendor-sold)
- **Vendor data access**: None — *"We have no rights under this EULA to access your AWS account"*
- **Training on data**: Prohibited — *"We will not train, develop, or improve our Services with your Inputs or Outputs"*
- **EU entity**: No — Writer, Inc. USA
- **Jurisdiction**: California, USA
- **DPA**: Not explicitly referenced

**The gap**: Same as Twelve Labs—excellent data terms, but US jurisdiction.

**Verdict**: 🟡 Strong data terms — request DPA for EU compliance

---

### MiniMax & Moonshot AI — ASSESS CAREFULLY

Both are China-based AI companies with vendor-sold models.

**Concerns:**

- China-based entities
- Data processing terms not explicitly documented
- No clear DPA availability
- Organizational China-origin policies may apply

**Verdict**: 🟡 Request explicit data processing terms; verify China-origin policy compliance

---

## EU AI Act Readiness

The EU AI Act requires specific controls for high-risk AI systems. Here's how Bedrock supports compliance:

**Risk Management** — Guardrails, Evaluations for content filtering and accuracy testing

**Data Governance** — No training on customer data, documented in service terms

**Record-Keeping** — CloudTrail, CloudWatch for audit logging

**Transparency** — Model cards, service documentation

**Human Oversight** — Guardrails with approval workflows, human-in-the-loop options

**Provider Readiness:**

- 🟢 Amazon, Anthropic, Mistral — Strong transparency, safety features, comprehensive documentation
- 🟢 Meta, NVIDIA — Good model cards, acceptable use policies
- 🟡 Others — Assess individually

---

## ISO/IEC 42001:2023 Alignment

For organizations pursuing AI management certification:

**Core AWS Bedrock capabilities that support ISO 42001:**

- **AI impact assessment** — Bedrock Evaluations for accuracy, bias, safety
- **Data for AI systems** — No training on customer data, data isolation
- **Documentation** — Model cards, API documentation
- **Accountability** — CloudTrail audit logs, IAM policies
- **Human oversight** — Guardrails, human-in-the-loop workflows

---

## The Compliance Configuration Checklist

Before deploying any model in production:

1. **Enable audit logging** — CloudTrail for all API calls
2. **Configure Guardrails** — Content filtering, PII redaction, topic blocking
3. **Set up monitoring** — CloudWatch for usage, latency, errors
4. **Run evaluations** — Bedrock Evaluations for accuracy, bias, safety
5. **Use VPC isolation** — PrivateLink to keep traffic off public internet
6. **Apply encryption** — KMS with customer-managed keys for sensitive data

---

## Model Recommendations by Use Case

**Financial Services (EU)** — Claude Sonnet, Amazon Nova Pro (EU entity, strong DPAs)

**Healthcare (EU)** — Amazon Nova Pro, Amazon Titan (AWS-only, no third-party)

**Legal (EU)** — Claude Opus, Mistral Large (high accuracy, EU-based)

**Public Sector (EU)** — Amazon Nova, Mistral (EU-native options)

**Low-risk internal** — Meta Llama, DeepSeek, NVIDIA NeMo (open licenses, cost-effective)

---

## Key Takeaways

1. **AWS-sold ≠ Vendor-sold**. AWS-sold models have zero vendor data access. Vendor-sold models require EULA review.

2. **For strictest EU compliance**: Amazon Nova, Anthropic Claude, or Mistral. All have EU entities and proper DPAs.

3. **Open-source on Bedrock is safe**. Llama, Gemma, and NeMo are AWS-sold with no vendor access.

4. **China-origin models require policy review**. DeepSeek is AWS-sold (safe technically), but verify organizational policies.

5. **Request DPAs for Twelve Labs and Writer**. Strong data terms exist, but explicit DPA needed for EU.

6. **Document everything**. Compliance audits will ask about model selection rationale, DPA registry, and risk assessments.

---

## Resources

- [AWS Bedrock Data Protection](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html)
- [AWS Third-Party Model Terms](https://aws.amazon.com/legal/bedrock/third-party-models/)
- [Anthropic DPA](https://www.anthropic.com/legal/data-processing-addendum)
- [AWS GDPR DPA](https://docs.aws.amazon.com/whitepapers/latest/navigating-gdpr-compliance/aws-data-processing-addendum-dpa.html)
- [EU AI Act - AWS Blog](https://aws.amazon.com/blogs/machine-learning/building-trust-in-ai-the-aws-approach-to-the-eu-ai-act/)

---

*What compliance challenges have you faced with Bedrock? Share your experience in the comments.*

---

**Tags**: AWS, Bedrock, GDPR, Compliance, Enterprise AI
