# Data Residency & Compliance Guide

## TL;DR

| Compliance Level | Recommended | Requires Review |
| --- | --- | --- |
| 🟢 **Strictest** (GDPR + EU AI Act + ISO 42001) | Amazon Nova, Claude, Mistral | — |
| 🟡 **Standard** (GDPR) | Above + Meta Llama, DeepSeek, Gemma, Qwen, OpenAI GPT-OSS, NVIDIA NeMo | MiniMax, Moonshot AI, Twelve Labs, Writer (request DPA) |
| 🔵 **Internal** (Non-regulated) | Any model | — |

### Quick Decision Guide

1. **Identify Your Compliance Requirements**

    | Requirement | Key Question | Impact on Model Choice |
    | --- | --- | --- |
    | GDPR | Processing EU personal data? | Requires DPA, prefer EU entity providers |
    | EU AI Act | Deploying high-risk AI system? | Requires transparency, documentation, human oversight |
    | ISO/IEC 42001 | Need AI management certification? | Requires full audit trail, evaluations |
    | Data Residency | Must data stay in specific region? | Check model availability by region |
    | Sector-specific | HIPAA, PCI-DSS, financial? | May require AWS-only models |

2. **Select Model Category**

    ```text
    ┌─ What's your compliance level? ─────────────────────────────────────┐
    │                                                                      │
    │  STRICTEST (GDPR + EU AI Act + ISO 42001 + Data Residency)?         │
    │      └─→ Amazon Nova, Anthropic Claude, Mistral                     │
    │          • EU entities available                                     │
    │          • Comprehensive DPAs                                        │
    │          • Full audit support                                        │
    │                                                                      │
    │  STANDARD (GDPR compliance)?                                         │
    │      └─→ Above + Meta Llama, DeepSeek, Gemma, Qwen, GPT-OSS, NeMo   │
    │          • AWS-sold = AWS DPA covers                                 │
    │          • No vendor data access                                     │
    │          • ⚠️ DeepSeek: verify China-origin policy                  │
    │                                                                      │
    │  INTERNAL (Non-regulated, low-risk)?                                 │
    │      └─→ Any model                                                   │
    │          • Still follow Acceptable Use Policies                      │
    │          • Document model choice rationale                           │
    └──────────────────────────────────────────────────────────────────────┘
    ```

3. **Configure for Compliance**

    | Action | Tool/Service | Purpose |
    | --- | --- | --- |
    | Enable audit logging | CloudTrail | Record all API calls for compliance audit |
    | Configure guardrails | Bedrock Guardrails | Content filtering, PII redaction, topic blocking |
    | Set up monitoring | CloudWatch | Track usage, latency, errors |
    | Run evaluations | Bedrock Evaluations | Test accuracy, bias, safety before deployment |
    | Use VPC isolation | PrivateLink | Keep traffic off public internet |
    | Apply encryption | KMS (CMK) | Customer-managed keys for sensitive data |

4. **Document Your Choices**

    | Document | Contents | Audience |
    | --- | --- | --- |
    | Model Selection Record | Model name, version, rationale, compliance mapping | Compliance/Legal |
    | Data Flow Diagram | Where data goes, what's processed, retention | Security/DPO |
    | Risk Assessment | AI impact assessment per EU AI Act / ISO 42001 | Leadership |
    | DPA Registry | Which DPAs apply (AWS, Anthropic, etc.) | Legal/Procurement |
    | Acceptable Use Acknowledgment | Confirmation of AUP compliance | Development Team |

---

## Vendor Data Access

### 🟢 Models Where Data Stays 100% in AWS (AWS-Sold)

These models are **AWS-sold**. Model providers have **NO access** to AWS infrastructure, prompts, or completions.

**Source**: [AWS Bedrock Data Protection](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html)

> *"Amazon Bedrock has a concept of a Model Deployment Account—in each AWS Region where Amazon Bedrock is available, there is one such deployment account per model provider. These accounts are owned and operated by the Amazon Bedrock service team. Model providers don't have any access to those accounts."*

| Provider | Models | License Source | Vendor Data Access |
| --- | --- | --- | --- |
| **Amazon** | Nova, Titan | [AWS Service Terms](https://aws.amazon.com/service-terms/) | 🟢 None |
| **Meta** | Llama 3, 3.1, 3.2, 3.3 | [Llama 3 License](https://llama.meta.com/llama3/license/) | 🟢 None |
| **Meta** | Llama 4 (Scout, Maverick) | [Llama 4 License](https://www.llama.com/llama4/license/) | 🟢 None |
| **Mistral AI** | Mistral, Mixtral, Pixtral | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟡 Metadata only |
| **DeepSeek** | R1, V3 | [DeepSeek Model License](https://github.com/deepseek-ai/DeepSeek-V3/blob/main/LICENSE-MODEL) | 🟢 None |
| **Google** | Gemma 3 | [Gemma Terms](https://ai.google.dev/gemma/terms) | 🟢 None |
| **Alibaba (Qwen)** | Qwen3 models | [Qwen License](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE) | 🟢 None |
| **OpenAI** | gpt-oss-20b, gpt-oss-120b, GPT OSS Safeguard | [OpenAI Usage Policy](https://openai.com/policies/usage-policies/) | 🟢 None |
| **NVIDIA** | NeMo models | [NVIDIA AI Foundation Models License](https://www.nvidia.com/en-us/agreements/enterprise-software/nvidia-ai-foundation-models-community-license-agreement/) | 🟢 None |
| **MiniMax** | MiniMax models | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟡 Review |
| **Moonshot AI** | Kimi models | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟡 Review |

> [!note]
> **Hugging Face models** are not directly available in Bedrock. Use [SageMaker JumpStart](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-jumpstart.html) for HF model deployment with AWS DPA coverage.
>
> **Metadata only (Mistral example)**: AWS may share with Mistral: AWS Account ID, region, model ID, request count, token usage, timestamps. **Not shared**: prompts, completions, or any content you send/receive.

### 🟡 Models Requiring Vendor EULA (Vendor-Sold)

These models require accepting the vendor's EULA. All terms below are quoted from [AWS Third-Party Model Terms](https://aws.amazon.com/legal/bedrock/third-party-models/).

| Provider | EULA Location | DPA Available |
| --- | --- | --- |
| **Anthropic** | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | [Anthropic DPA](https://www.anthropic.com/legal/data-processing-addendum) |
| **Twelve Labs** | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | Not explicit |
| **Writer AI** | [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/) | Not explicit |

---

## Vendor EULA Analysis with Source Quotes

### 🟢 Anthropic (Claude) - RECOMMENDED for EU

**Source**: [AWS Third-Party Terms - Anthropic Commercial Terms](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | Anthropic (vendor-sold) | *"sold by Anthropic"* |
| **Commercial Use** | 🟢 Allowed | Section A |
| **Vendor Data Access** | 🟢 None | *"Anthropic may not train models on Customer Content"* - Section B |
| **Training on Data** | 🟢 Prohibited | *"Anthropic may not train models on Customer Content from Services"* - Section B |
| **Jurisdiction (EU)** | 🟢 Ireland | *"Laws of Ireland"* for EEA/Switzerland/UK customers |
| **Jurisdiction (US)** | California | For non-EU customers |
| **EU Entity** | 🟢 Yes | *"Anthropic Ireland, Limited"* for EEA/Switzerland/UK |
| **DPA Available** | 🟢 [Yes](https://www.anthropic.com/legal/data-processing-addendum) | Explicit DPA with SCCs |
| **Data Ownership** | Customer owns Inputs/Outputs | *"Customer retains all rights, title, and interest"* - Section B |

**Verdict**: 🟢 **Suitable for GDPR, EU AI Act, ISO/IEC 42001:2023**

---

### Mistral AI - RECOMMENDED for EU

**Source**: [AWS Third-Party Terms - Mistral](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Commercial Use** | 🟢 Allowed | Terms |
| **Vendor Data Access** | 🟡 Metadata only | *"AWS may share... Account Information and usage information (but not Your Content)"* |
| **Training on Data** | 🟢 Prohibited | No content access = no training possible |
| **Content Protected** | 🟢 Yes | *"but not Your Content"* - explicit exclusion |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **EU Entity** | 🟢 Yes | Mistral AI is Paris, France-based (GDPR-native) |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |

**Verdict**: 🟢 **Excellent for EU - GDPR-native company, no content shared**

---

### Twelve Labs - REVIEW REQUIRED

**Source**: [AWS Third-Party Terms - Twelve Labs AWS Bedrock Enterprise EULA](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | Twelve Labs (vendor-sold) | *"sold by Twelve Labs"* |
| **Commercial Use** | 🟢 Allowed | Section 2 |
| **Vendor Data Access** | 🟢 None | *"Provider will not have access to your Inputs and Outputs"* - Section 3 |
| **Training on Data** | 🟢 Prohibited | *"we cannot and will not train, develop, or improve our Services with your Inputs or Outputs"* - Section 3 |
| **Output Ownership** | Customer owns | *"We assign and transfer to you any and all right and title we may have in the Outputs"* - Section 3 |
| **Jurisdiction** | 🔴 California, USA | *"governed by the laws of the State of California"* - Section 10 |
| **EU Entity** | 🔴 No | Delaware corporation, USA |
| **DPA Available** | 🟡 Request | Not explicitly referenced |

**Gap**: US governing law; no explicit DPA.

**Verdict**: 🟡 **Strong data terms - request DPA for EU compliance**

---

### 🟡 Writer AI - REVIEW REQUIRED

**Source**: [AWS Third-Party Terms - Writer Enterprise EULA](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | Writer AI (vendor-sold) | *"sold by Writer AI"* |
| **Commercial Use** | 🟢 Allowed | Section 2 |
| **Vendor Data Access** | 🟢 None | *"We have no rights under this EULA to access your AWS account"* - Section 3 |
| **Training on Data** | 🟢 Prohibited | *"We will not train, develop, or improve our Services with your Inputs or Outputs"* - Section 3 |
| **Output Ownership** | Customer owns | *"We assign and transfer to you any and all right and title we may have in the Outputs"* - Section 3 |
| **Jurisdiction** | 🔴 California, USA | *"governed by the laws of the State of California"* - Section 10 |
| **EU Entity** | 🔴 No | Writer, Inc. USA |
| **DPA Available** | 🟡 Request | Not explicitly referenced |
| **Acceptable Use** | [writer.com/acceptable-use](https://www.writer.com/acceptable-use) | |

**Gap**: US governing law; no explicit DPA.

**Verdict**: 🟡 **Strong data terms - request DPA for EU compliance**

---

### DeepSeek - AWS-SOLD, OPEN LICENSE

**Source**: [DeepSeek Model License](https://github.com/deepseek-ai/DeepSeek-V3/blob/main/LICENSE-MODEL)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Models Available** | DeepSeek-R1, DeepSeek-V3.1, DeepSeek-V3.2-Exp | AWS Bedrock |
| **Commercial Use** | 🟢 Allowed | DeepSeek Model License |
| **Vendor Data Access** | 🟢 None | DeepSeek has zero access to AWS deployments |
| **Training on Data** | 🟢 Not possible | Model runs in AWS isolation; no data egress |
| **Output Ownership** | Customer controls | Open license |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **EU Entity** | N/A | DeepSeek (China) has no access; use AWS DPA |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |

> [!warning] China-Developed Model
> DeepSeek models are developed by Hangzhou DeepSeek AI (China). While **AWS-sold** with no vendor data access, some organizations may have policy restrictions on China-origin AI models. Confirm with your compliance team.

**Verdict**: 🟢 **AWS-sold with no vendor access - verify organizational China-origin policies**

---

### Meta (Llama) - AWS-SOLD, OPEN LICENSE

**Source**: [Llama 3 License](https://llama.meta.com/llama3/license/), [Llama 4 License](https://www.llama.com/llama4/license/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Commercial Use** | 🟢 Allowed | Llama Community License |
| **Vendor Data Access** | 🟢 None | Meta has zero access to AWS deployments |
| **Training on Data** | 🟢 Not possible | Model runs in AWS isolation; no data egress |
| **Output Ownership** | Customer controls | Open license |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **EU Entity** | N/A | Meta has no access; use AWS DPA |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |
| **Acceptable Use** | Meta's AUP | Acceptable Use Policy applies |

**Note**: Llama models are **AWS-sold**. Meta has zero access to prompts, completions, or AWS infrastructure.

**Verdict**: 🟢 **Excellent for EU - AWS-hosted, open license, no vendor data access**

---

### 🟢 Google (Gemma) - AWS-SOLD, OPEN LICENSE

**Source**: [Gemma Terms of Use](https://ai.google.dev/gemma/terms)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Commercial Use** | 🟢 Allowed | Gemma Terms |
| **Vendor Data Access** | 🟢 None | Google has zero access to AWS deployments |
| **Training on Data** | 🟢 Not possible | Model runs in AWS isolation; no data egress |
| **Output Ownership** | Customer controls | Open license |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **EU Entity** | N/A | Google has no access; use AWS DPA |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |
| **Prohibited Uses** | Safety restrictions | Weapons, harm, etc. - Section 3 |

**Note**: Gemma models are **AWS-sold**. Google has zero access to prompts, completions, or AWS infrastructure.

**Verdict**: 🟢 **Excellent for EU - AWS-hosted, open license, no vendor data access**

---

### 🟢 OpenAI (GPT-OSS) - AWS-SOLD, OPEN SOURCE

**Source**: [AWS Third-Party Model Terms - OpenAI](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Models Available** | gpt-oss-20b, gpt-oss-120b, Safeguard 20B, Safeguard 120B | AWS Bedrock Model Catalog |
| **Commercial Use** | 🟢 Allowed | Open License |
| **Vendor Data Access** | 🟢 None | AWS-sold; OpenAI has zero access to AWS deployments |
| **Training on Data** | 🟢 Not possible | Model runs in AWS isolation; no data egress |
| **Output Ownership** | Customer controls | Open license |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |
| **Usage Policy** | [OpenAI Usage Policy](https://huggingface.co/openai/gpt-oss-120b/blob/main/USAGE_POLICY) | Per-model policy |

> [!warning] GPT-4 Not Available
> The flagship GPT-4, GPT-4o, and ChatGPT models are **NOT available** on AWS Bedrock. Only open-source GPT-OSS variants are available. For GPT-4, use OpenAI API or Azure OpenAI (different compliance profile).

**Verdict**: 🟢 **Open variants excellent for EU; GPT-4/ChatGPT not available on Bedrock**

---

### 🟢 NVIDIA (NeMo) - AWS-SOLD

**Source**: [AWS Third-Party Model Terms - NVIDIA](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | AWS (AWS-sold) | *"sold by AWS"* |
| **Models Available** | NeMo foundation models | AWS Bedrock Model Catalog |
| **Commercial Use** | 🟢 Allowed | NVIDIA AI Foundation Models License |
| **Vendor Data Access** | 🟢 None | AWS-sold; NVIDIA has zero access to AWS deployments |
| **Training on Data** | 🟢 Not possible | Model runs in AWS isolation; no data egress |
| **Output Ownership** | Customer controls | Per license terms |
| **Jurisdiction** | N/A (AWS-sold) | AWS Service Terms apply |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA for AWS-sold models |

**Note**: NVIDIA NeMo models are **AWS-sold**. NVIDIA has zero access to prompts, completions, or AWS infrastructure.

**Verdict**: 🟢 **AWS-sold with no vendor access - suitable for EU compliance**

---

### 🟡 MiniMax - REVIEW REQUIRED

**Source**: [AWS Third-Party Model Terms - MiniMax](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | MiniMax (vendor-sold) | Check AWS Third-Party Terms |
| **Commercial Use** | 🟢 Allowed | Per EULA |
| **Vendor Data Access** | 🟡 Review | Not explicitly documented |
| **Training on Data** | 🟡 Review | Verify in EULA |
| **Output Ownership** | 🟡 Review | Verify in EULA |
| **Jurisdiction** | 🔴 China (likely) | MiniMax is China-based |
| **EU Entity** | 🔴 No | China-based company |
| **DPA Available** | 🟡 Request | Not explicitly referenced |

> [!warning] China-Based Provider
> MiniMax is a China-based AI company. Review organizational policies on China-origin AI models and verify data processing terms before use.

**Gap**: China-based entity; verify data processing terms and organizational policies.

**Verdict**: 🟡 **Request explicit data processing terms; verify China-origin policy compliance**

---

### 🟡 Moonshot AI - REVIEW REQUIRED

**Source**: [AWS Third-Party Model Terms - Moonshot AI](https://aws.amazon.com/legal/bedrock/third-party-models/)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Sold By** | Moonshot AI (vendor-sold) | Check AWS Third-Party Terms |
| **Models Available** | Kimi models | AWS Bedrock Model Catalog |
| **Commercial Use** | 🟢 Allowed | Per EULA |
| **Vendor Data Access** | 🟡 Review | Not explicitly documented |
| **Training on Data** | 🟡 Review | Verify in EULA |
| **Output Ownership** | 🟡 Review | Verify in EULA |
| **Jurisdiction** | 🔴 China (likely) | Moonshot AI is China-based |
| **EU Entity** | 🔴 No | China-based company |
| **DPA Available** | 🟡 Request | Not explicitly referenced |

> [!warning] China-Based Provider
> Moonshot AI is a China-based AI company. Review organizational policies on China-origin AI models and verify data processing terms before use.

**Gap**: China-based entity; verify data processing terms and organizational policies.

**Verdict**: 🟡 **Request explicit data processing terms; verify China-origin policy compliance**

---

### 🟡 Hugging Face - VIA SAGEMAKER (NOT BEDROCK)

**Source**: [Hugging Face on AWS](https://huggingface.co/docs/sagemaker/index), [SageMaker JumpStart](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-jumpstart.html)

| Aspect | Status | Source Quote / Notes |
| --- | --- | --- |
| **Available in Bedrock** | 🔴 No | Use SageMaker JumpStart or SageMaker Inference |
| **Commercial Use** | Varies by model | Each HF model has its own license (Apache, MIT, etc.) |
| **Vendor Data Access** | 🟢 None | HF has no access to your SageMaker deployments |
| **Training on Data** | 🟢 Not possible | Data stays in your AWS account (SageMaker) |
| **Jurisdiction** | N/A | AWS Service Terms apply to SageMaker |
| **DPA Available** | 🟢 AWS DPA | Use AWS DPA; no separate HF DPA needed for self-hosted |

> [!note]
> Not Available in Bedrock
> Hugging Face models are **NOT directly available** in Amazon Bedrock. Use SageMaker for HF model deployment.

**How to Use Hugging Face Models on AWS**:

| Method | Description | Compliance |
| --- | --- | --- |
| **SageMaker JumpStart** | Deploy HF models as SageMaker endpoints | AWS DPA covers infrastructure |
| **SageMaker Inference** | Custom deployment of HF models | Full control, AWS-hosted |
| **Bedrock Custom Import** | Import fine-tuned models to Bedrock | Model must be compatible |

**Verdict**: 🟡 **Not on Bedrock - use SageMaker with AWS DPA for HF models**

---

## AWS Core Data Protection Guarantees

**Source**: [AWS Bedrock Data Protection](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html)

**Direct Quotes**:

| Guarantee | Quote |
| --- | --- |
| **No Logging** | *"Amazon Bedrock doesn't store or log your prompts and completions"* |
| **No Training** | *"Amazon Bedrock doesn't use your prompts and completions to train any AWS models"* |
| **No Distribution** | *"[AWS] doesn't distribute them to third parties"* |
| **Encryption** | *"All data is encrypted in transit using TLS 1.2"* |

**Source**: [AWS Bedrock Security](https://aws.amazon.com/bedrock/security-compliance/)

---

## EU AI Act Alignment

**Source**: [AWS Blog - Building Trust in AI: The AWS Approach to the EU AI Act](https://aws.amazon.com/blogs/machine-learning/building-trust-in-ai-the-aws-approach-to-the-eu-ai-act/)

### High-Risk AI System Requirements

| Requirement | AWS Bedrock Support | Implementation |
| --- | --- | --- |
| **Risk Management** | 🟢 Guardrails, Evaluations | Configure content filters, test accuracy |
| **Data Governance** | 🟢 No training on customer data | Documented in service terms |
| **Technical Documentation** | 🟢 Service documentation | Available in AWS docs |
| **Record-Keeping** | 🟢 CloudTrail, CloudWatch | Enable logging for audit |
| **Transparency** | 🟢 Model cards, service info | Document AI usage in systems |
| **Human Oversight** | 🟢 Guardrails, approval workflows | Configure human-in-the-loop |
| **Accuracy & Robustness** | 🟢 Model Evaluation, testing tools | Run evaluations before deployment |

### Provider EU AI Act Readiness

| Provider | Transparency | Risk Classification | Documentation | Readiness |
| --- | --- | --- | --- | --- |
| **Amazon** | 🟢 AI Service Cards | 🟢 Guardrails | 🟢 Comprehensive | 🟢 Strong |
| **Anthropic** | 🟢 Model Cards | 🟢 Safety features | 🟢 Usage Policy | 🟢 Strong |
| **Mistral** | 🟢 Documentation | 🟢 Safety terms | 🟢 Terms | 🟢 Strong (EU) |
| **Meta** | 🟢 Model Cards | 🟢 Acceptable Use | 🟢 Comprehensive | 🟢 Good |
| **NVIDIA** | 🟢 Documentation | 🟢 Usage terms | 🟢 Comprehensive | 🟢 Good |
| **Others** | 🟡 Varies | 🟡 Varies | 🟡 Varies | 🟡 Assess |

---

## ISO/IEC 42001:2023 Alignment

**Standard**: ISO/IEC 42001:2023 - Information technology — Artificial intelligence — Management system

**Source**: [AWS Blog - AI Lifecycle Risk Management: ISO/IEC 42001:2023 for AI Governance](https://aws.amazon.com/blogs/security/ai-lifecycle-risk-management-iso-iec-420012023-for-ai-governance/)

ISO/IEC 42001:2023 establishes requirements for an **AI Management System (AIMS)** within organizations. It provides a framework for responsible development, provision, and use of AI systems.

### Core Clauses Mapping to AWS Bedrock

| ISO/IEC 42001:2023 Clause | Requirement | AWS Bedrock Capability | Implementation |
| --- | --- | --- | --- |
| **4. Context of the organization** | Understand internal/external issues affecting AI | Regional deployment options, compliance documentation | Define scope, identify stakeholders, document AI system boundaries |
| **5. Leadership** | Top management commitment, AI policy | N/A (organizational) | Customer responsibility - establish AI policy and objectives |
| **6. Planning** | Address risks/opportunities, AI system impact assessment | Model Evaluation, Guardrails design | Conduct AI impact assessments before deployment |
| **7. Support** | Resources, competence, awareness, communication | AWS documentation, training materials | AWS docs, workshops, certifications |
| **8. Operation** | Operational planning, AI system lifecycle, data management | API controls, monitoring, Guardrails | CloudWatch, CloudTrail, Bedrock Guardrails |
| **9. Performance evaluation** | Monitoring, measurement, analysis, internal audit | Model Evaluation, A/B testing | Bedrock Evaluations, continuous monitoring |
| **10. Improvement** | Nonconformity, corrective action, continual improvement | Version management, model updates | Model versioning, feedback loops |

### Annex A Controls Relevant to Bedrock

| Control Area | ISO/IEC 42001:2023 Reference | AWS Bedrock Support |
| --- | --- | --- |
| **AI system impact assessment** | A.2 | Bedrock Evaluations for accuracy, bias, safety |
| **AI system lifecycle** | A.3 | Model versioning, deprecation notices |
| **Data for AI systems** | A.4 | No training on customer data, data isolation |
| **Resources for AI systems** | A.5 | Managed infrastructure, auto-scaling |
| **Third-party and customer relationships** | A.6 | Vendor EULAs, DPAs, customer agreements |
| **Documentation of AI systems** | A.7 | Model cards, API documentation |
| **Transparency and explainability** | A.8 | Model information, usage policies |
| **Human oversight** | A.9 | Guardrails, human-in-the-loop workflows |
| **Accountability** | A.10 | CloudTrail audit logs, IAM policies |

---

## Compliance Summary Table

| Provider | No Data to Vendor | No Training | EU Entity | DPA | GDPR Ready |
| --- | --- | --- | --- | --- | --- |
| **Amazon** | 🟢 [Source](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html) | 🟢 Prohibited | 🟢 Luxembourg | 🟢 [AWS DPA](https://docs.aws.amazon.com/whitepapers/latest/navigating-gdpr-compliance/aws-data-processing-addendum-dpa.html) | 🟢 Full |
| **Anthropic** | 🟢 [Source](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟢 Prohibited | 🟢 Ireland | 🟢 [DPA](https://www.anthropic.com/legal/data-processing-addendum) | 🟢 Full |
| **Mistral** | 🟢 (metadata only) | 🟢 Prohibited | 🟢 France | 🟢 AWS DPA | 🟢 Full |
| **Meta** | 🟢 [Source](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html) | 🟢 Not possible | 🔴 US | 🟢 AWS DPA | 🟢 Good |
| **NVIDIA** | 🟢 [Source](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html) | 🟢 Not possible | 🔴 US | 🟢 AWS DPA | 🟢 Good |
| **DeepSeek** | 🟢 [Source](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html) | 🟢 Not possible | 🔴 China | 🟢 AWS DPA | 🟡 Review |
| **Twelve Labs** | 🟢 [Source](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟢 Prohibited | 🔴 US | 🟡 Request | 🟡 Review |
| **Writer** | 🟢 [Source](https://aws.amazon.com/legal/bedrock/third-party-models/) | 🟢 Prohibited | 🔴 US | 🟡 Request | 🟡 Review |
| **MiniMax** | 🟡 Review | 🟡 Verify | 🔴 China | 🟡 Request | 🟡 Review |
| **Moonshot AI** | 🟡 Review | 🟡 Verify | 🔴 China | 🟡 Request | 🟡 Review |

---

## Model Recommendations

### By Use Case and Compliance

| Use Case | Recommended Model | Why |
| --- | --- | --- |
| **Financial Services (EU)** | Claude Sonnet 4.5, Amazon Nova Pro | EU entity (Anthropic), strong DPAs |
| **Healthcare (EU)** | Amazon Nova Pro, Amazon Titan | AWS-only, no third-party |
| **Legal (EU)** | Claude Opus 4.5, Mistral Large | High accuracy, EU-based (Mistral) |
| **Public Sector (EU)** | Amazon Nova, Mistral | EU-native options |
| **General Enterprise (EU)** | Nova Pro, Claude Haiku 4.5 | Cost/performance balance |
| **Embeddings (EU)** | Amazon Titan Embed | AWS-only, EU available |
| **Image Generation (EU)** | Amazon Nova Canvas | AWS-only, EU available |
| **Low-risk internal** | Meta Llama, DeepSeek, NVIDIA NeMo | Open licenses, cost-effective |

### By Strictness Level

| Level | Models | DPA Status | Notes |
| --- | --- | --- | --- |
| **Maximum** | Amazon Nova/Titan only | AWS DPA | Zero third-party involvement |
| **High** | + Anthropic Claude | Anthropic DPA | EU entity, comprehensive terms |
| **Standard** | + Mistral, Meta Llama, NVIDIA | AWS DPA covers | EU-based (Mistral), open (Meta/NVIDIA) |
| **Moderate** | + Twelve Labs, Writer | Request DPAs | Good terms, verify DPA |
| **Review** | MiniMax, Moonshot AI | Negotiate terms | China-based, verify policies |

---

## Sources

### AWS Official Sources

- [Third-Party Model Terms](https://aws.amazon.com/legal/bedrock/third-party-models/)
- [Bedrock Data Protection](https://docs.aws.amazon.com/bedrock/latest/userguide/data-protection.html)
- [Bedrock Security](https://aws.amazon.com/bedrock/security-compliance/)
- [AWS GDPR DPA](https://docs.aws.amazon.com/whitepapers/latest/navigating-gdpr-compliance/aws-data-processing-addendum-dpa.html)
- [Supported Models by Region](https://docs.aws.amazon.com/bedrock/latest/userguide/models-regions.html)

### Vendor License/EULA Sources

- [Anthropic DPA](https://www.anthropic.com/legal/data-processing-addendum)
- [Meta Llama 3 License](https://llama.meta.com/llama3/license/)
- [Meta Llama 4 License](https://www.llama.com/llama4/license/)
- [Google Gemma Terms](https://ai.google.dev/gemma/terms)
- [DeepSeek Model License](https://github.com/deepseek-ai/DeepSeek-V3/blob/main/LICENSE-MODEL)
- [Qwen License](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE)
- [NVIDIA AI Foundation Models License](https://www.nvidia.com/en-us/agreements/enterprise-software/nvidia-ai-foundation-models-community-license-agreement/)
- [Writer Acceptable Use](https://www.writer.com/acceptable-use)

### Regulatory References

- [EU AI Act - AWS Blog](https://aws.amazon.com/blogs/machine-learning/building-trust-in-ai-the-aws-approach-to-the-eu-ai-act/)
- [ISO/IEC 42001:2023 - AWS Blog](https://aws.amazon.com/blogs/security/ai-lifecycle-risk-management-iso-iec-420012023-for-ai-governance/)
- [ISO/IEC 42001:2023 - ISO Official](https://www.iso.org/standard/81230.html)
- [GDPR - Official Text](https://gdpr.eu/)
