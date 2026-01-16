# Practical EU AI Act Risk Guide for Developers 2026

## TL;DR

- The EU AI Act transforms risk categorization from "best practice" into a **mandatory gatekeeper** for market access
- AI systems are classified into four tiers: **Unacceptable, High, Limited, and Minimal Risk**
- Misclassification at design stage leads to costly late-stage retrofitting and potential market exclusion
- **Prohibited AI practices** (social scoring, subliminal manipulation, emotion recognition at work) are banned since Feb 2025
- Maximum fines: **€35M or 7% of global turnover** for prohibited practices

---

## What This Means for Paligo

Based on our internal assessment, Paligo's AI systems are classified as **Limited Risk** under the EU AI Act.

**What this means:**

- ⚠️ **Transparency obligations apply** — We must disclose to users when they are interacting with AI
- 📝 [Article 50](https://artificialintelligenceact.eu/article/50/) requirements are mandatory for our AI features
- ✅ No conformity assessments or EU database registration required
- ✅ No human oversight mandates beyond transparency

**What we must do:**

- 🏷️ Clearly label AI-generated content so users know it's not human-made
- 💬 Disclose when users are interacting with a chatbot or AI assistant
- 📋 Document our transparency measures (for audit readiness)
- 🔄 Re-evaluate classification when adding new AI capabilities

**What we should still consider:**

- 👁️ Monitor for any AI features that could trigger High-Risk classification (e.g., profiling, employment decisions)
- 📝 Consider voluntary adherence to EU codes of conduct beyond the minimum requirements

> 💡 **Bottom Line**
> Our Limited Risk classification means we must implement transparency disclosures under [Article 50](https://artificialintelligenceact.eu/article/50/). Users must always know when they're interacting with AI or viewing AI-generated content. However, we remain vigilant: any new AI feature touching sensitive areas (hiring, content moderation with profiling, biometrics) would require immediate re-classification to High-Risk.

---

## 1. The Landscape of AI Governance: From Trust to Mandate

The EU AI Act transforms risk categorization from voluntary "best practice" into a **mandatory gatekeeper for market access**. Unlike the flexible NIST AI RMF framework, it enforces specific safety thresholds using a **"proportionate risk methodology"**—regulatory burden scales with potential impact on health, safety, and fundamental rights. For businesses, this creates a "Dual Compliance Burden" overlapping with NIS 2 (cybersecurity) and DORA (financial resilience).

---

## 2. The Four-Tiered Taxonomy: Defining the Thresholds of Risk

The EU’s risk hierarchy is designed to ensure that regulatory burdens do not stifle innovation for low-impact applications. While the vast majority of systems fall into the "Minimal" category, those that cross into "High-Risk" or "Unacceptable" tiers face the heaviest compliance weights in the digital economy.

| Risk Category | Legal Status | Primary Examples | Core Strategic Impact |
| -------------- | ------------- | ----------------- | ---------------------- |
| 🔴 **Unacceptable Risk** | Prohibited | Social scoring, subliminal manipulation, emotion recognition in workplaces, untargeted facial scraping | Immediate market ban. Maximum fines: **€35M or 7%** of global turnover |
| 🟠 **High Risk** | Strictly Regulated | Recruitment tools, credit scoring, critical infrastructure, medical devices | Mandatory conformity assessments, registration in EU database, and human oversight |
| 🟡 **Limited Risk** | Transparency Obligations | Chatbots, deepfakes, AI-generated content | [Article 50](https://artificialintelligenceact.eu/article/50/): Mandatory disclosure to end-users that they are interacting with AI |
| 🟢 **Minimal/No Risk** | Unregulated | Spam filters, AI-enabled video games, inventory management | No mandatory requirements; voluntary codes of conduct encouraged |

> ⚠️ **Strategic Warning**
> Misclassification at the design stage is a catastrophic failure. Misidentifying a system as "Minimal" when it meets "High-Risk" criteria leads to significant ROI loss through late-stage compliance retrofitting and potential market exclusion.

---

## 3. Critical Filter: Identifying "Unacceptable Risk" (Prohibited AI)

"Unacceptable Risk" represents the non-negotiable boundary of AI governance, where functionality conflicts fundamentally with Union values such as human dignity and non-discrimination. **Since February 2, 2025**, [Article 5](https://artificialintelligenceact.eu/article/5/) has prohibited the following eight practices:

### 3.1 Prohibited AI Practices ([Article 5](https://artificialintelligenceact.eu/article/5/))

| # | Prohibited Practice | Description |
| -- | -------------------- | ------------ |
| 1 | **Subliminal and Manipulative Techniques** | AI that distorts behavior beyond a person's consciousness to cause significant harm |
| 2 | **Exploitation of Vulnerabilities** | Systems targeting groups based on age, disability, or socio-economic circumstances to distort behavior |
| 3 | **Social Scoring** | Classification of individuals based on social behavior or traits leading to unfavorable treatment in unrelated contexts |
| 4 | **Predictive Policing** | Assessing criminal risk based solely on profiling or personality traits (exception: augmenting human assessments based on objective facts) |
| 5 | **Untargeted Facial Scraping** | Indiscriminate scraping of images from the internet or CCTV to expand facial recognition databases |
| 6 | **Emotion Recognition in Sensitive Contexts** | Inferring emotions in workplaces or educational institutions (exception: medical or safety reasons) |
| 7 | **Biometric Categorization** | Categorizing individuals by sensitive attributes (race, religion, political opinions, sexual orientation) |
| 8 | **Real-time Remote Biometric Identification (RBI)** | Using live facial recognition in public spaces for law enforcement |

### 3.2 Real-time RBI Exception

> 📍 **Important Note**
> The prohibition on Real-time RBI is not a blanket ban but a highly restricted practice. Use is permitted only for specific threats (missing persons, imminent terrorist threats, or serious crimes).

**Before deployment, law enforcement must:**

- Perform a Fundamental Rights Impact Assessment (FRIA)
- Obtain judicial authorization
- Register the system in the EU database

---

## 4. The High-Risk Decision Matrix: [Article 6](https://artificialintelligenceact.eu/article/6/) and [Annex III](https://artificialintelligenceact.eu/annex/3/) Criteria

For systems not prohibited, the High-Risk category is the most complex compliance area. Classification follows a **two-track system**: the [Annex I](https://artificialintelligenceact.eu/annex/1/) safety track and the [Annex III](https://artificialintelligenceact.eu/annex/3/) use-case track.

### 4.1 The Classification Protocol

| Step | Classification Check | Description |
| ----- | --------------------- | ------------ |
| 1️⃣ | **Safety Component Check ([Annex I](https://artificialintelligenceact.eu/annex/1/))** | Is the AI a safety component of a product—or a product itself—required to undergo third-party assessment under existing legislation (e.g., medical devices, machinery)? |
| 2️⃣ | **[Annex III](https://artificialintelligenceact.eu/annex/3/) Use-Case Filter** | Does the system fall under the eight sensitive areas? (Biometrics, Critical Infrastructure, Education, Employment, Essential Services, Law Enforcement, Migration, Justice) |
| 3️⃣ | **The Profiling Trigger (Red Line)** | Any [Annex III](https://artificialintelligenceact.eu/annex/3/) system performing "profiling" (automated processing of personal data to assess aspects of a person's life) is **always** classified as high-risk |

### 4.2 Derogations and Burden of Proof

Under **[Article 6(3)](https://artificialintelligenceact.eu/article/6/)**, an [Annex III](https://artificialintelligenceact.eu/annex/3/) system may escape the "High-Risk" label if it does not pose a significant risk of harm to health, safety, or fundamental rights. This applies to narrow procedural tasks or improvements to human activities.

> ⚠️ **Warning**
> The **provider bears the burden of proof** and must document this assessment before market entry. Failure to provide this documentation upon request triggers immediate market surveillance intervention.

---

## 5. Categorizing General-Purpose AI (GPAI) and Systemic Risk

GPAI models are "building blocks" regulated regardless of their ultimate application. The logic of regulation shifts here from "intended purpose" to **"inherent capability."**

### 5.1 GPAI Classification Thresholds

| Category | Threshold | Implications |
| --------- | ---------- | ------------- |
| **Indicative GPAI** | Training compute > 10²³ FLOPs + capabilities like language/video generation | Subject to GPAI provider obligations |
| **GPAI with Systemic Risk** | Training compute > 10²⁵ FLOPs OR "High-Impact Capabilities" | Presumed systemic risk; enhanced obligations apply |

> 💡 **High-Impact Capabilities Include:**
> Capabilities that could lower barriers for chemical or biological weapons development, or enable large-scale cyberattacks.

### 5.2 The Open-Source Exception

Providers of models released under **free and open-source licenses** are exempt from technical documentation requirements ([Article 53(1)(a) and (b)](https://artificialintelligenceact.eu/article/53/)).

**However:**

- Obligations to maintain a copyright policy ([53(1)(c)](https://artificialintelligenceact.eu/article/53/)) and publish a training summary ([53(1)(d)](https://artificialintelligenceact.eu/article/53/)) **still apply**
- This exception **vanishes entirely** if the model is deemed systemic
- Systemic models require adversarial testing and serious incident reporting

---

## 6. Global Context: Navigating Fractured Standards and Timelines

Governance occurs in a fractured landscape where **"Regulatory Arbitrage"** is becoming a corporate necessity.

### 6.1 Global Regulatory Landscape

| Jurisdiction | Approach | Key Developments |
| ------------- | --------- | ----------------- |
| 🇺🇸 **United States** | Innovation-first model | "Trump AI Reset" (2025): $500B infrastructure project; "Preventing Woke AI" Executive Order mandates ideological neutrality for federal procurement |
| 🇬🇧 **United Kingdom** | "Third Pillar" approach | Rejected EU-style AI Bill; Data (Use and Access) Act 2025 (DUAA) diverges from GDPR, favoring sector-led supervision |
| 🌏 **APAC** | Mixed approaches | China paused comprehensive AI law (2025); Singapore focuses on voluntary AI testing tools and lighter-touch governance |

### 6.2 EU AI Act Implementation Timeline

| Date | Milestone |
| ----- | ---------- |
| 🔴 **Feb 2025** | Prohibitions on Unacceptable Risk **active** |
| 🟠 **Aug 2025** | Governance rules and GPAI obligations apply |
| 🟡 **Aug 2026** | Full application for [Annex III](https://artificialintelligenceact.eu/annex/3/) High-Risk systems |
| 🟢 **Aug 2027** | Full application for High-Risk systems in [Annex I](https://artificialintelligenceact.eu/annex/1/) regulated products |

---

## 7. Executive Takeaways for Global Strategists

### 💻 Strategic Action Checklist

1. **Track Divergence** — Monitor policy shifts where US deregulation conflicts with EU prescription
2. **Strengthen Governance** — Reinforce internal data classification and transfer frameworks
3. **Stay Adaptable** — Build global AI principles but tailor regional controls (EU AI Act vs. UK DUAA)
4. **Factor in Geopolitics** — Recognize enforcement may be shaped by trade tensions
5. **Keep Ethics Central** — Focus on deceptive practices (AI-washing) and child safety

> 💡 **Key Insight**
> In this volatile environment, proactive governance is the only path to transforming regulatory risk into a competitive advantage. Those who anticipate the "conformity presumption" of harmonized standards will lead the next era of AI innovation.

---

### 📚 Official Resources & Further Reading

| Resource | Link |
| --------- | ----- |
| EU AI Act Portal | [artificialintelligenceact.eu](https://artificialintelligenceact.eu/) |
| NIST AI Risk Management Framework | [nist.gov/itl/ai-risk-management-framework](https://www.nist.gov/itl/ai-risk-management-framework) |
| European AI Office | [digital-strategy.ec.europa.eu](https://digital-strategy.ec.europa.eu/en/policies/ai-office) |

---
