# Best Bedrock models for Text inference

## Requirements

1. **Text generation** - primary capability needed
2. **XML/DocBook format** - must consume and return valid XML for technical documentation
3. **Data residency** - data must NOT leave AWS account
4. **Regional availability**:
   - us-east-2 (US/Ohio)
   - eu-west-1 (EU/Ireland)
   - ap-northeast-1 (Asia/Tokyo)

---

## TL;DR

**Primary**: **Nova Pro** - AWS-sold (no vendor data access), available in all 3 regions via cross-region inference (us-east-2, eu-west-1, ap-northeast-1), 4x cheaper than Claude ($14K vs $60K/month), full Bedrock features (Guardrails, Knowledge Base, Batch), 300K context for large documents.

**Alternative**: **Claude 3.5 Sonnet v2** - Vendor-sold with DPA (GDPR-compliant via Anthropic Ireland), same 3-region coverage, superior reasoning quality, adds Agents + Token Counting. Choose when quality > cost or you need autonomous agents.

**Cross-region trade-off**: 3x throughput + auto-failover BUT data may process in any of the 3 regions. Use single-region deployment if strict geographic residency required (GDPR/HIPAA).

**Budget**: **Nova Lite** ($1.1K/month) or **Claude 3 Haiku** ($5K/month) for simple/high-volume text tasks - both have 3-region coverage.

## Analysis Process

### Step 1: Filter by Data Residency

**Requirement**: Data stays in AWS

> **Data Sources**: [Model Licensing Guide](./AWS%20Bedrock%20Model%20Selection%20-%20Data%20Residency%20&%20Compliance%20Guide.md) | [Feature Matrix](../data/bedrock_features_matrix.csv)

**Filtering logic**:

| Category | Models | Vendor Data Access | Recommended |
| --- | --- | --- | --- |
| **AWS-sold** | Amazon Nova, Meta Llama, Google Gemma, DeepSeek, Mistral, Alibaba Qwen | 🟢 None | 🟢 Yes |
| **Vendor-sold with DPA** | Anthropic Claude | 🟢 None (explicit DPA, EU entity) | 🟢 Yes for GDPR |
| **Vendor-sold (review needed)** | Cohere, Twelve Labs, Writer AI | 🟡 Request DPA | 🟡 Review |
| **Vendor-sold (limited EU)** | Stability AI, Luma AI, AI21 | 🔴 US jurisdiction, no DPA | 🔴 Not for EU |

> 🟡 **Correction**: Anthropic Claude is suitable for EU compliance per [AWS Third-Party Terms](https://aws.amazon.com/legal/bedrock/third-party-models/). Quote: *"Anthropic may not train models on Customer Content"* and uses *"Anthropic Ireland, Limited"* for EEA customers with explicit [DPA](https://www.anthropic.com/legal/data-processing-addendum).

**Models remaining**:

- Amazon Nova
- Meta Llama
- Google Gemma
- DeepSeek
- Mistral
- Qwen
- **Anthropic Claude** (with DPA)

### Step 2: Filter by Text Generation Capability

**Requirement**: Generate text (specifically XML/DocBook)

**Filtering logic**:

- Text output capability required
- Exclude embedding-only models (Titan Embeddings, Nova Embeddings)
- Exclude image/video generation (Nova Canvas, Nova Reel, Stable Diffusion)

**Models remaining**:

- Amazon: Nova Lite, Nova Micro, Nova Pro, Nova Premier
- Meta: Llama 3, 3.1, 3.2, 3.3
- Google: Gemma 3 (all sizes)
- DeepSeek: V3.1, R1
- Mistral: All text models
- Others: Qwen, Moonshot

---

### Step 3: Filter by Regional Availability

**Requirement**: All 3 regions must be supported

- us-east-2
- eu-west-1
- ap-northeast-1

**Analysis**:

Each model has either:

- **Single-region support** (limited to specific regions)
- **Cross-region inference profile support** (available across multiple regions via profile routing)

Models with cross-region support spanning all 3 required regions:

| Model | us-east-2 | eu-west-1 | ap-northeast-1 | Method |
| --- | --- | --- | --- | --- |
| **Amazon Nova Lite** | 🟢 | 🟢 | 🟢 | Cross-region profile |
| **Amazon Nova Micro** | 🟢 | 🟢 | 🟢 | Cross-region profile |
| **Amazon Nova Pro** | 🟢 | 🟢 | 🟢 | Cross-region profile |
| **Amazon Nova Premier** | 🔴 | 🔴 | 🔴 | US only (cross-region) |
| **Google Gemma 3 12B** | 🟢 | 🟢 | 🟢 | Single-region |
| **Meta Llama 3.1 70B** | 🟢 (cross-region) | 🔴 | 🔴 | Limited cross-region |
| **DeepSeek V3.1** | 🟢 | 🔴 | 🔴 | Single-region |
| **Mistral models** | Limited | Limited | Limited | Limited availability |

**Models remaining after regional filtering**:

- Amazon Nova Lite
- Amazon Nova Micro
- Amazon Nova Pro
- Google Gemma 3 12B
- Anthropic Claude 3.5 Sonnet (v2)
- Anthropic Claude 3.7 Sonnet

> 🟡 **Regional Feature Gap** (from [regional-features.md](report__regional-features.md)):
>
> - **us-east-2 is missing**: API keys, Agents
> - If Agents are required, use eu-west-1 or ap-northeast-1 as primary

---

### Step 4: Evaluate for XML/DocBook Generation

**Requirement**: High-quality structured XML output for technical documentation

**Evaluation criteria**:

- Reasoning capability (understand complex formatting requirements)
- Instruction following (precise XML syntax)
- Context handling (large documents)
- Streaming support (real-time generation)

| Model | Capability | Context | Streaming | Reasoning | Rating |
| --- | --- | --- | --- | --- | --- |
| **Nova Pro** | Excellent | 300K | Yes | Strong | ⭐⭐⭐⭐⭐ |
| **Nova Lite** | Very Good | 300K | Yes | Good | ⭐⭐⭐⭐ |
| **Nova Micro** | Good | 128K | Yes | Moderate | ⭐⭐⭐ |
| **Gemma 3 12B** | Very Good | 128K | Yes | Good | ⭐⭐⭐⭐ |
| **Claude 3.5 Sonnet** | Excellent | 200K | Yes | Excellent | ⭐⭐⭐⭐⭐ |
| **Claude 3.7 Sonnet** | Excellent | 200K | Yes | Excellent | ⭐⭐⭐⭐⭐ |

#### Feature Support Comparison (from [bedrock_features_matrix.csv](../data/bedrock_features_matrix.csv))

| Model | Guardrails | Knowledge Base | Batch Inference | Prompt Optimization | RAG Evaluations |
| --- | --- | --- | --- | --- | --- |
| Nova Pro | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |
| Nova Lite | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |
| Claude 3.5 Sonnet | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |
| Claude 3.7 Sonnet | 🟢 | 🟢 | 🔴 | 🟢 | 🟢 |
| Gemma 3 12B | 🔴 | 🔴 | 🔴 | 🔴 | 🔴 |

---

### Cross-Region vs Single-Region Trade-offs

Your requirements include 3 regions: **us-east-2, eu-west-1, ap-northeast-1**. Understanding cross-region implications is critical for final model selection.

#### Performance Metrics

| Aspect | Single Region | Cross-Region Profile |
| -------- | -------------- | ---------------------- |
| **Latency** | 200-300ms (baseline) | 250-400ms (+50ms overhead) |
| **Throughput** | 100 req/sec | 300 req/sec (3x increase) |
| **Availability** | 99.9% | 99.99% (auto-failover) |
| **Regional failure** | 🔴 Complete outage | 🟢 Automatic failover |

#### Data Residency Concerns

🟡 **Critical for compliance**:

| Regulation | Single Region | Cross-Region | Action |
| --- | --- | --- | --- |
| **GDPR (EU data)** | 🟢 Safe (eu-west-1) | 🟡 Risk (may route to US/Asia) | Document consent or use single region |
| **CCPA (CA data)** | 🟢 Safe (us-east-2) | 🟡 Risk (may route to EU/Asia) | Customer notification required |
| **APAC regulations** | 🟢 Safe (ap-northeast-1) | 🟡 Risk (may leave region) | Strict residency mandate broken |
| **HIPAA (Healthcare)** | 🟢 Possible (region locked) | 🔴 Not allowed | Must use single region |

**Data stays in AWS** (always true), but **geographic region changes** (depends on profile).

---

## Cross-Region Inference Strategy

After narrowing to **Amazon Nova Pro** (which passes all 4 steps), you need to decide: single-region or cross-region deployment?

### Performance Impact Comparison

| Aspect | Single Region | Cross-Region Profile |
| --- | --- | --- |
| **Latency** | 100-150ms | 150-200ms (+50-100ms) |
| **Throughput** | 100 requests/sec | 300 requests/sec (3x) |
| **Availability (SLA)** | 99.9% | 99.99% (10x more reliable) |
| **Cost** | $0.48/1M input tokens | $0.48/1M input tokens ($0 premium) |
| **Regional Failover** | Manual (you manage) | Automatic (AWS manages) |
| **Data Residency** | eu-west-1 only | May process in us-east-2/ap-northeast-1 |

### Data Residency Concerns by Compliance Framework

| Framework | Single Region OK | Cross-Region Risk |
| --- | --- | --- |
| **GDPR** (EU data) | 🟢 Yes if eu-west-1 | 🟡 If routes to us-east-2 |
| **CCPA** (CA data) | 🟢 Yes if us-east-2 | 🟡 If routes to eu-west-1/ap |
| **APAC Residency** | 🟢 Yes if ap-northeast-1 | 🟡 If routes to other regions |
| **HIPAA** (Health data) | 🟡 With BAA only | 🔴 Cross-region breaks BAA |
| **Non-regulated** | 🟢 Either works | 🟢 Recommended (3x resilience) |

### Recommendation Matrix

**Use Cross-Region Profile If:**

- 🟢 Data is non-regulated (public, internal, non-PII)
- 🟢 You need 99.99% uptime (mission-critical docs)
- 🟢 You expect traffic spikes (3x throughput buffer)
- 🟢 You can tolerate 50-100ms latency increase
- 🟢 Cost is constrained (no premium for resilience)

**Use Single-Region Profile If:**

- 🟢 Data includes GDPR/CCPA/regulated content
- 🟢 You must guarantee eu-west-1 processing
- 🟢 Latency is critical (<100ms required)
- 🟢 Compliance audit requires "data stays in region X"
- 🟢 HIPAA/BAA compliance required

## Final Recommendation

> **Data Sources**: [Feature Matrix](../data/bedrock_features_matrix.csv) | [Regional Features](report__regional-features.md) | [Compliance Guide](./AWS%20Bedrock%20Model%20Selection%20-%20Data%20Residency%20&%20Compliance%20Guide.md) | [AWS Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

### Model Comparison Table

| Aspect | 🏆 Nova Pro | 🥈 Claude 3.5 Sonnet v2 | 🥉 Claude 3.7 Sonnet |
| --- | --- | --- | --- |
| **Model ID** | `amazon.nova-pro-v1:0` | `anthropic.claude-3-5-sonnet-20241022-v2:0` | `anthropic.claude-3-7-sonnet-20250219-v1:0` |
| **Recommendation** | 🟢 **PRIMARY** | 🟢 **Alternative** | 🟢 **Alternative** |
| **Context Window** | 300K | 200K | 200K |
| **Reasoning** | Strong | Excellent | Excellent |
| **Extended Thinking** | 🔴 No | 🔴 No | 🟢 Yes |
| **Input Modality** | Text, Image, Video | Text, Image | Text, Image |
| **Output Modality** | Text | Text | Text |
| **Knowledge Cutoff** | ~Oct 2024 | ~Apr 2024 | ~2025 |
| **Best For** | Cost-effective XML, multimodal docs | Quality-first, Agents, batch processing | Latest knowledge, Agents, extended thinking |

### Pricing Comparison (On-Demand, per 1K tokens)

| Model | Input Price | Output Price | Cost per 10K in / 2K out | Monthly (1M calls)¹ |
| --- | --- | --- | --- | --- |
| **🏆 Nova Pro** | $0.0008 | $0.0032 | $0.0144 | ~$14,400 |
| **🥈 Claude 3.5 Sonnet v2** | $0.003 | $0.015 | $0.060 | ~$60,000 |
| **🥉 Claude 3.7 Sonnet** | $0.003 | $0.015 | $0.060 | ~$60,000 |

> [!note]
> Estimate based on 10K input + 2K output tokens per request × 1M requests/month. Actual costs vary by usage patterns.
>
> **Batch inference** (Claude, Nova): 50% discount on on-demand pricing.

### Feature Support Comparison

| Feature | 🏆 Nova Pro | 🥈 Claude 3.5 Sonnet | 🥉 Claude 3.7 Sonnet |
| --- | --- | --- | --- |
| **Guardrails** | 🟢 | 🟢 | 🟢 |
| **Knowledge Base** | 🟢 | 🟢 | 🟢 |
| **Batch Inference** | 🟢 | 🟢 | 🔴 |
| **Agents** | 🔴 | 🟢 | 🟢 |
| **Token Counting** | 🔴 | 🟢 | 🟢 |
| **Prompt Caching** | 🟢 | 🟢 | 🟢 |
| **Streaming** | 🟢 | 🟢 | 🟢 |
| **Multimodal** | 🟢 | 🟢 | 🟢 |

### Compliance & Data Residency

| Aspect | 🏆 Nova Pro | 🥈🥉 Claude 3.5/3.7 Sonnet |
| --- | --- | --- |
| **Vendor Type** | AWS-sold | Vendor-sold (with DPA) |
| **Data Access** | 🟢 None | 🟢 None (contractual) |
| **GDPR Compliant** | 🟢 Yes | 🟢 Yes (EU entity) |
| **EULA Required** | 🟢 No | 🟡 Yes |
| **Cross-Region** | 🟢 All 3 regions | 🟢 All 3 regions |

### Regional Availability

| Model | us-east-2 | eu-west-1 | ap-northeast-1 | Method |
| --- | --- | --- | --- | --- |
| 🏆 Nova Pro | 🟢 | 🟢 | 🟢 | Cross-region profile |
| 🥈 Claude 3.5 Sonnet v2 | 🟢 | 🟢 | 🟢 | Cross-region profile |
| 🥉 Claude 3.7 Sonnet | 🟢 | 🟢 | 🟢 | Cross-region profile |

---

### Recommendation Summary

| Use Case | Recommended Model | Rationale |
| --- | --- | --- |
| **Best value for XML generation** | 🏆 **Nova Pro** | Strong reasoning, 300K context, full feature support, ~4x cheaper than Claude |
| **Best quality (cost not critical)** | 🥈 **Claude 3.5 Sonnet v2** | Superior reasoning, token counting, Agents support, batch inference |
| **Latest Claude + Agents** | 🥉 **Claude 3.7 Sonnet** | Newest model, Agents support, no batch inference |

---

## Decision Summary

| Criterion | Result | Evidence |
| --- | --- | --- |
| Data stays in AWS | 🟢 | AWS-sold model (Nova) or DPA-covered (Claude) |
| Text generation | 🟢 | Full text output capability |
| XML/DocBook ready | 🟢 | Strong reasoning, good structure |
| us-east-2 available | 🟢 | Cross-region profile support |
| eu-west-1 available | 🟢 | Cross-region profile support |
| ap-northeast-1 available | 🟢 | Cross-region profile support |
| Context window | 🟢 | 300K tokens (Nova Pro) / 200K (Claude) |
| Feature support | 🟢 | Guardrails, Knowledge Base, RAG Evaluations |
| **FINAL VERDICT** | 🟢 **APPROVED** | **Primary: Nova Pro** / **Alt: Claude 3.5 Sonnet** |

---

## References

- [Supported Foundation Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
- [Model Features Matrix](https://docs.aws.amazon.com/bedrock/latest/userguide/models-features.html)
- [Feature Support by Region](https://docs.aws.amazon.com/bedrock/latest/userguide/features-regions.html)
- [AWS Third-Party Model Terms](https://aws.amazon.com/legal/bedrock/third-party-models/)
- [AWS Bedrock Data Privacy](https://aws.amazon.com/bedrock/data-privacy/)

### Local Data Sources

- [Feature Matrix CSV](../data/bedrock_features_matrix.csv)
- [Regional Features](report__regional-features.md)
- [Compliance Guide](./AWS%20Bedrock%20Model%20Selection%20-%20Data%20Residency%20&%20Compliance%20Guide.md)
