# 🚀 AWS Serverless Image Processing Pipeline

## 📖 Overview

This repository contains the infrastructure and application code for a fully serverless, event-driven image processing pipeline on AWS. The system automatically reacts to image uploads, decoupling the ingestion process using SQS, and orchestrates a multi-step processing workflow (resize, watermark, metadata extraction) using AWS Step Functions and AWS Lambda.

Processed images are delivered globally with ultra-low latency via Amazon CloudFront, and processing metadata is stored in Amazon DynamoDB.

**This project was built as a graduation project for the AWS Solutions Architect - Associate program.**

---

## 🏗️ Solution Architecture Diagram

![Serverless Image Processing Pipeline Architecture](architecture/solution-diagram.png)
_(Note: Place your Lucidchart/diagram export in the `architecture/` folder and name it `solution-diagram.png` so this link works automatically)._

### Architecture Flow:

1. **Upload:** Client requests a pre-signed URL via **API Gateway** and uploads a raw image directly to the **S3 Source Bucket**.
2. **Event Trigger:** S3 publishes an `ObjectCreated` event to an **SQS Queue**, decoupling ingestion from processing.
3. **Trigger Orchestration:** A lightweight **Lambda Poller** consumes the SQS message and starts an **AWS Step Functions** state machine.
4. **Processing (Step Functions):**
   - **Lambda (Resize):** Downloads the image, resizes it using the `sharp`/`Pillow` Lambda Layer, and passes the buffer.
   - **Lambda (Watermark):** Overlays a logo onto the resized image and uploads it to the **S3 Destination Bucket**.
   - **Lambda (Metadata):** Extracts file dimensions, size, and timestamp, writing the state to **DynamoDB**.
5. **Notification:** Success or failure is published to an **SNS Topic**, alerting administrators.
6. **Edge Delivery:** End-users access the optimized, processed images globally via an **Amazon CloudFront** distribution.

---

## 🛠️ Key AWS Services Utilized

- **Amazon S3:** Source ingestion, destination storage, lifecycle rules (auto-deletion of raw images), and event notifications.
- **Amazon SQS & DLQ:** Message buffering to handle traffic spikes and dead-letter queues for failure isolation.
- **AWS Lambda & Lambda Layers:** Serverless compute for heavy image manipulation (using packaged external libraries).
- **AWS Step Functions:** Orchestration of the multi-step microservice workflow.
- **Amazon API Gateway:** Secure, serverless HTTP endpoints for pre-signed URL generation.
- **Amazon DynamoDB:** Highly scalable NoSQL state and metadata tracking.
- **Amazon CloudFront:** Global Content Delivery Network (CDN) with Origin Access Control (OAC).
- **Amazon SNS:** Pub/Sub notifications for workflow alerts.

---

## 📂 Repository Structure

```text
├── application/
│   ├── api/                      # Lambda code for API Gateway (Pre-signed URLs)
│   ├── processing/               # Lambda code for resizing and watermarking
│   └── metadata/                 # Lambda code for DynamoDB updates
├── architecture/
│   └── solution-diagram.png      # Visual architecture diagram
├── state-machine/
│   └── pipeline.asl.json         # Amazon States Language definition for Step Functions
├── lambda-layers/
│   └── sharp-layer.zip           # Packaged Node.js 'sharp' library dependencies
└── README.md                     # Project documentation
```

---

## ⚙️ Deployment Instructions

1. **Storage & Database:**

- Create the Source S3 bucket (enable a 3-day lifecycle expiration rule) and the Destination S3 bucket.
- Create a DynamoDB table named `ImageMetadata` with `imageId` as the Partition Key.

2. **Messaging:**

- Create an SNS Topic for alerts.
- Create an SQS Dead-Letter Queue (DLQ) and a Main SQS Queue. Configure the Main Queue's access policy to allow `s3:SendMessage` from your Source bucket.

3. **Compute & Orchestration:**

- Upload the `sharp-layer.zip` to AWS Lambda as a Layer.
- Deploy the processing Lambda functions and attach the Layer.
- Create the Step Functions state machine using the provided `pipeline.asl.json` definition.

4. **Edge & API:**

- Deploy the CloudFront distribution pointing to the Destination S3 bucket.
- Deploy the HTTP API Gateway and link it to the Pre-signed URL Lambda function.

---

## 👨‍💻 Author

**Abdullah Mahmoud**
_Data Engineering & AWS Cloud Architecture_
