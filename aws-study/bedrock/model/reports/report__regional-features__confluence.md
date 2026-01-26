# AWS Bedrock Feature Support by Region

## Source

Data extracted from: [AWS Bedrock Feature Support by AWS Region](https://docs.aws.amazon.com/bedrock/latest/userguide/features-regions.html)

> [!note]
> Analysis of AWS Bedrock feature availability across the three required regions: **us-east-2** (Ohio), **eu-west-1** (Ireland), and **ap-northeast-1** (Tokyo).

## Complete Feature Matrix

| Feature                                  | us-east-2 (Ohio) | eu-west-1 (Ireland) | ap-northeast-1 (Tokyo) |
| ---------------------------------------- | ---------------- | ------------------- | ---------------------- |
| API keys                                 |        ❌        |         ✅          |           ✅           |
| Agents                                   |        ❌        |         ✅          |           ✅           |
| Application inference profiles           |        ✅        |         ✅          |           ✅           |
| Batch inference                          |        ✅        |         ✅          |           ✅           |
| Continued pre-training                   |        ❌        |         ❌          |           ❌           |
| Custom model import                      |        ✅        |         ❌          |           ❌           |
| Fine-tuning                              |        ❌        |         ❌          |           ❌           |
| Flows                                    |        ✅        |         ✅          |           ✅           |
| Guardrails                               |        ✅        |         ✅          |           ✅           |
| Guardrails image filter                  |        ✅        |         ✅          |           ✅           |
| Intelligent prompt routing               |        ✅        |         ✅          |           ✅           |
| Knowledge base query                     |        ✅        |         ✅          |           ✅           |
| Knowledge bases                          |        ✅        |         ✅          |           ✅           |
| Model evaluation                         |        ✅        |         ✅          |           ✅           |
| Model invocation logging                 |        ✅        |         ✅          |           ✅           |
| Model inference (InvokeModel, Converse)  |        ✅        |         ✅          |           ✅           |
| Prompt caching                           |        ✅        |         ✅          |           ✅           |
| Prompt management                        |        ✅        |         ✅          |           ✅           |
| Provisioned Throughput                   |        ✅        |         ✅          |           ✅           |
| System inference profiles                |        ✅        |         ✅          |           ✅           |

## Features

| Feature                              | Description                                                      |
| ------------------------------------ | ---------------------------------------------------------------- |
| **API keys**                         | Authentication method for programmatic access                    |
| **Agents**                           | Autonomous AI agents with tool use capabilities                  |
| **Application inference profiles**   | Custom routing profiles for multi-model inference strategies     |
| **Batch inference**                  | Process large volumes of inference requests asynchronously       |
| **Continued pre-training**           | Extended training of base models                                 |
| **Custom model import**              | Import externally trained models                                 |
| **Fine-tuning**                      | Task-specific model training                                     |
| **Flows**                            | Visual workflow orchestration for multi-step AI applications     |
| **Guardrails**                       | Content filtering and safety controls for model outputs          |
| **Guardrails image filter**          | Image-based content moderation and filtering                     |
| **Intelligent prompt routing**       | Automatic routing to optimal model based on prompt complexity    |
| **Knowledge base query**             | Retrieve information from indexed knowledge bases                |
| **Knowledge bases**                  | RAG (Retrieval Augmented Generation) with vector databases       |
| **Model evaluation**                 | Benchmark and compare model performance                          |
| **Model inference**                  | Standard model invocation (InvokeModel, Converse APIs)           |
| **Model invocation logging**         | Track and audit all model API calls                              |
| **Prompt caching**                   | Cache prompts to reduce latency and costs                        |
| **Prompt management**                | Version control and manage prompt templates                      |
| **Provisioned Throughput**           | Reserved capacity for consistent performance                     |
| **System inference profiles**        | Pre-configured inference profiles for common use cases           |

## Regions with Complete Feature Coverage (All Features Supported)

Based on AWS documentation, the following regions support **ALL 19 Bedrock features**:

| Region                    | Features | Coverage |
| ------------------------- | -------- | :------- |
| **US East (N. Virginia)** |   19/19  |   100%   |

### Regional Comparison: Required Regions vs. Full-Coverage Regions

| Region                     | Features | Coverage | Status      |
| -------------------------- | -------- | -------- | ----------- |
| US East (N. Virginia)      |   19/19  |   100%   | ✅ Complete |
| **us-east-2** (Ohio)       |   16/19  |    84%   | ⚠️ Limited  |
| **eu-west-1** (Ireland)    |   17/19  |    89%   | ⚠️ Limited  |
| **ap-northeast-1** (Tokyo) |   17/19  |    89%   | ⚠️ Limited  |

**Note**: For production deployments requiring complete feature coverage, consider **US East (N. Virginia)** as the primary region. The three specified regions (us-east-2, eu-west-1, ap-northeast-1) are sufficient for most use cases including model inference, guardrails, and knowledge bases.

### Architecture Impact

#### Missing Features Analysis

The following features are **NOT available in all three required regions**, creating architectural constraints:

| Feature | Missing In | Impact | Mitigation |
| --- | --- | --- | --- |
| **API keys** | us-east-2 | Cannot use API key authentication in Ohio region; must use IAM role authentication | Use IAM-based auth in us-east-2; API keys in eu-west-1 and ap-northeast-1 |
| **Agents** | us-east-2 | Cannot deploy autonomous agents in Ohio; agent-based workflows unavailable | Deploy agent infrastructure in eu-west-1 or ap-northeast-1; route agent requests there |
| **Custom model import** | eu-west-1, ap-northeast-1 | Cannot import externally trained models in Ireland or Tokyo regions | Import models in us-east-2 only; serve from there via inference profiles |
| **Continued pre-training** | All three | Cannot extend base model training beyond factory settings in any region | Use fine-tuning in us-east-1 or us-west-2; deploy trained models here |
| **Fine-tuning** | All three | Cannot customize models for specific tasks in any of the three regions | Fine-tune in us-east-1 or us-west-2; deploy via cross-region inference profiles |

#### Multi-Region Deployment Patterns

##### Pattern 1: Inference-Only (Recommended for Your Use Case)

```text
┌─────────────────────────────────────────────────────────┐
│ Pre-trained Models (Foundation/Fine-tuned elsewhere)    │
│ Deployed via Cross-Region Inference Profiles            │
└─────────────────────────────────────────────────────────┘
        ↓              ↓              ↓
┌──────────────┐ ┌──────────────┐ ┌────────────────┐
│ us-east-2    │ │ eu-west-1    │ │ ap-northeast-1 │
│ (Ohio)       │ │ (Ireland)    │ │ (Tokyo)        │
├──────────────┤ ├──────────────┤ ├────────────────┤
│ ✅ Inference │ │ ✅ Inference │ │ ✅ Inference   │
│ ✅ KnowBases │ │ ✅ KnowBases │ │ ✅ KnowBases   │
│ ✅ Guardrails│ │ ✅ Guardrails│ │ ✅ Guardrails  │
│ ❌ Agents    │ │ ✅ Agents    │ │ ✅ Agents      │
│ ❌ API Keys  │ │ ✅ API Keys  │ │ ✅ API Keys    │
└──────────────┘ └──────────────┘ └────────────────┘
  99.9% SLA      99.9% SLA      99.9% SLA
```

**Benefits**: Full feature parity for core functionality, automatic failover, no additional latency

##### Pattern 2: Training + Inference

```text
┌─────────────────────────────────────────┐
│ us-east-1 (N. Virginia)                 │
│ ✅ Fine-tuning / Continued pre-training │
│ ✅ Custom model import                  │
└─────────────────────────────────────────┘
              ↓
    Train custom model
              ↓
┌──────────────────────────────────────────┐
│ Deploy to 3-region inference profile     │
└──────────────────────────────────────────┘
        ↓              ↓              ↓
┌──────────────┐ ┌──────────────┐ ┌────────────────┐
│ us-east-2    │ │ eu-west-1    │ │ ap-northeast-1 │
│ (Ohio)       │ │ (Ireland)    │ │ (Tokyo)        │
└──────────────┘ └──────────────┘ └────────────────┘
```

**Trade-offs**: Requires provisioned throughput, training latency 30-60 minutes

#### Implementation Strategy Recommendation

**Requirement**: Generate DocBook XML across us-east-2, eu-west-1, ap-northeast-1

1. Deploy model with cross-region inference profile
2. Use **eu-west-1 as primary** (has all features)
3. Automatic failover to ap-northeast-1 for HA
4. Use us-east-2 for cost optimization (if agents not needed)
5. If agents required: implement in eu-west-1, invoke from other regions via API

##### Step 1: Cross-Region Inference Profile

Inference profiles route requests across multiple regions without manual failover logic. This provides automatic HA, combines throughput capacity, and reduces latency by routing to the nearest available region. No additional cost—same per-token pricing applies.

##### Step 2: eu-west-1 as Primary

eu-west-1 has 17/19 features (89% coverage), including Agents and API keys that are missing in us-east-2. Using it as primary ensures full feature parity for core functionality (inference, guardrails, knowledge bases, agents). Other regions only activate on failure.

##### Step 3: Automatic Failover to ap-northeast-1

ap-northeast-1 also has 17/19 features and is geographically diverse from eu-west-1. If Ireland fails, Tokyo provides immediate backup with same feature coverage. Failover is transparent—no manual intervention or data reprocessing required.

##### Step 4: Cost Optimization with us-east-2

us-east-2 is ~5-10% cheaper than eu-west-1 for compute resources. Since us-east-2 supports inference, guardrails, and knowledge bases (the core DocBook generation features), it can be used for non-agent workloads to reduce costs. Falls back to eu-west-1 only when agents are needed.

##### Step 5: Agent Deployment in eu-west-1

Agents are only available in eu-west-1 and ap-northeast-1 (not us-east-2). Deploying the agent controller in eu-west-1 and invoking it via API from other regions allows teams in all three regions to use agent-based workflows. Adds ~50-100ms latency but avoids regional lock-in.
