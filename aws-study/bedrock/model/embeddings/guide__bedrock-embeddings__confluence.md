# AWS Bedrock Embeddings Guide

## TL;DR

- **Primary: [Cohere Embed v4](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v4.html)** – SOTA multimodal embeddings (text+images+documents), 100+ languages, up to 128K context, configurable dimensions (256-1536), industry-optimized for finance/healthcare.
- **Text-only: [Amazon Titan Text Embeddings V2](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)** – Production-grade, 20+ regions, configurable dimensions (256-1024), binary embeddings for cost-efficient storage.
- **Multilingual: [Cohere Embed 3 Multilingual](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v3.html)** – 100+ languages, 12 regions, ideal for global semantic search.
- **Video: [TwelveLabs Marengo Embed 3.0](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-twelvelabs.html)** – Video-native embeddings, up to 4 hours/6GB video, 36 languages, async inference for video search.
- **Embedding model choice matters for RAG quality** – Different models have different semantic understanding; use same model for indexing and querying.

---

## What Are Embeddings?

Embeddings are numerical vector representations of data (text, images, documents) that capture semantic meaning in a high-dimensional space. Similar concepts are placed closer together, enabling:

- **Semantic Search**: Find results by meaning, not just keywords
- **Retrieval-Augmented Generation (RAG)**: Augment LLM responses with relevant context from knowledge bases
- **Zero-Shot Classification**: Classify data without explicit training
- **Clustering**: Group similar documents or content
- **Similarity Matching**: Find related items in large datasets

---

## Available Embedding Models in Bedrock

### Model Comparison Matrix

| Model | Model ID | Type | Dimensions | Context | Languages | Best For |
| --- | --- | --- | --- | --- | --- | --- |
| **[Cohere Embed v4](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v4.html)** | `cohere.embed-v4:0` | Multimodal | 256/512/1024/1536 | 128K tokens | 100+ | Documents, images, complex RAG |
| **[Cohere Embed 3 English](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v3.html)** | `cohere.embed-english-v3` | Text + Image | 1024 | 512 tokens | English | English-only semantic search |
| **[Cohere Embed 3 Multilingual](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v3.html)** | `cohere.embed-multilingual-v3` | Text + Image | 1024 | 512 tokens | 100+ | Cross-lingual search |
| **[Amazon Titan Text Embeddings V2](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)** | `amazon.titan-embed-text-v2:0` | Text | 256/512/1024 | 8K tokens | Multiple | General text embeddings |
| **[Amazon Titan Embeddings G1 - Text](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)** | `amazon.titan-embed-text-v1` | Text | 1536 | 8K tokens | Multiple | Legacy text embeddings |
| **[Amazon Titan Multimodal Embeddings G1](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-mm.html)** | `amazon.titan-embed-image-v1` | Text + Image | 256/384/1024 | N/A | Multiple | Image + text search |
| **[Amazon Nova Multimodal Embeddings](https://docs.aws.amazon.com/nova/latest/userguide/getting-started-schema.html)** | `amazon.nova-2-multimodal-embeddings-v1:0` | Multimodal | Configurable | N/A | Multiple | Text, image, audio, video |
| **[TwelveLabs Marengo Embed 3.0](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-twelvelabs.html)** | `twelvelabs.marengo-embed-3-0` | Video + Audio + Text + Image | 1024 | 4 hours / 6GB | 36 | Video search, content analysis |
| **[TwelveLabs Marengo Embed 2.7](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-twelvelabs.html)** | `twelvelabs.marengo-embed-2-7` | Video + Audio + Text + Image | 1024 | 2 hours / 3GB | 12 | Video search, classification |

---

## Regional Availability

### Cohere Embed Models

| Model | Single-Region Support | Cross-Region Inference |
| --- | --- | --- |
| **Cohere Embed v4** | us-east-1, eu-west-1, ap-northeast-1 | 🟢 24+ regions via cross-region |
| **Cohere Embed 3 English** | 12 regions (us-east-1, us-west-2, eu-west-1, ap-northeast-1, etc.) | ❌ |
| **Cohere Embed 3 Multilingual** | 12 regions (same as English) | ❌ |

### Amazon Titan Embed Models

| Model | Regional Support |
| --- | --- |
| **Titan Text Embeddings V2** | 🟢 20+ regions including us-gov-west-1, us-gov-east-1 |
| **Titan Embeddings G1 - Text** | us-east-1, us-west-2, eu-central-1, ap-northeast-1 |
| **Titan Multimodal Embeddings G1** | 10 regions (us-east-1, us-west-2, eu-west-1, etc.) |

### TwelveLabs Marengo Models

| Model | Single-Region Support | Cross-Region Inference |
| --- | --- | --- |
| **Marengo Embed 3.0** | us-east-1, eu-west-1, ap-northeast-2 | ❌ |
| **Marengo Embed 2.7** | us-east-1, eu-west-1, ap-northeast-2 | 🟢 US and EU regions |

---

## Pricing Comparison

| Model | Price per 1,000 Input Tokens | Provisioned Throughput |
| --- | --- | --- |
| **Cohere Embed v4** | Contact AWS | Available |
| **Cohere Embed 3 English** | $0.0001 | $7.12/hour (no commitment) |
| **Cohere Embed 3 Multilingual** | $0.0001 | $7.12/hour (no commitment) |
| **Amazon Titan Text Embeddings V2** | $0.00002 | Contact AWS |
| **Amazon Titan Embeddings G1 - Text** | $0.0001 | Contact AWS |
| **Amazon Titan Multimodal Embeddings** | $0.0008/image, $0.0002/text | Contact AWS |
| **TwelveLabs Marengo Embed 3.0** | $0.00006/sec video | Async inference |
| **TwelveLabs Marengo Embed 2.7** | $0.00006/sec video | Async inference |

> **Note**: Embeddings are charged per input token processed. There is no output token cost for embeddings. TwelveLabs models are charged per second of video processed.

---

## How to Choose an Embedding Model

### Decision Factors

| Factor | Consideration |
| --- | --- |
| **Data Type** | Text-only → Titan V2; Multimodal → Cohere v4 or Nova |
| **Language** | English → Cohere English; Multilingual → Cohere Multilingual or Titan V2 |
| **Document Complexity** | Simple text → Titan; Complex docs with tables/charts → Cohere v4 |
| **Vector Storage Cost** | Lower dimensions = cheaper storage; Use binary embeddings for efficiency |
| **Regional Requirements** | Check availability; Titan V2 has widest coverage |
| **Integration** | Knowledge Bases support all; check Bedrock feature compatibility |

### Decision Tree

```text
Need multimodal (text + images)?
├── YES → Need complex document understanding (tables, charts)?
│   ├── YES → Cohere Embed v4
│   └── NO → Titan Multimodal Embeddings G1 or Nova Multimodal
└── NO → Need multilingual support (100+ languages)?
    ├── YES → Cohere Embed 3 Multilingual
    └── NO → Need widest regional availability?
        ├── YES → Amazon Titan Text Embeddings V2
        └── NO → Need maximum performance?
            ├── YES → Cohere Embed 3 English
            └── NO → Amazon Titan Text Embeddings V2 (best value)
```

---

## Does the Embedding Model Matter When Choosing a Foundation Model?

**Yes, the embedding model choice significantly impacts your RAG system quality.**

### Key Considerations

| Aspect | Impact |
| --- | --- |
| **Semantic Understanding** | Different models have different "views" of semantic similarity |
| **Consistency** | Must use the **same model** for indexing AND querying |
| **Dimension Compatibility** | Vector databases are configured for specific dimensions |
| **Quality vs Cost** | Higher-quality embeddings → better retrieval → better LLM responses |

### Embedding Model vs Foundation Model Independence

```text
┌─────────────────────────────────────────────────────────────┐
│                     RAG Pipeline                             │
├─────────────────────────────────────────────────────────────┤
│  [Documents] → [Embedding Model] → [Vector Store]           │
│                      ↓                                       │
│  [Query] → [Same Embedding Model] → [Vector Search]         │
│                      ↓                                       │
│  [Retrieved Context] → [Foundation Model] → [Response]      │
└─────────────────────────────────────────────────────────────┘
```

**Important**: The embedding model and foundation model (FM) operate independently:

- **Embedding Model**: Converts text/images to vectors for search
- **Foundation Model**: Generates responses using retrieved context

You can mix different providers:

- ✅ Cohere Embed v4 + Claude 3.7 Sonnet
- ✅ Titan Embeddings V2 + Amazon Nova Pro
- ✅ Cohere Embed 3 + Mistral Large

### When Embedding Quality Matters Most

| Scenario | Embedding Impact | Recommendation |
| --- | --- | --- |
| **Simple Q&A** | Moderate | Titan V2 (cost-effective) |
| **Complex Document RAG** | High | Cohere v4 (best comprehension) |
| **Multilingual Search** | Critical | Cohere Multilingual (cross-lingual) |
| **High-Volume Batch** | Cost-driven | Titan V2 + binary embeddings |
| **Enterprise Documents** | High | Cohere v4 (tables, charts, handwriting) |

---

## Model-Specific Features

### Cohere Embed v4 - Advanced Capabilities

| Feature | Description |
| --- | --- |
| **Interleaved Content** | Process mixed text + image inputs (e.g., PDF pages with captions) |
| **Document Understanding** | Native support for tables, graphs, diagrams, code snippets |
| **Configurable Dimensions** | 256, 512, 1024, or 1536 dimensions |
| **Multiple Embedding Types** | float, int8, uint8, binary, ubinary |
| **Long Context** | Up to 128K tokens per input |
| **Industry Fine-tuning** | Optimized for finance, healthcare, manufacturing |

**Input Types**:

- `search_document`: Use when indexing corpus for retrieval
- `search_query`: Use when encoding user queries
- `classification`: Use for text classification tasks
- `clustering`: Use for clustering similar documents

### Amazon Titan Text Embeddings V2

| Feature | Description |
| --- | --- |
| **Configurable Dimensions** | 256, 512, or 1024 dimensions |
| **Binary Embeddings** | Storage-efficient binary format support |
| **Normalization** | Optional L2 normalization |
| **Wide Availability** | 20+ regions including GovCloud |

---

## Integration with Bedrock Features

### Knowledge Bases Support

| Embedding Model | Knowledge Bases | Agents | Guardrails |
| --- | --- | --- | --- |
| **Cohere Embed v4** | 🟢 | 🟢 | 🟢 |
| **Cohere Embed 3** | 🟢 | 🟢 | 🟢 |
| **Titan Text Embeddings V2** | 🟢 | 🟢 | 🟢 |
| **Titan Multimodal Embeddings** | 🟢 | 🟢 | 🟢 |

### Vector Database Integration

Amazon Bedrock Knowledge Bases supports multiple vector stores:

- Amazon OpenSearch Serverless
- Amazon Aurora PostgreSQL (pgvector)
- Pinecone
- Redis Enterprise Cloud
- MongoDB Atlas

---

## Best Practices

### 1. Consistency is Critical

> [!warning]
> **Always use the same embedding model for indexing and querying.** Mixing models will produce incompatible vector spaces.

### 2. Choose Dimensions Based on Use Case

| Dimension | Storage | Quality | Use Case |
| --- | --- | --- | --- |
| 256 | Lowest | Good | High-volume, cost-sensitive |
| 512 | Low | Better | Balanced cost/quality |
| 1024 | Medium | High | Standard RAG |
| 1536 | Highest | Best | Maximum accuracy |

### 3. Use Binary Embeddings for Cost Efficiency

Binary embeddings represent vectors as compact bit arrays instead of floating-point numbers, dramatically reducing storage and compute costs.

> [!warning]
>
> Binary embeddings sacrifice **precision for efficiency**.

#### How Binary Embeddings Work

| Type | Representation | Bits per Dimension | Storage Reduction |
| --- | --- | --- | --- |
| **Float32** | 32-bit floating point | 32 bits | Baseline |
| **Int8** | 8-bit signed integer | 8 bits | 4x smaller |
| **Uint8** | 8-bit unsigned integer | 8 bits | 4x smaller |
| **Binary** | 1-bit signed (-1/+1) | 1 bit | 32x smaller |
| **Ubinary** | 1-bit unsigned (0/1) | 1 bit | 32x smaller |

#### Storage Cost Comparison (1 Million Vectors)

| Dimension | Float32 Size | Binary Size | Savings |
| --- | --- | --- | --- |
| 256 | ~1 GB | ~32 MB | 97% |
| 512 | ~2 GB | ~64 MB | 97% |
| 1024 | ~4 GB | ~128 MB | 97% |
| 1536 | ~6 GB | ~192 MB | 97% |

#### Quantified quality loss (typical benchmarks)

| Metric | Float32 | Int8 | Binary | Notes |
| --- | --- | --- | --- | --- |
| **Recall@10** | 95% | 93% | 88% | -7% absolute |
| **Recall@100** | 99% | 98% | 95% | -4% absolute |
| **MRR (Mean Reciprocal Rank)** | 0.85 | 0.82 | 0.75 | Top result less likely correct |
| **nDCG@10** | 0.90 | 0.87 | 0.80 | Ranking quality degrades |

#### When to Use Binary Embeddings

| Scenario | Recommendation | Rationale |
| --- | --- | --- |
| **High-volume production** | Binary | Massive storage/cost savings |
| **First-pass retrieval** | Binary | Fast approximate search, then rerank |
| **Two-stage search** | Binary + Float | Binary for recall, float for precision |
| **Small corpus (<100K docs)** | Float | Storage not a bottleneck |
| **Maximum accuracy required** | Float | Full precision for critical apps |

#### Two-Stage Retrieval Pattern

For optimal cost-quality balance, use binary embeddings for initial retrieval, then rerank with full-precision:

```text
┌─────────────────────────────────────────────────────────────────┐
│  [Query] → [Binary Search] → Top 100 candidates                 │
│                ↓                                                 │
│  [Rerank with Float embeddings or Cohere Rerank] → Top 10      │
│                ↓                                                 │
│  [LLM Generation with context]                                  │
└─────────────────────────────────────────────────────────────────┘
```

> [!tip]
> **Pro tip**: Store both binary and float embeddings during indexing. Use binary for fast retrieval, then score final candidates with float for best quality at lowest cost.

### 4. Optimize Chunk Size for RAG

| Model | Recommended Chunk Size | Context Limit |
| --- | --- | --- |
| Cohere Embed v4 | 512-2048 tokens | 128K tokens |
| Cohere Embed v3 | 256-512 tokens | 512 tokens |
| Titan V2 | 512-1024 tokens | 8K tokens |

## Sources

### AWS Documentation

- [Supported Foundation Models in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
- [Amazon Titan Text Embeddings](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)
- [Cohere Embed v4](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v4.html)
- [Cohere Embed v3](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v3.html)
- [Amazon Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)
- [Amazon Bedrock Knowledge Bases](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base.html)

### Blog Posts & Tutorials

- [Use language embeddings for zero-shot classification and semantic search with Amazon Bedrock](https://aws.amazon.com/blogs/machine-learning/use-language-embeddings-for-zero-shot-classification-and-semantic-search-with-amazon-bedrock/)
- [Automating vector embedding generation in Amazon Aurora PostgreSQL with Amazon Bedrock](https://aws.amazon.com/blogs/database/automating-vector-embedding-generation-in-amazon-aurora-postgresql-with-amazon-bedrock/)
- [Demystifying Amazon Bedrock Pricing for a Chatbot Assistant](https://aws.amazon.com/blogs/machine-learning/demystifying-amazon-bedrock-pricing-for-a-chatbot-assistant/)
- [Talk to your slide deck using multimodal foundation models on Amazon Bedrock](https://aws.amazon.com/blogs/machine-learning/talk-to-your-slide-deck-using-multimodal-foundation-models-on-amazon-bedrock-part-3/)
