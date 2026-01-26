# How AWS Bedrock models works under the hood

AWS Bedrock operates as a **Serverless Model Gateway**. Unlike traditional machine learning workflows where you provision servers, install drivers, and load model weights, Bedrock abstracts the infrastructure entirely. You simply "rent" access to massive clusters of GPUs hosting foundation models via a unified API.

This article breaks down the architecture, deployment modes, and the secure journey of your data.

---

## 1. The Deployment Architecture

Physical foundation models (like Claude, Titan, or Llama) are hosted on AWS-managed infrastructure, completely separate from your own AWS account. This layer is often called the **"Bedrock Runtime"**.

There are two distinct ways to access these models:

### Mode A: On-Demand (Serverless)

This is the default for most serverless applications. AWS maintains a massive shared pool of models.

* **How it works:** Your request is routed to an available slot, processed, and the slot is immediately freed.
* **Billing:** You pay only for the input/output tokens processed.
* **Analogy:** **Uber.** You call a car, it takes you to your destination, and you leave. You don't own the car or pay for its maintenance.

### Mode B: Provisioned Throughput

This mode is for high-performance or guaranteed capacity needs.

* **How it works:** You reserve a specific number of "Model Units" (compute capacity) that act as dedicated lanes just for your traffic.
* **Billing:** You pay an hourly rate (24/7), regardless of whether you use it.
* **Analogy:** **Private Driver.** You hire a driver for 8 hours. You pay them even if the car sits idle in the driveway.

---

## 2. The Data Flow: Journey of a Prompt

When you send a request (e.g., *"Summarize this email"*), your data travels through a secure, private pipeline. If configured correctly using VPC Endpoints, it **never** hits the public internet.

Here is the step-by-step lifecycle of a request:

1. **Your Application:** Sends an API request (`InvokeModel`) containing your prompt.
2. **AWS Identity (IAM):** AWS first authenticates and authorizes the request: *Does this specific IAM role have permission to access 'anthropic.claude-3'?*
3. **Bedrock Gateway:** The request hits the regional Bedrock endpoint (e.g., `bedrock-runtime.us-east-1.amazonaws.com`).
4. **Model Routing:** Bedrock routes your request to a **dedicated model deployment account**.
    * *Crucial Detail:* AWS creates specific "escrow" accounts for third-party providers (like Anthropic or Cohere). The provider's software runs there, but **they do not have access to the logs or your data**.
5. **Inference:** The model processes the text and generates the tokens.
6. **Return:** The response is sent back to your application over TLS 1.2+ encryption.

---

## 3. Data Privacy: The "Golden Rule"

For enterprise adoption, data privacy is the primary concern. Bedrock enforces strict isolation.

* **No Training:** AWS explicitly states that your inputs (prompts) and outputs are **NOT** used to train the base foundation models. Anthropic cannot learn from your company's secrets.
* **No Logging (Default):** By default, Bedrock does *not* log your prompt text. If you require logs for auditing purposes, you must explicitly enable "Model Invocation Logging" and configure it to send data to your own S3 bucket or CloudWatch.
* **Encryption:** Data is encrypted in transit (TLS) and at rest. You can use your own Customer Managed Keys (AWS KMS) to encrypt data stored in Knowledge Bases or Agents.

---

## 4. Technical Abstraction

Under the hood, Bedrock uses a **Unified Interface** to simplify development.

* **Single API:** Whether you use a Meta model, an Amazon model, or an Anthropic model, the connection method is identical. You use the same `boto3` client; only the `modelId` and the JSON body payload change slightly.
* **Regional Isolation:** All processing happens in the Region you select. If you call `us-east-1`, your data stays in Northern Virginia unless you explicitly use **Cross-Region Inference Profiles** to route traffic across a broader geographic zone (e.g., US or EU).
