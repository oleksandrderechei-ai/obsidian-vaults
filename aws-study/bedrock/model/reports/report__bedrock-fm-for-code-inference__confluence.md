# Bedrock FM for Code inference

## Requirements

1. **Code generation** - primary capability needed
2. **Multi-language support** - Python, TypeScript, Java, Bash, SQL, CSS
3. **Data residency** - data must NOT leave AWS account
4. **Regional availability** - must work in:
   - us-east-2 (US/Ohio)
   - eu-west-1 (EU/Ireland)
   - ap-northeast-1 (Asia/Tokyo)

---

## TL;DR

- **Primary: Claude 3.7 Sonnet** – SOTA code generation (62.3% SWE-bench), extended thinking for debugging/architecture, agentic coding (Cursor/Cognition validated), all 3 regions, $60-120K/month.
- **Alternative: Claude 3.5 Sonnet v2** – Proven stability, batch inference (50% off), Agents, same 3 regions, $60K/month ($30K with batch).
- **Budget: Claude 3 Haiku** – Best quality-to-cost ($5K/month, 12x cheaper), batch support, all 3 regions.
- **Cross-region trade-off:** 3x throughput + failover but data may route to any region; use single-region for GDPR/HIPAA.

---

## Pre-Filtering

> 📋 **Steps 1-3 (Data Residency, Capability, Regional Availability) are identical to text generation selection.**
> See [model-selection-text-generation.md](report__model-selection-text-generation.md) for detailed filtering.

**Models remaining after pre-filtering**:

**Premium Tier**:

- Anthropic Claude 3.7 Sonnet
- Anthropic Claude 3.5 Sonnet (v2)
- Amazon Nova Pro

**Budget Tier**:

- Anthropic Claude 3 Haiku
- Amazon Nova Lite, Nova Micro
- Mistral Ministral 8B, Ministral 14B
- Google Gemma 3 4B, Gemma 3 12B

---

## Code Generation Evaluation

### Why Code Generation is Different from Text Generation

| Factor | Text Generation | Code Generation |
| --- | --- | --- |
| **Primary metric** | Fluency, coherence | Correctness, functionality |
| **Key benchmark** | MMLU, reasoning tests | SWE-bench, HumanEval |
| **Extended thinking** | Nice to have | Critical for complex problems |
| **Agentic capabilities** | Optional | Essential (file editing, tool use) |
| **Temperature** | 0.5-0.7 | 0.1-0.3 (deterministic) |
| **Validation** | Subjective quality | Objective (tests pass/fail) |

### Cost-Performance Trade-off

| Model | Quality Tier | Cost/1M calls | Best Use Case |
| --- | --- | --- | --- |
| Claude 3.7 Sonnet | 🟢 Highest | ~$60-120K | Complex debugging, architecture |
| Claude 3.5 Sonnet v2 | 🟢 High | ~$60K | Batch processing, stable prod |
| Nova Pro | 🟡 Good | ~$14K | Simple tasks, cost-conscious |
| **Claude 3 Haiku** | 🟡 Good | ~$5K | Best budget quality |
| Ministral 8B | 🟡 Moderate | ~$2.4K | Multilingual code |
| Nova Lite | 🟠 Basic | ~$1.1K | Templates, boilerplate |
| Gemma 3 4B | 🟠 Basic | ~$0.6K | Ultra-cheap completions |
| Nova Micro | 🟠 Basic | ~$0.6K | Fastest, lowest latency |

> ⚠️ **Note**: Amazon Nova benchmarks not published. SWE-bench measures ability to resolve real GitHub issues.

### Extended Thinking: The Key Differentiator

Claude 3.7 Sonnet is a **hybrid reasoning model** - it can operate in two modes:

| Mode | Use Case | Token Budget | Cost Impact |
| --- | --- | --- | --- |
| **Standard** | Simple code completion | 0 | Base price only |
| **Extended Thinking** | Complex debugging, architecture | 1K-128K | +thinking tokens at output rate |

**When to use extended thinking**:

- 🟢 Debugging complex issues across multiple files
- 🟢 Architectural decisions requiring trade-off analysis
- 🟢 Test-driven development (understand requirements → implement → verify)
- 🟢 Large-scale refactoring
- 🔴 Simple function completions (overkill, adds latency + cost)

**Extended thinking budget recommendations**:

| Task Complexity | Budget Tokens | Example |
| --- | --- | --- |
| Simple fix | 1,000-2,000 | Fix typo, add null check |
| Medium refactor | 5,000-10,000 | Refactor function, add feature |
| Complex debugging | 20,000-50,000 | Multi-file bug, race condition |
| Architectural | 50,000-100,000 | Design new module, migration plan |

### Agentic Coding Capabilities

For code generation in production, **agentic capabilities** matter:

| Capability | Description | Claude 3.7 | Claude 3.5 | Nova Pro |
| --- | --- | --- | --- | --- |
| **Tool Use** | Call external tools | 🟢 Best-in-class | 🟢 Good | 🟡 Basic |
| **File Editing** | Modify multiple files | 🟢 Excellent | 🟢 Good | 🟡 Limited |
| **Bash Execution** | Run commands | 🟢 Excellent | 🟢 Good | 🔴 No |
| **Test Execution** | Run and interpret tests | 🟢 Excellent | 🟢 Good | 🔴 No |
| **Bedrock Agents** | AWS Agent integration | 🟢 Yes | 🟢 Yes | 🔴 No |

> [!note]
> **Industry validation** (from [Anthropic announcement](https://www.anthropic.com/news/claude-3-7-sonnet)):
>
> - **Cursor**: "Best-in-class for real-world coding tasks"
> - **Cognition**: "Far better than any other model at planning code changes"
> - **Vercel**: "Exceptional precision for complex agent workflows"
> - **Replit**: "Build sophisticated web apps from scratch"
> - **Canva**: "Production-ready code with superior design taste"

---

## Final Recommendation

> **Data Sources**: [Feature Matrix](../data/bedrock_features_matrix.csv) | [Claude 3.7 Announcement](https://www.anthropic.com/news/claude-3-7-sonnet) | [AWS Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)

### Premium Tier - Complex Code Generation

| Aspect | 🏆 Claude 3.7 Sonnet | 🥈 Claude 3.5 Sonnet v2 | 🥉 Nova Pro |
| --- | --- | --- | --- |
| **Model ID** | `anthropic.claude-3-7-sonnet-20250219-v1:0` | `anthropic.claude-3-5-sonnet-20241022-v2:0` | `amazon.nova-pro-v1:0` |
| **Recommendation** | 🟢 **PRIMARY** | 🟢 **Alternative** | 🟢 **Budget option** |
| **SWE-bench Verified** | **62.3%** (SOTA) | 49% | N/A |
| **Extended Thinking** | 🟢 Yes (1K-128K budget) | 🔴 No | 🔴 No |
| **Agentic Coding** | 🟢 Excellent | 🟢 Good | 🔴 Limited |
| **Context Window** | 200K | 200K | 300K |
| **Best For** | Complex debugging, architecture | Batch processing, stable production | Simple completions, cost-sensitive |

#### Premium Tier Pricing

| Model | Input | Output | Extended Thinking | Monthly (1M calls)¹ |
| --- | --- | --- | --- | --- |
| **🏆 Claude 3.7 Sonnet** | $0.003/1K | $0.015/1K | $0.015/1K (same as output) | ~$60K-120K² |
| **🥈 Claude 3.5 Sonnet v2** | $0.003/1K | $0.015/1K | N/A | ~$60K |
| **🥉 Nova Pro** | $0.0008/1K | $0.0032/1K | N/A | ~$14K |

> [!note]
> ¹ Based on 10K input + 2K output tokens per request.
>
> ² Claude 3.7 cost varies by thinking budget (0-128K tokens/request).
>
> **Batch inference** (Claude 3.5, Nova): 50% discount. Claude 3.7 does NOT support batch.

---

### Budget Tier - Fast/Simple Code Tasks

For simple code completions, boilerplate generation, or high-volume low-complexity tasks, consider these cost-effective options:

| Aspect | Claude 3 Haiku | Nova Lite | Nova Micro | Ministral 8B | Gemma 3 4B |
| --- | --- | --- | --- | --- | --- |
| **Model ID** | `anthropic.claude-3-haiku-20240307-v1:0` | `amazon.nova-lite-v1:0` | `amazon.nova-micro-v1:0` | `mistral.ministral-8b-v1:0` | `google.gemma-3-4b-it-v1:0` |
| **Provider** | Anthropic | Amazon | Amazon | Mistral | Google |
| **Modality** | Text + Vision | Text + Vision | Text only | Text only | Text only |
| **Context Window** | 200K | 300K | 128K | 128K | 128K |
| **Designed For** | Fast, intelligent responses | Multimodal understanding | Ultra-low latency | Efficient inference | Lightweight tasks |

#### Budget Tier Pricing

| Model | Input/1K | Output/1K | Batch | Cost vs Claude 3.7 | Monthly (1M calls)¹ |
| --- | --- | --- | --- | --- | --- |
| **Claude 3 Haiku** | $0.00025 | $0.00125 | 50% off | **12x cheaper** | ~$5K |
| **Nova Lite** | $0.00006 | $0.00024 | 50% off | **50x cheaper** | ~$1.1K |
| **Nova Micro** | $0.000035 | $0.00014 | 50% off | **86x cheaper** | ~$0.6K |
| **Ministral 8B** | $0.00015 | $0.00015 | ❌ | **30x cheaper** | ~$2.4K |
| **Gemma 3 4B** | $0.00004 | $0.00008 | ❌ | **75x cheaper** | ~$0.6K |

> [!note]
> ¹ Based on 10K input + 2K output tokens per request.
>
> **Batch inference**: Claude 3 Haiku, Nova Lite, Nova Micro support 50% batch discount.

#### Budget Tier Feature Support

| Feature | Claude 3 Haiku | Nova Lite | Nova Micro | Ministral 8B | Gemma 3 4B |
| --- | --- | --- | --- | --- | --- |
| **Agents (Bedrock)** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Batch Inference** | 🟢 | 🟢 | 🟢 | ❌ | ❌ |
| **Guardrails** | 🟢 | 🟢 | 🟢 | ❌ | ❌ |
| **Knowledge Base** | 🟢 | 🟢 | 🟢 | ❌ | ❌ |
| **Token Counting** | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Prompt Caching** | 🟢 | ❌ | ❌ | ❌ | ❌ |

#### Why Not Newer Haiku Models?

| Model | Regional Status | Feature Status | Verdict |
| --- | --- | --- | --- |
| **Claude 3.5 Haiku** | 🔴 us-east-2 only | ❌ No eu-west-1, ap-northeast-1 | **Fails regional requirement** |
| **Claude Haiku 4.5** | 🟢 All 3 regions | ❌ No Bedrock features (Agents, Batch, etc.) | **No value over 3 Haiku yet** |

#### Budget Tier: When to Use

| Task | Best Model | Rationale |
| --- | --- | --- |
| **Inline code completion** | Nova Micro | Ultra-fast, cheapest |
| **Docstring generation** | Claude 3 Haiku | Best quality/cost ratio |
| **Boilerplate generation** | Nova Lite | Cheap, handles templates well |
| **Code comment translation** | Ministral 8B | Symmetric pricing, multilingual |
| **Simple refactoring** | Claude 3 Haiku | Best reasoning at budget price |
| **High-volume batch** | Nova Lite/Micro | 50% batch discount, cheapest |
| **RAG-augmented code Q&A** | Claude 3 Haiku | Knowledge Base integration |

---

### Feature Support Matrix (All Tiers)

| Feature | 🏆 Claude 3.7 | 🥈 Claude 3.5 | 🥉 Nova Pro | Claude 3 Haiku | Nova Lite | Nova Micro |
| --- | --- | --- | --- | --- | --- | --- |
| **Extended Thinking** | 🟢 | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Agents (Bedrock)** | 🟢 | 🟢 | ❌ | ❌ | ❌ | ❌ |
| **Batch Inference** | ❌ | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |
| **Token Counting** | 🟢 | 🟢 | ❌ | ❌ | ❌ | ❌ |
| **Guardrails** | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |
| **Prompt Caching** | 🟢 | 🟢 | 🟢 | 🟢 | ❌ | ❌ |
| **Knowledge Base** | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 | 🟢 |

---

### Recommendation Summary

#### Premium Tier (Complex Tasks)

| Use Case | Model | Rationale |
| --- | --- | --- |
| **Complex debugging** | 🏆 Claude 3.7 Sonnet | Extended thinking, SOTA SWE-bench |
| **Agentic coding (Claude Code style)** | 🏆 Claude 3.7 Sonnet | Best tool use, file editing |
| **Large-scale refactoring** | 🏆 Claude 3.7 Sonnet | Extended thinking for planning |
| **Production API (stable)** | 🥈 Claude 3.5 Sonnet v2 | Proven, batch inference |
| **Batch code review** | 🥈 Claude 3.5 Sonnet v2 | 50% batch discount |

#### Budget Tier (Simple/High-Volume Tasks)

| Use Case | Model | Rationale |
| --- | --- | --- |
| **Inline completions** | Nova Micro | Fastest, cheapest (86x savings) |
| **Simple code Q&A** | Claude 3 Haiku | Best reasoning at budget price |
| **Boilerplate/templates** | Nova Lite | Vision support, very cheap |
| **High-volume batch** | Nova Lite + Batch | 50% discount, ~$550/1M calls |
| **RAG code assistant** | Claude 3 Haiku | Knowledge Base integration |
| **Cost-constrained MVP** | Nova Micro | Minimum viable cost |

## Decision Summary

| Criterion | Result | Evidence |
| --- | --- | --- |
| Data stays in AWS | 🟢 | DPA-covered (Claude) or AWS-sold (Nova) |
| Code generation quality | 🟢 | Claude 3.7: 62.3% SWE-bench (SOTA) |
| Multi-language | 🟢 | Python, TypeScript, Java, Bash, SQL, CSS |
| Extended thinking | 🟢 | Claude 3.7 supports 1K-128K budget |
| Agentic coding | 🟢 | Claude 3.7 best-in-class (Cursor, Cognition validated) |
| Regional availability | 🟢 | All tiers available in 3 regions |
| Budget options | 🟢 | Claude 3 Haiku, Nova Lite/Micro for cost-sensitive |
| **FINAL VERDICT** | 🟢 **APPROVED** | **Premium: Claude 3.7 Sonnet** / **Budget: Claude 3 Haiku** |

### Quick Model Selection Guide

```text
Complex task?
├── YES → Need extended thinking?
│   ├── YES → Claude 3.7 Sonnet (PRIMARY)
│   └── NO → Batch processing?
│       ├── YES → Claude 3.5 Sonnet v2
│       └── NO → Claude 3.7 Sonnet
└── NO → Cost priority?
    ├── EXTREME → Nova Micro ($0.6K/1M calls)
    ├── HIGH → Nova Lite ($1.1K/1M calls)
    └── MODERATE → Claude 3 Haiku ($5K/1M calls, best quality)
```

---

## References

- [Claude 3.7 Sonnet Announcement](https://www.anthropic.com/news/claude-3-7-sonnet) - Benchmarks, extended thinking
- [Extended Thinking Documentation](https://docs.anthropic.com/en/docs/build-with-claude/extended-thinking)
- [SWE-bench Leaderboard](https://www.swebench.com/)
- [AWS Bedrock Pricing](https://aws.amazon.com/bedrock/pricing/)
- [Bedrock Batch Inference](https://docs.aws.amazon.com/bedrock/latest/userguide/batch-inference.html)

### Local Data Sources

- [Text Generation Selection](report__model-selection-text-generation.md) - Steps 1-3 filtering
- [Feature Matrix CSV](../data/bedrock_features_matrix.csv)
- [Compliance Guide](./AWS%20Bedrock%20Model%20Selection%20-%20Data%20Residency%20&%20Compliance%20Guide.md)
