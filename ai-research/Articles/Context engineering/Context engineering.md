---
id: 202512051519
tags:
 - context_engineering
 - ai
 - llm
 - generative_ai_tools
 - software_development
seo_title: "Context Engineering: Better LLM Inference"
seo_description: "Simple prompting not enough for complex tasks. Explore Context Engineering, Sessions, and Memory to manage resources and improve LLM inference quality."
---

# Context engineering

## TLDR;

We’ve mastered the art of the single prompt.

Code generation, document summarization, translation — all in milliseconds. It feels like magic. But let's be honest: this only works when the questions are simple.

We are leaving the era of Prompt Engineering and entering the era of #context_engineering.

It’s no longer about finding the perfect word for your prompt. It’s about optimizing finite resources: the context window, token economy, latency, and persistence. To build consistent, high-quality inference today, you need to master 3 core concepts:

1. **Context Engineering** — the architecture of gathering, pruning, and managing the exact information your #ai_agent needs.
2. **Sessions** The container for the conversation. It holds the immediate history and the agent’s short-term working memory.
3. **Memory** The mechanism for long-term persistence. This captures knowledge across multiple sessions, allowing the LLM to actually "know" the user over time.

👇 **Read the full deep dive below.**
   
 Read more — LINK 

## Context Engineering

LLMs are inherently stateless, outside of their training data, their reasoning and awareness are confined to the information provided within the context window of a single API call.

With that said LLM calls doesn't automatically know the context of problem you want to solve. Therefore, before it can do anything, it better to provide some information to the prompt:
- **Agent role**
- **Agent tone**
- **Context**
- **Rules** — instructions on what actions it is allowed to take.
- **Facts** — the data and evidence it needs to reason and answer questions.
- etc...

When you programming LLM agent, you usually setup this information in the #system_prompt in addition to that providing conversation history and observations, inject external data to the user messages to personalize answers for every single message, this process called — **Context Engineering**.

Context Engineering represents an evolution from traditional prompt engineering. Prompt engineering focuses on crafting optimal, often static, system instructions. Context Engineering addresses the entire payload, dynamically constructing a state-aware, prompt based on the user data and conversation history. The process is dynamic, it should: select, summarize, and inject different types of information in the context — to maximize relevance while minimizing noise.

> The main idea is to curate and orchestrate sub-agents to answer the main question "42".

The dynamic construction of context is critical due to dialog nature.

> One of the most critical challenges in building a context-aware agent is managing an  ever-growing conversation history, as the context grows, cost and latency increase as well. Additionally, models can suffer from #context_rot

**Context rot** — a phenomenon where their ability to pay attention to critical information decrease as context grows.

To preserve vital information while managing the overall token count we dynamically mutate the history, for example we can use:
- **summarization**
- **selective pruning context**
- **quantization**
- or other compaction techniques...

Successfully managed context will ultimately lead to more robust and personalized AI experiences.

### Context management for the agent

![[Context management flowchart.png]]

1. **Fetch context** — the agent begins by retrieving context such as user memories, RAG documents, and recent conversation events. For dynamic context retrieval, the agent will use the user query and other metadata to identify what information to retrieve.
2. **Prepare context** — the agent framework dynamically constructs the full prompt for the LLM call. Although individual API calls may be asynchronous, preparing the context is a blocking, "hot-path" process. The agent cannot proceed until the context is ready.
3. **Invoke LLM and tools** — the agent iteratively calls the LLM and any necessary tools until a final response for the user is generated. Tool and model output is appended to the context.
4. **Upload context** — new information gathered during the turn is uploaded to persistent storage. This is often a "background" process, allowing the agent to complete execution while memory consolidation or other post-processing occurs asynchronously.

>At the heart of this lifecycle are two fundamental components: **sessions** and **memory**. A session manages the turn-by-turn state of a single conversation. Memory, in contrast, provides the mechanism for long-term persistence, capturing and consolidating key information across multiple sessions.

## Sessions

> Sessions also referred, as Short Term Memory (STM)

Session encapsulates the immediate dialogue history and working memory for a single, continuous conversation. Each session is a self-contained record that is tied to a specific user.

The session allows:
 - the agent to maintain context.
 - provide coherent responses within a single conversation.
 - user have multiple sessions.

 Every session contains two key components:
 - **events** — the chronological history, they are the building blocks of the conversation
 - **state** — a structured "working memory" or scratchpad. This holds temporary, structured data relevant to the current conversation.

Common event types:
- **user input** — a message from the user (text, audio, image, etc.)
- **agent response** — the agent's reply to the user
- **tool call** — the agent’s decision to use an external tool or API
- **tool output** — the data returned from a tool call, which the agent uses to continue its reasoning.

As the conversation progresses, the agent will append additional events to the session. Additionally, it may mutate the state based on logic in the agent.

A production agent's execution environment is typically stateless, meaning it retains no information after a request is completed. Consequently, its conversation history must be saved to persistent storage to maintain a continuous user experience.

> For development usage  of In-memory storage is acceptable, however for production applications robust and reliable persistent storage is required to store and manage sessions.

> Agent frameworks act as abstraction layer between your code and a LLM. This abstraction allow to decouple agent's logic from the specific LLM — preventing vendor lock-in.

### Multi-agent sessions

In a multi-agent system each agent **focuses** on a **smaller (specialized) task**. For these agents to work together effectively, they **must share information**. In every multi-agent architecture central component — is agents session.

There are many [multi-agent architectural patterns](https://docs.cloud.google.com/architecture/choose-design-pattern-agentic-ai-system), for example:

![[Multi-agent patterns.png]]

> Agents session is persistent log of all user interactions during time span.
> Agent context is selectively crafted slice of user log.

There are 2 types of sessions, based on usage:
1. **shared** — every agent's message, tool call, and observation is appended to one central log in chronological order. This approach is best for tightly coupled, collaborative tasks requiring a single source of truth, such as a multi-step problem-solving process where one agent's output is the direct input for the next.
2. **separated** — each agent maintains its own private conversation history and functions like a black box to other agents. This interaction is typically implemented by either implementing #agent-as-a-tool or using the #A2A [(Agent-to-Agent Protocol)](https://agent2agent.info/docs/introduction/). 

### Cross-framework communication

![[a2a protocol.png]]

Internal framework abstractions introduces a critical trade-off — it decouples an agent from LLM but enforce ecosystem isolation (silo effect). **This isolation is particularly dangerous because it locks you in at the database level**.

To address isolation problem we can use A2A protocol. While this pattern enables agents to exchange messages, it fails to address the core problem of sharing rich, contextual state. Each agent's conversation history is encoded in its framework's internal schema. As a result, any A2A message containing session events requires a translation layer.

> A more robust architectural pattern for interoperability involves abstracting shared knowledge into a framework-agnostic data layer, such as Memory.

Unlike a session store, which preserves raw, framework-specific objects like events and messages, a memory layer is designed to hold processed, canonical information, like:
- summaries
- extracted entities
- facts

The memory layer’s data structures are not coupled to any single framework's internal data representation, which allows it to serve as a **universal, common data layer**. This pattern allows agents to achieve true collaboration by sharing a common cognitive resource without requiring custom translators.

### Sessions production requirements

When moving an agent to a production environment, its session management system must require focus on three critical areas:
- [Security and privacy](#security-and-privacy)
- [Data integrity](#data-integrity)
- [Performance](#performance)

#### Security and privacy

Protecting the sensitive information contained within a session is a non-negotiable requirement. **Strict Isolation** is the most critical security principle. A session is owned by a single user, and the system must enforce strict isolation to ensure one user can never access another user's session data. Every request to the session store must be authenticated and authorized against the session's owner.

A best practice for handling Personally Identifiable Information (PII) is to **redact it before the session data is ever written to storage**. This is a fundamental security measure that drastically reduces the risk and "blast radius" of a potential data breach.

> By ensuring sensitive data is never persisted, you simplify compliance with privacy regulations like GDPR and CCPA and build user trust.

#### Data integrity

A production system requires clear rules for how session data is stored and maintained over time. **Sessions should not live forever**. You can implement a Time-to-Live (TTL) policy to automatically delete inactive sessions to manage storage costs and reducing data management overhead. This requires a clear data retention policy that defines how long sessions should be kept before being archived or permanently deleted.

Additionally, the system must guarantee that operations are appended to the session history in a deterministic order.

> Maintaining the correct chronological sequence of events is fundamental to the integrity of the conversation log.

#### Performance

Session data is on the "hot path" of every user interaction, making its **performance a primary concern**. Reading and writing the session history must be extremely fast to ensure a responsive user experience. Agent runtimes are typically stateless, so the entire session history is retrieved from a central database at the start of every turn, incurring network transfer latency.

> To mitigate latency, it is crucial to reduce the size of the data transferred. A key optimization is to filter or compact the session history before sending it to the agent.

### Long context compaction strategies (tradeoffs and optimizations)

In a simplistic architecture, a session is an immutable log of the conversation between the user and agent. However, as the conversation scales, the conversation’s **token usage increases**.

There are several limitation to consider:
- **Context window** — If the conversation history exceeds this limit, the API call will fail.
- **API cost** — LLM providers charge based on the number of tokens you send and receive.
- **Latency** — sending more text to the model takes longer to process, resulting in a slower response time for the user.
- **Quality** — as the number of tokens increases, performance can get worse due to additional noise in the context and autoregressive errors.

Compaction strategies shrink long conversation histories, condensing dialogue to fit within the model's context window, reducing API costs and latency.

Compaction strategies:
- **Keep the last N turns** — The agent only keeps the most recent N turns of the conversation #sliding_window and discards everything older.
- **Token-based truncation** — Before sending the history to the model, the agent counts the tokens in the messages, starting with the most recent and working backward. It includes as many messages as possible without exceeding a predefined token limit.
- **Recursive summarization** — Older parts of the conversation are replaced by an AI-generated summary. As the conversation grows, the agent periodically uses another LLM call to summarize the oldest messages. This summary is then used as a condensed form of the history, often prefixed to the more recent, verbatim messages.

Given that sophisticated compaction strategies aim to reduce cost and latency, it is critical to perform expensive operations (like recursive summarization) asynchronously in the background and persist the results, ensures the client is not kept waiting.

The agent must also keep a record of which events are included in the compacted summary — this prevents the original, more verbose events from being needlessly sent to the LLM.

Additionally, the agent must decide when compaction is necessary. The trigger mechanism generally falls into a few distinct categories:
- **Count-based triggers** — the conversation is compacted once the conversation exceeds a certain predefined threshold. This approach is often “good enough" for managing context length.
- **Time-based triggers**
- **Event-based triggers** — the agent decides to trigger compaction when it detects that a specific task, sub-goal, or topic of conversation has concluded.
  
  > Memory is built on compaction.
  
  ## Memory

#Memory and #Sessions share a deeply symbiotic relationship: sessions are the primary data source for generating memories, and memories are a key factor for managing the size of a session. A memory is a snapshot of extracted, meaningful information from a conversation or data source. It’s a condensed representation that preserves important context, making it useful for future interactions. Generally, memories are persisted across sessions to provide a continuous and personalized experience.

> Memory also referred, as Long Term Memory (LTM)

LTM unlocking several key capabilities:
- **Personalization** — the most common use case is to remember user preferences, facts, and past interactions to tailor future responses.
- **Context window management** — as conversations become longer, the full history can exceed an LLM's context window. Memory systems can compact this history by creating summaries or extracting key facts, preserving context.
- **Data mining and Insight** — by analyzing stored memories across many users, you can extract insights from the noise.
- **Agent self-improvement and adaptation** — the agent learns from previous runs by creating procedural memories about its own performance. Agent record which strategies, tools, or reasoning paths led to successful outcomes. This enables the agent to build a playbook of effective solutions, allowing it to adapt and improve its problem-solving over time.

**Agent data lifecycle flow chart**

![[Agent information flow.png]]

On the flow chart both RAG and Memory provide information to the agent, the difference is that — RAG makes agent expert on facts, and Memory — expert on user. RAG and Memory are complementary systems.

### Memory components:

1. **Content** — is the data that was extracted from the source. Content types:
	- **Structured memories** — structured data, for example JSON.
	- **Unstructured memories** — usually natural language descriptions.
2. **Metadata** — provides context about the memory, typically stored as a simple string.

### Memories classifications

#### By agent usage

- **Declarative memories** — "knowing what" for example: the agent's knowledge of facts, figures, and events.
- **Procedural memories** — "knowing how", for example: the agent's knowledge of skills and workflows.

#### By creation

- **Explicit memories** — are created when the user gives a direct command to the agent to remember something.
- **Implicit memories** — are created when the agent infers and extracts information from the conversation without a direct command.

#### By memory scope

- **User-level** — is the most common implementation, designed to create a continuous, personalized experience for each individual.
- **Session-level** —  are memories designed for the compaction of long conversations.
- **Application-level** — are memories accessible by all users of an application;

### Memory organization

Memory managers typically apply on of the following patterns:
- **Structured user profile** — pattern organizes memories as a set of core facts about a user. It’s designed for quick lookups of essential, factual information like names, preferences, and account details.
- **Rolling summary** — pattern consolidates all information into a single memory that represents a natural-language summary of the entire user-agent relationship. relationship. Instead of creating new, individual memories, the manager continuously updates this one master document. This pattern is frequently used to compact long Sessions, preserving vital information while managing the overall token count.

### Storage architectures

Memories are generally stored in vector databases and/or knowledge graphs. Vector databases help find memories that are conceptually similar to the query. Knowledge graphs store memories as a network of entities and their relationships.

**Vector databases** — the most common approach, enabling retrieval based on semantic similarity rather than exact keywords. Memories are converted into embedding vectors, and the database finds the closest conceptual matches to a user's query. This excels at retrieving unstructured, natural language memories where context and meaning are key “[atomic facts”](https://arxiv.org/pdf/2412.15266).

**Knowledge graphs** — used to store memories as a network of entities (nodes) and their relationships (edges). Retrieval involves traversing this graph to find direct and indirect connections, allowing the agent to reason about how different facts are linked. It is ideal for structured, relational queries and understanding complex connections within the data “[knowledge triples](https://arxiv.org/pdf/2412.15266)”.

**Hybrid approach** — offering the best of both worlds, by enriching a knowledge graph's structured entities with vector embeddings. This enables the system to perform both relational and semantic searches simultaneously. This provides the structured reasoning of a graph and the nuanced, conceptual search of a vector database.

### Memory Generation: Extraction and Consolidation

Memory generation autonomously transforms raw conversational data into structured, meaningful insights. Think of it as an **LLM-driven ETL** (Extract, Transform, Load) **pipeline** designed to extract and condense memories. 

> This automation is a memory manager’s core strength; it abstracts away the complexity of managing the database contents, chaining together LLM calls, and deploying background services for data processing.

![[Memory generation algorithm.png]]

#### Memory Extraction

**Memory Extraction** — is a process designed to get information by separation the signal from the noise. Usually this is achieved by #prompt-engineering and delegating this work to LLM. #few-shot-prompting is the common strategy for extraction.

#### Memory Consolidation

Consolidation process is an LLM-driven workflow that compares newly extracted insights against the user's existing memories. The primary operations include:
- **Update**
- **Create**
- **Delete**

Consolidation addresses fundamental problems arising from conversational data, including:
- **Information Duplication**
- **Conflicting Information**
- **Information evolution**
- **Memory relevance decay**

The process of memory consolidation — merging information from multiple sources into a single, evolving memory creates the need to track its lineage. A single memory might be a blend of multiple data sources, and a single source might be segmented into multiple memories.

To assess trustworthiness, the agent must track key details for each source, such as its origin and age. These details are critical for two reasons: they dictate the weight each source has during memory consolidation, and they inform how much the agent should rely on that memory during inference.

> The source type is one of the most important factors in determining trust.

Data sources fall into three main categories:
- **Bootstrapped data** — information pre-loaded from internal systems. This high-trust data can be used to initialize a user's memories to address the cold-start problem.
- **User input** — this includes data provided explicitly (high-trust data) or information extracted implicitly from a conversation (less trustworthy).
- **Tool output** — data returned from an external tool call. Output is generally discouraged because these memories tend to be brittle and stale.

Memory consolidation inevitably leads to conflicts where one data source conflicts with another. A memory manager establish a hierarchy of trust for its information sources. When memories from different sources contradict each other, the agent must use this hierarchy in a conflict resolution strategy. Common strategies include:
- prioritizing the most trusted source
- favoring the most recent information
- looking for corroboration across multiple data points.

Efficient memory system must also actively curate its existing knowledge through memory pruning — a process that identifies memories that are no longer useful and delete them. Pruning  factors:
- Time-based Decay
- Low Confidence
- Irrelevance

#### Memory Generation

After consolidation once generation is triggered, the agent must still decide when memory generation should be attempted. This is a critical architectural choice, balancing data freshness against computational cost and latency. This decision is typically managed by the agent's logic, which can employ several triggering strategies. Memory generation can be initiated based on various events:
- **Session completion**
- **Turn cadence**
- **Every turn**
- **Explicit command**

Memory Generation is an expensive operation requiring LLM calls and database writes. 

> For agents in production, memory generation should almost always be handled asynchronously as a background process.

After an agent sends its response to the user, the memory generation pipeline can run in parallel without blocking the user experience. This decoupling is essential for keeping the agent feeling fast and responsive.

#### Memory Retrieval

Retrieving a memory depends heavily on how memories are organized. For a structured user profile, retrieval is typically a straightforward lookup for the full profile or a specific attribute.

For a collection of memories, however, retrieval is a far more complex search problem. The goal is to discover the most conceptually related information from a large pool of unstructured or semi-structured data.

Advanced memory systems go beyond a simple search and score potential memories across multiple dimensions to find the best fit:
- **Relevance**
- **Recency**
- **Importance**

> Relying solely on vector-based relevance is a common pitfall. Similarity scores can surface memories that are conceptually similar but old or trivial. The most effective strategy is a blended approach that combines the scores from all three dimensions.

The final architectural decision for retrieval is when to retrieve memories. One approach is **proactive retrieval**, where memories are automatically loaded at the start of every turn. This ensures context is always available but introduces unnecessary latency for turns that don't require memory access. Since memories remain static throughout a single turn, they can be efficiently cached to mitigate this performance cost.

Alternatively, you can use **reactive retrieval** where the agent is given a tool to query its memory, deciding for itself when to retrieve context. This is more efficient and robust but requires an additional LLM call, increasing latency and cost; however, memory is retrieved only when necessary, so the latency cost is incurred less frequently.

### Inference with Memories

Once relevant memories have been retrieved, the final step is to strategically place them into the model's context window. This is a critical process; the placement of memories can significantly influence the LLM's reasoning, affect operational costs, and ultimately determine the quality of the final answer.

Memories are primarily presented by appending them to system instructions or injecting them into conversation history. In practice, a **hybrid strategy is often the most effective**. 

Use the system prompt for stable, global memories and use dialogue injection for episodic memories that are only relevant to the immediate context of the conversation.

### Testing and Evaluation

**Memory generation quality metrics** evaluate the content of the memories answering the question: "Is the agent remembering the right things?" This is typically measured by comparing the agent's generated memories against a manually created 
set" of ideal memories:
- **Precision** — of all the memories the agent created, what percentage are accurate and relevant? 
- **Recall** — of all the relevant facts it should have remembered from the source, what
percentage did it capture?
- **F1-Score** — the harmonic mean of precision and recall, providing a single, balanced
measure of quality.

**Memory retrieval performance metrics** evaluate the agent's ability to find the right memory at the right time:
- **Recall@K** — when a memory is needed, is the correct one found within the top 'K' retrieved results?
- **Latency** — retrieval is on the "hot path" of an agent's response. The entire retrieval process must execute within a strict latency budget (e.g., under 200ms) to avoid degrading the user experience.

**End-to-End task success metrics** are the ultimate test, answering the question: "Does memory actually help the agent perform its job better?". The judge determines if the agent's answer was accurate, effectively measuring how well the memory system contributed to the final outcome.

> Evaluation is not a one-time event; it’s an engine for continuous improvement. The metrics above provide the data needed to identify weaknesses and systematically enhance the memory system over time.

###  Memory production requirements

Critical requirements for memory are — performance, scalability, resilience, and security. To ensure the system remains reliable under load and protects the user experience, a robust memory architecture relies on four key strategies:

- **Decoupled, Asynchronous processing** — memory generation should be isolated from the main application logic to prevent blocking user interactions. This is achieved via non-blocking API calls where the agent "pushes" raw data to a memory manager. The manager acknowledges the request immediately but processes the computationally expensive LLM tasks (extraction, consolidation) in the background using an internal managed queue.
- **Concurrency control** The system must handle high-frequency events without data corruption. It prevents race conditions and deadlocks caused by multiple events modifying the same memory through transactional database operations or optimistic locking. A robust message queue is essential to buffer event volume and prevent service overload.
- **Resiliency, Error handling** The architecture must account for transient failures (e.g., LLM timeouts). This includes implementing retry mechanisms with exponential backoff and routing persistent failures to a dead-letter queue for later analysis, ensuring that a single failure does not crash the pipeline.
- **Global consistency** For distributed applications, the storage layer requires built-in multi-region replication to ensure low latency and high availability. Crucially, replication must be handled internally by the database (not the client) to maintain a single, transactionally consistent view of the knowledge base across all regions.

## Conclusion

**Context engineering** is the discipline of dynamically assembling conversation history, memories, and external knowledge into an LLM's context window to create actionable intelligence. It relies on the interplay between two systems:

1. **Sessions (STM):** Acting as a low-latency container for a single conversation, the Session prioritizes performance and security. It utilizes extraction techniques (like truncation or recursive summarization) to prevent context overflow and enforces PII redaction before data is persisted.
2. **Memory (LTM):** Memory makes the agent an expert on the user (distinct from RAG, which provides factual expertise). It functions as an active, asynchronous **LLM-driven ETL pipeline**.

This architecture decouples immediate interaction from heavy processing, ensuring a responsive user experience while building a coherent, adaptive knowledge base.