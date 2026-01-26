# Bedrock FM for Embeddings

## Requirements

1. **Embedding generation** - primary capability needed
2. **RAG/Knowledge Base integration** - must work with Bedrock Knowledge Bases
3. **Data residency** - data must NOT leave AWS account
4. **Regional availability** - must work in:
   - us-east-1 (US/N. Virginia) - primary
   - eu-west-1 (EU/Ireland)
   - ap-northeast-1 (Asia/Tokyo)

---

## TL;DR

- **Primary: Cohere Embed v4** – SOTA multimodal embeddings (text+images+documents), 100+ languages, 128K context, configurable dimensions (256-1536), all 3 regions via cross-region inference.
- **Budget: Amazon Titan Text Embeddings V2** – AWS-sold (no vendor data), 20+ regions including GovCloud, 5x cheaper than Cohere, binary embeddings for storage efficiency.
- **Multilingual: Cohere Embed 3 Multilingual** – 100+ languages, 12 regions, proven stability for cross-lingual search.
- **Video: TwelveLabs Marengo Embed 3.0** – Video-native embeddings, 4 hours/6GB video, 36 languages, async inference.
- **Cross-region trade-off:** Cross-region inference provides 24+ region access but data may route to any region; use single-region for strict GDPR/HIPAA.

---

## Pre-Filtering

### Step 1: Filter by Data Residency

**Requirement**: Data stays in AWS

> **Data Sources**: [Compliance Guide](data-residency-and-compliance/guide__data-residency-and-compliance__confluence.md) | [Feature Matrix](../data/bedrock_features_matrix.csv)

| Category | Models | Vendor Data Access | Recommended |
| --- | --- | --- | --- |
| **AWS-sold** | Amazon Titan, Amazon Nova | 🟢 None | 🟢 Yes |
| **Vendor-sold with DPA** | Cohere (DPA available) | 🟢 None (contractual) | 🟢 Yes |
| **Vendor-sold (review needed)** | TwelveLabs | 🟡 Request DPA | 🟡 Review |

**Models remaining**: All embedding models pass data residency (data stays in AWS infrastructure).

---

### Step 2: Filter by Embedding Capability

**Requirement**: Generate embeddings for semantic search/RAG

| Model | Modality | Embedding Output | Passes |
| --- | --- | --- | --- |
| **Cohere Embed v4** | Text + Image + Interleaved | 🟢 Yes | 🟢 |
| **Cohere Embed 3 English** | Text + Image | 🟢 Yes | 🟢 |
| **Cohere Embed 3 Multilingual** | Text + Image | 🟢 Yes | 🟢 |
| **Amazon Titan Text Embeddings V2** | Text | 🟢 Yes | 🟢 |
| **Amazon Titan Embeddings G1 - Text** | Text | 🟢 Yes | 🟢 |
| **Amazon Titan Multimodal Embeddings G1** | Text + Image | 🟢 Yes | 🟢 |
| **Amazon Nova Multimodal Embeddings** | Text + Image + Audio + Video | 🟢 Yes | 🟢 |
| **TwelveLabs Marengo Embed 3.0** | Video + Audio + Text + Image | 🟢 Yes | 🟢 |
| **TwelveLabs Marengo Embed 2.7** | Video + Audio + Text + Image | 🟢 Yes | 🟢 |

**All 9 models pass** - all are embedding models.

---

### Step 3: Filter by Regional Availability

**Requirement**: Available in us-east-1, eu-west-1, ap-northeast-1

| Model | us-east-1 | eu-west-1 | ap-northeast-1 | Method | Passes |
| --- | --- | --- | --- | --- | --- |
| **Cohere Embed v4** | 🟢 | 🟢 | 🟢 | Single + Cross-region | 🟢 |
| **Cohere Embed 3 English** | 🟢 | 🟢 | 🟢 | Single-region | 🟢 |
| **Cohere Embed 3 Multilingual** | 🟢 | 🟢 | 🟢 | Single-region | 🟢 |
| **Amazon Titan Text Embeddings V2** | 🟢 | 🟢 | 🟢 | Single-region | 🟢 |
| **Amazon Titan Embeddings G1 - Text** | 🟢 | 🔴 | 🟢 | Single-region | 🔴 |
| **Amazon Titan Multimodal Embeddings G1** | 🟢 | 🟢 | 🔴 | Single-region | 🔴 |
| **Amazon Nova Multimodal Embeddings** | 🟢 | 🔴 | 🔴 | Single-region | 🔴 |
| **TwelveLabs Marengo Embed 3.0** | 🟢 | 🟢 | 🔴 (ap-northeast-2) | Single-region | 🔴 |
| **TwelveLabs Marengo Embed 2.7** | 🟢 | 🟢 | 🔴 (ap-northeast-2) | Single + Cross-region | 🔴 |

**Models remaining after regional filtering**:

- **Cohere Embed v4** ✅
- **Cohere Embed 3 English** ✅
- **Cohere Embed 3 Multilingual** ✅
- **Amazon Titan Text Embeddings V2** ✅

> [!warning]
> **Regional Gaps:**
> - **Titan Embeddings G1 - Text**: Missing eu-west-1
> - **Titan Multimodal Embeddings G1**: Missing ap-northeast-1
> - **Nova Multimodal Embeddings**: Only us-east-1
> - **TwelveLabs Marengo**: ap-northeast-2 (Korea) not ap-northeast-1 (Tokyo)

---

## Embedding Model Evaluation

### Quality & Capability Comparison

| Model | Dimensions | Context | Languages | Multimodal | Document Understanding | Rating |
| --- | --- | --- | --- | --- | --- | --- |
| **Cohere Embed v4** | 256-1536 | 128K | 100+ | Text + Image + Interleaved | Tables, charts, diagrams | ⭐⭐⭐⭐⭐ |
| **Cohere Embed 3 English** | 1024 | 512 | English | Text + Image | Basic | ⭐⭐⭐⭐ |
| **Cohere Embed 3 Multilingual** | 1024 | 512 | 100+ | Text + Image | Basic | ⭐⭐⭐⭐ |
| **Titan Text Embeddings V2** | 256-1024 | 8K | Multiple | Text only | N/A | ⭐⭐⭐ |

### Feature Support Comparison

| Feature | Cohere Embed v4 | Cohere Embed 3 | Titan Text Embeddings V2 |
| --- | --- | --- | --- |
| **Knowledge Bases** | 🟢 | 🟢 | 🟢 |
| **Configurable Dimensions** | 🟢 256/512/1024/1536 | 🔴 Fixed 1024 | 🟢 256/512/1024 |
| **Binary Embeddings** | 🟢 | 🟢 | 🟢 |
| **Int8 Embeddings** | 🟢 | 🟢 | 🔴 |
| **Interleaved Input** | 🟢 Text + Image mixed | 🔴 | 🔴 |
| **Cross-Region Inference** | 🟢 24+ regions | 🔴 | 🔴 |
| **Streaming** | 🔴 (embeddings don't stream) | 🔴 | 🔴 |

---

## Pricing Comparison

| Model | Price per 1K Tokens | Monthly Cost (100M tokens)¹ | vs Baseline |
| --- | --- | --- | --- |
| **Amazon Titan Text Embeddings V2** | $0.00002 | ~$2,000 | Baseline |
| **Cohere Embed 3 English** | $0.0001 | ~$10,000 | 5x more |
| **Cohere Embed 3 Multilingual** | $0.0001 | ~$10,000 | 5x more |
| **Cohere Embed v4** | Contact AWS | ~$15,000² | ~7x more |

> [!note]
> ¹ Based on 100M input tokens/month (typical medium RAG deployment).
>
> ² Cohere v4 pricing estimated based on capability premium.
>
> **Provisioned Throughput**: Cohere Embed 3 at $7.12/hour ($5,126/month) for consistent workloads.

---

## Knowledge Base Integration

All qualifying models integrate with Amazon Bedrock Knowledge Bases:

| Model | Knowledge Base | Vector Stores | Guardrails |
| --- | --- | --- | --- |
| **Cohere Embed v4** | 🟢 | OpenSearch, Aurora, Pinecone, Redis, MongoDB | 🟢 |
| **Cohere Embed 3** | 🟢 | OpenSearch, Aurora, Pinecone, Redis, MongoDB | 🟢 |
| **Titan Text Embeddings V2** | 🟢 | OpenSearch, Aurora, Pinecone, Redis, MongoDB | 🟢 |

### Supported Vector Databases

- Amazon OpenSearch Serverless
- Amazon Aurora PostgreSQL (pgvector)
- Pinecone
- Redis Enterprise Cloud
- MongoDB Atlas

---

## Cross-Region vs Single-Region Trade-offs

### Performance Metrics

| Aspect | Single Region | Cross-Region Profile |
| --- | --- | --- |
| **Availability** | 99.9% | 99.99% (auto-failover) |
| **Regional coverage** | 1 region | 24+ regions |
| **Data residency** | 🟢 Guaranteed in region | 🟡 May route to any region |

### Data Residency Concerns

| Regulation | Single Region | Cross-Region | Action |
| --- | --- | --- | --- |
| **GDPR (EU data)** | 🟢 Safe (eu-west-1) | 🟡 Risk (may route to US/Asia) | Use single region |
| **HIPAA (Healthcare)** | 🟢 Possible (region locked) | 🔴 Not allowed | Must use single region |
| **Non-regulated** | 🟢 Either works | 🟢 Recommended (higher availability) |

---

## Final Recommendation

> **Data Sources**: [Embeddings Guide](../embeddings/guide__bedrock-embeddings.md) | [Feature Matrix](../data/bedrock_features_matrix.csv) | [AWS Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

### Model Comparison Table

| Aspect | 🏆 Cohere Embed v4 | 🥈 Titan Text Embeddings V2 | 🥉 Cohere Embed 3 Multilingual |
| --- | --- | --- | --- |
| **Model ID** | `cohere.embed-v4:0` | `amazon.titan-embed-text-v2:0` | `cohere.embed-multilingual-v3` |
| **Recommendation** | 🟢 **PRIMARY** | 🟢 **Budget** | 🟢 **Multilingual** |
| **Type** | Multimodal | Text-only | Text + Image |
| **Dimensions** | 256/512/1024/1536 | 256/512/1024 | 1024 (fixed) |
| **Context Window** | 128K tokens | 8K tokens | 512 tokens |
| **Languages** | 100+ | Multiple | 100+ |
| **Binary Embeddings** | 🟢 Yes | 🟢 Yes | 🟢 Yes |
| **Cross-Region** | 🟢 24+ regions | 🔴 Single-region | 🔴 Single-region |
| **Best For** | Complex RAG, multimodal | Cost-sensitive, text-only | Global multilingual search |

### Pricing Comparison

| Model | Input Price/1K | Monthly (100M tokens)¹ | Cost Tier |
| --- | --- | --- | --- |
| **🏆 Cohere Embed v4** | ~$0.00015² | ~$15,000 | Premium |
| **🥈 Titan Text Embeddings V2** | $0.00002 | ~$2,000 | Budget |
| **🥉 Cohere Embed 3 Multilingual** | $0.0001 | ~$10,000 | Mid-tier |

> [!note]
> ¹ Based on 100M input tokens/month.
>
> ² Cohere v4 pricing estimated; contact AWS for exact rates.

### Use Case Recommendations

| Use Case | Recommended Model | Rationale |
| --- | --- | --- |
| **Complex document RAG** | 🏆 Cohere Embed v4 | Tables, charts, interleaved content |
| **Cost-sensitive text search** | 🥈 Titan Text Embeddings V2 | 5x cheaper, widest regional availability |
| **Global multilingual search** | 🥉 Cohere Embed 3 Multilingual | 100+ languages, proven stability |
| **Binary embeddings at scale** | 🥈 Titan Text Embeddings V2 | Lowest cost + binary support |
| **GovCloud deployment** | 🥈 Titan Text Embeddings V2 | Only option with GovCloud support |
| **Maximum accuracy** | 🏆 Cohere Embed v4 | 1536 dimensions, best quality |

### Regional Availability Summary

| Model | us-east-1 | eu-west-1 | ap-northeast-1 | GovCloud |
| --- | --- | --- | --- | --- |
| 🏆 Cohere Embed v4 | 🟢 | 🟢 | 🟢 | 🔴 |
| 🥈 Titan Text Embeddings V2 | 🟢 | 🟢 | 🟢 | 🟢 |
| 🥉 Cohere Embed 3 Multilingual | 🟢 | 🟢 | 🟢 | 🔴 |

---

## Decision Summary

| Criterion | Result | Evidence |
| --- | --- | --- |
| Data stays in AWS | 🟢 | AWS-sold (Titan) or DPA-covered (Cohere) |
| Embedding generation | 🟢 | All models produce vector embeddings |
| Knowledge Base integration | 🟢 | All support Bedrock Knowledge Bases |
| us-east-1 available | 🟢 | All 3 recommended models |
| eu-west-1 available | 🟢 | All 3 recommended models |
| ap-northeast-1 available | 🟢 | All 3 recommended models |
| Configurable dimensions | 🟢 | Cohere v4 + Titan V2 |
| Binary embeddings | 🟢 | All 3 support binary format |
| **FINAL VERDICT** | 🟢 **APPROVED** | **Primary: Cohere Embed v4** / **Budget: Titan V2** |

---

## Quick Model Selection Guide

```text
Need multimodal (text + images)?
├── YES → Need complex document understanding (tables, charts)?
│   ├── YES → Cohere Embed v4 (PRIMARY)
│   └── NO → Cohere Embed 3 (proven, cheaper)
└── NO → Need multilingual (100+ languages)?
    ├── YES → Cohere Embed 3 Multilingual
    └── NO → Cost priority?
        ├── HIGH → Titan Text Embeddings V2 (5x cheaper)
        └── MODERATE → Cohere Embed v4 (best quality)
```

---

## References

### AWS Documentation

- [Supported Foundation Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
- [Amazon Titan Text Embeddings](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)
- [Cohere Embed v4](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v4.html)
- [Cohere Embed v3](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v3.html)
- [Amazon Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)
- [Amazon Bedrock Knowledge Bases](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base.html)

### Local Data Sources

- [Embeddings Guide](../embeddings/guide__bedrock-embeddings.md)
- [Feature Matrix CSV](../data/bedrock_features_matrix.csv)
- [Compliance Guide](data-residency-and-compliance/guide__data-residency-and-compliance__confluence.md)
