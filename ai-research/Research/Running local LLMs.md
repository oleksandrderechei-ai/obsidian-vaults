---
id: 202512011327
aliases:
  - Local AI
  - Local Models
tags:
  - guide
  - howto
  - LLM
---

# Running local LLMs

## Context
<!-- What is this note about? -->

Onboarding guides:
- How to run locally LLMs
- Requirements
- Practical applications.

## Content
<!-- Main content goes here -->

|**Model Size**|**Quantization**|**Est. RAM Usage**|**Performance Experience**|
|---|---|---|---|
|**1B - 3B**|`FP16` (Full)|< 6 GB|**Instant.** Zero latency.|
|**7B - 10B**|`Q8` (High)|~10-12 GB|**Extremely Fast.** Ideal daily driver (e.g., Qwen 2.5 Coder 7B).|
|**14B - 20B**|`Q6` (Good)|~16-20 GB|**Very Fast.** Great balance of smarts/speed.|
|**32B**|`Q4_K_M`|~20-22 GB|**Fast.** The "sweet spot" for complex reasoning.|
|**70B**|`Q4_K_M`|~40-42 GB|**Doable but Tight.** Might slow down your system if you open Chrome/Docker.|