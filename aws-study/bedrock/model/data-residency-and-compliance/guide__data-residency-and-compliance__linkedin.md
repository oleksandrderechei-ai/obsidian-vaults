"All Bedrock models are the same for compliance."
This assumption cost one team 3 months of rework.

Here's what they missed:

---

Not all models in AWS Bedrock are created equal.

Some are AWS-sold (zero vendor access).
Some are vendor-sold (EULA applies).
Some are from China-based companies.

---

After reviewing every vendor's EULA, here's the breakdown:

🟢 SAFEST for EU (GDPR + EU AI Act)

→ Amazon Nova/Titan — AWS-only, no third party
→ Anthropic Claude — EU entity (Ireland), explicit DPA
→ Mistral — Paris-based, GDPR-native

🟢 SOLID (AWS-sold, no vendor access)

→ Meta Llama — open license, AWS-hosted
→ Google Gemma — open license, AWS-hosted
→ NVIDIA NeMo — AWS DPA covers

🟡 REVIEW REQUIRED

→ DeepSeek — AWS-sold BUT China-origin (verify org policy)
→ Twelve Labs — strong terms BUT US jurisdiction (request DPA)
→ Writer AI — strong terms BUT US jurisdiction (request DPA)

---

The key distinction nobody talks about:

AWS-sold = vendor has ZERO access to your data
Vendor-sold = their EULA applies, verify terms

AWS quote that matters:

"Model providers don't have any access to those accounts."

For AWS-sold models, vendors literally cannot see your prompts.

---

What most teams get wrong:

1. Assuming "on AWS" = compliant ❌
2. Not checking if model is AWS-sold vs vendor-sold ❌
3. Skipping DPA verification for EU deployment ❌
4. Ignoring China-origin policies for DeepSeek ❌

---

Quick compliance checklist:

✅ Enable CloudTrail (audit logging)
✅ Configure Guardrails (PII redaction)
✅ Verify DPA exists for your region
✅ Document model selection rationale

---

🔗 Full guide with EULA analysis for every Bedrock provider:
https://medium.com/@odere.pub/aws-bedrock-data-residency-which-models-actually-keep-your-data-safe-c4eb35bb2224

Includes:

- AWS-sold vs vendor-sold breakdown
- Direct quotes from AWS Third-Party Terms
- EU AI Act readiness by provider
- ISO 42001 alignment checklist
- Model recommendations by use case

#AWS #Bedrock #GDPR #Compliance #EnterpriseAI
