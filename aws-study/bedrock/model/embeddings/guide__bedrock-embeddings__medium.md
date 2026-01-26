# How to Choose the Right Embedding Model for AWS Bedrock RAG

## Your embedding model choice can make or break your RAG system. Here's what 9 models in Bedrock actually offer—and how to pick the right one.

---

"We switched embedding models and our retrieval quality dropped 30%."

I've heard this from multiple teams building RAG applications on AWS Bedrock. The culprit? A fundamental misunderstanding about embeddings.

Most teams focus on choosing the right foundation model—Claude vs Nova vs Llama. But they treat embeddings as an afterthought. That's backwards.

**Your embedding model determines what your LLM can find.** A perfect generation model can't help if retrieval serves irrelevant context.

This guide covers all 9 embedding models available in AWS Bedrock, when to use each, and the hidden tradeoffs that trip up production deployments.

---

## What Are Embeddings, Really?

Embeddings convert your data—text, images, documents, even video—into numerical vectors. These vectors capture semantic meaning in high-dimensional space, placing similar concepts closer together.

Think of it as creating a map where:

- "How do I reset my password?" sits near "I forgot my login credentials"
- "AWS pricing" clusters with "Bedrock costs" and "cloud compute rates"

This enables **semantic search**: finding results by meaning, not just keyword matching.

---

## The 9 Embedding Models in Bedrock

AWS Bedrock offers more embedding options than most teams realize. Here's the complete breakdown:

### Tier 1: State-of-the-Art

**Cohere Embed v4** (`cohere.embed-v4:0`)

- Multimodal: text + images + interleaved content
- 128K token context (largest in Bedrock)
- Configurable dimensions: 256/512/1024/1536
- 100+ languages
- Native understanding of tables, charts, diagrams

**TwelveLabs Marengo Embed 3.0** (`twelvelabs.marengo-embed-3-0`)

- Video-native embeddings (up to 4 hours/6GB)
- Audio + text + image in single model
- 36 languages
- Async inference (video processing takes time)

### Tier 2: Production Workhorses

**Amazon Titan Text Embeddings V2** (`amazon.titan-embed-text-v2:0`)

- Text-only, but rock-solid
- 20+ regions including GovCloud
- Configurable: 256/512/1024 dimensions
- Binary embeddings for storage efficiency
- 5x cheaper than Cohere

**Cohere Embed 3 Multilingual** (`cohere.embed-multilingual-v3`)

- 100+ languages
- Proven stability (v3 is battle-tested)
- 12 regions
- Fixed 1024 dimensions

**Cohere Embed 3 English** (`cohere.embed-english-v3`)

- English-optimized
- Same stability as Multilingual
- Slightly better English performance

### Tier 3: Specialized

**Amazon Titan Multimodal Embeddings G1** (`amazon.titan-embed-image-v1`)

- Text + image search
- Lower cost than Cohere for simple multimodal

**Amazon Nova Multimodal Embeddings**

- Newest Amazon option
- Text, image, audio, video support
- Limited regional availability (us-east-1 only currently)

**Legacy options**: Titan Embeddings G1 - Text and Marengo 2.7 exist but are superseded by newer versions.

---

## The Decision Framework

Choosing an embedding model comes down to four questions:

### 1. What's your data type?

- **Text only** → Titan V2 (cost) or Cohere v3 (quality)
- **Text + images** → Cohere v4
- **Complex documents** (tables, charts) → Cohere v4
- **Video content** → TwelveLabs Marengo 3.0
- **Mixed media** → Nova Multimodal or Cohere v4

### 2. What languages do you need?

- **English only** → Cohere Embed 3 English
- **100+ languages** → Cohere v4 or Cohere Multilingual
- **Widest availability** → Titan V2 (multiple languages, 20+ regions)

### 3. What's your budget constraint?

Here's what 100 million tokens/month costs:

- **Titan V2** → ~$2,000/month (baseline)
- **Cohere v3** → ~$10,000/month (5x more)
- **Cohere v4** → ~$15,000/month (7x more)

Titan V2 is **5x cheaper** than Cohere. For high-volume text-only workloads, that adds up fast.

### 4. What regions do you need?

- **Cohere v4** → us-east-1 ✅ | eu-west-1 ✅ | ap-northeast-1 ✅ | GovCloud ❌
- **Titan V2** → us-east-1 ✅ | eu-west-1 ✅ | ap-northeast-1 ✅ | GovCloud ✅
- **TwelveLabs** → us-east-1 ✅ | eu-west-1 ✅ | ap-northeast-2 only | GovCloud ❌

**Titan V2 wins for regional coverage**, especially if you need GovCloud.

---

## The Binary Embeddings Tradeoff

Here's something most guides don't explain well: **binary embeddings offer 32x storage savings but sacrifice precision**.

### How it works

- **Float32** → 32 bits per dimension → ~4 GB for 1M vectors @ 1024d
- **Binary** → 1 bit per dimension → ~128 MB for 1M vectors @ 1024d

That's 97% savings. But here's the catch:

### The quality loss

- **Recall@10**: Float32 95% → Binary 88% (−7%)
- **MRR**: Float32 0.85 → Binary 0.75 (−12%)

Binary embeddings lose nuance. A float can represent 4.3 billion distinct values per dimension. Binary? Just two: 0 or 1.

### When to use binary

- ✅ First-pass retrieval with reranking
- ✅ High-volume, cost-sensitive applications
- ✅ Two-stage search (binary → float → LLM)
- ❌ Maximum accuracy requirements
- ❌ Small corpora where storage isn't a concern

### The two-stage pattern

Smart teams use both:

```
Query → Binary Search (Top 100) → Rerank with Float (Top 10) → LLM
```

This gives you binary's cost efficiency with float's precision where it matters.

---

## The Independence Principle

Here's the most misunderstood aspect of Bedrock RAG:

**Your embedding model and foundation model are independent.**

You can absolutely use:

- Cohere embeddings + Claude for generation
- Titan embeddings + Nova Pro
- Any combination that fits your needs

The pipeline works like this:

```
Documents → [Embedding Model] → Vector Store
                    ↓
Query → [Same Embedding Model] → Vector Search → Retrieved Context
                                                        ↓
                                    [Foundation Model] → Response
```

The key constraint: **use the same embedding model for indexing AND querying**. Mixing embedding models produces incompatible vector spaces.

---

## Common Mistakes

### Mistake 1: Changing embedding models without re-indexing

If you switch from Titan V2 to Cohere v4, you must re-embed your entire corpus. Old vectors won't work with the new model's query embeddings.

### Mistake 2: Over-dimensioning

Higher dimensions = better quality, but diminishing returns kick in fast.

- 256: Good for most use cases
- 512: Sweet spot for cost/quality
- 1024: Standard RAG
- 1536: Only if you've proven you need it

### Mistake 3: Ignoring input types

Cohere models require specifying input type:

- `search_document` for indexing
- `search_query` for queries

Mixing these degrades retrieval quality.

### Mistake 4: Using Cohere for simple text when Titan works

If you're embedding plain text in English with no special requirements, Titan V2 at $0.00002/1K tokens beats Cohere at $0.0001/1K tokens—and delivers comparable quality.

---

## Quick Reference: Model Selection

```
Need multimodal (text + images)?
├── YES → Complex documents (tables, charts)?
│   ├── YES → Cohere Embed v4
│   └── NO → Titan Multimodal G1
└── NO → Need 100+ languages?
    ├── YES → Cohere Embed 3 Multilingual
    └── NO → Cost priority?
        ├── HIGH → Titan V2 ($2K/mo @ 100M tokens)
        └── LOW → Cohere v4 (best quality)

Need video embeddings?
└── YES → TwelveLabs Marengo 3.0

Need GovCloud?
└── YES → Titan V2 (only option)
```

---

## Key Takeaways

1. **Embeddings determine retrieval quality**—don't treat them as an afterthought.

2. **Titan V2 is the workhorse**: Widest availability, lowest cost, GovCloud support.

3. **Cohere v4 is the premium option**: Best for complex documents, multimodal, 128K context.

4. **Binary embeddings trade precision for efficiency**: Use two-stage retrieval for best results.

5. **Embedding model ≠ FM choice**: Mix providers freely, but keep the same embedding model for indexing and querying.

6. **Re-embedding is required when switching models**: Plan for this cost when evaluating changes.

---

## Resources

- [AWS Bedrock Embedding Models](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
- [Amazon Titan Embeddings](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-titan-embed-text.html)
- [Cohere Embed v4](https://docs.aws.amazon.com/bedrock/latest/userguide/model-parameters-embed-v4.html)
- [Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

---

*What embedding model are you using for your RAG system? Share your experience in the comments.*

---

**Tags**: AWS, Bedrock, Embeddings, RAG, Machine Learning, Vector Search
