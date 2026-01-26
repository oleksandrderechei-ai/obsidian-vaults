# Model Licensing & Data Privacy in AWS Bedrock

## Key Principle

**Data stays in AWS** ≠ **No licensing concerns**

Even though your data never leaves AWS with Bedrock:

- Model licenses still apply to how you can use the model
- Some models require EULA (End User License Agreement) acceptance
- Different licenses have different restrictions on usage

---

## How to Check Model Licenses

### 1. Bedrock Console: Model Catalog

Navigate to **Amazon Bedrock → Model Catalog**:

- View each model's provider and licensing info
- Some models show licensing details in the model card
- Look for "View Terms" or "License" links

### 2. Check Model Details via AWS Docs

[Supported foundation models in Amazon Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)

Table includes:

- Provider name
- Model name
- License type (if documented)

### 3. Review EULA Before Enabling

**For third-party models:**

1. Go to **Model access** in Bedrock console
2. Select the model you want to enable
3. Review terms and conditions (EULA link provided)
4. Accept or decline before enabling

**Important**: Using/invoking a third-party model = acceptance of its EULA

### 4. Provider-Specific Steps

#### Anthropic Models (Claude)

1. First-time use requires **one-time use case submission**
2. Submit via: **Model Catalog → Claude 3.x → View Subscription**
3. Answer use case details (what will you use Claude for?)
4. Upon approval, model access enabled automatically
5. EULA acceptance required

#### Open-Source Models (Llama, Mistral)

1. Licensed under open-source licenses (varies: Meta, Mistral, etc.)
2. Review original license from model provider
3. Bedrock doesn't restrict usage but your use must comply with the license
4. No additional form needed if using via Bedrock

#### Amazon Models (Titan, Nova)

1. Amazon-owned, proprietary licenses
2. Standard AWS service terms apply
3. No additional EULA or use case form required
4. Available immediately with AWS account

---

## License Types & Restrictions

### Proprietary Commercial Licenses

**Examples**: Claude (Anthropic), GPT-4 (OpenAI), Cohere Command

**Typical restrictions**:

- Cannot use to train other models (competitive restriction)
- May have usage limits per contract
- Commercial use allowed
- Data not used to improve the model (critical for Bedrock)

**Verify**: Check AWS service terms and vendor's published license

### Open-Source Licenses

**Examples**: Llama 2/3 (Meta LLAMA2 Community License), Mistral (Apache 2.0)

**Typical restrictions**:

- Attribution required in some cases
- Can fine-tune and deploy (varies)
- Cannot use to train certain competitive models
- Different by license type (MIT, Apache 2.0, custom, etc.)

**Verify**: Visit original repository (GitHub, HuggingFace)

### Amazon Proprietary

**Examples**: Titan, Nova

**Restrictions**:

- AWS terms apply
- Commercial use included with AWS account
- No separate licensing agreements needed

---

## Why Data Staying in AWS Matters for Licensing

| Aspect | Impact |
| -------- | -------- |
| **Data used for training** | If your data trained the model, license may restrict reuse of improved model |
| **Bedrock benefit** | Data never used for training → avoids this restriction |
| **Compliance** | HIPAA/GDPR-regulated data stays in AWS → meets data residency requirements |
| **License compliance** | Data isolation helps meet "no model improvement from your data" clause |
| **Multi-tenant isolation** | Each customer's data isolated → supports commercial licensing |

**Bottom line**: Bedrock's data privacy **supports** license compliance, not replaces it.

---

## Practical Workflow: Check Before Using

### Step 1: Identify Model & Provider

Model: Claude 3.5 Sonnet
Provider: Anthropic
License: Proprietary (requires EULA)

### Step 2: Review License Terms

1. Open [AWS Bedrock Model Access page](https://aws.amazon.com/bedrock/model-access/)
2. Select model → view details
3. For Anthropic: fill use case form
4. Read EULA link provided

### Step 3: Verify Data Privacy Requirements

1. Check your compliance needs (HIPAA? GDPR?)
2. Confirm Bedrock supports required regions
3. Enable PrivateLink if needed (VPC isolation)

### Step 4: Accept and Use

```bash
# AWS CLI: Create foundation model agreement
aws bedrock create-foundation-model-agreement \
  --model-id "anthropic.claude-3-5-sonnet-20241022-v2:0" \
  --region us-east-1

# Python SDK: Use model with confidence
client = boto3.client('bedrock-runtime')
response = client.converse(
    modelId='anthropic.claude-3-5-sonnet-20241022-v2:0',
    messages=[...]
)
```

By accepting the agreement, you confirm:

- You reviewed the license
- You understand terms
- Your data stays in AWS per Bedrock's privacy model

---

## Resources

- [Access Bedrock models](https://docs.aws.amazon.com/bedrock/latest/userguide/model-access.html)
- [Supported models & providers](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
- [Bedrock pricing](https://aws.amazon.com/bedrock/pricing/)
- [Third-party model licenses](https://aws.amazon.com/legal/bedrock/third-party-models/)
- [Model provider links](https://docs.aws.amazon.com/bedrock/latest/userguide/models-supported.html)
