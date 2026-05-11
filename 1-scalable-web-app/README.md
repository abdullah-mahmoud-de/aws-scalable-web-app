# Scalable Web Application with ALB and Auto Scaling (AWS)

## 📌 Project Overview
This project demonstrates the deployment of a production-grade web application on AWS using EC2 instances inside a properly architected Virtual Private Cloud (VPC). The architecture ensures high availability and fault tolerance by distributing resources across two Availability Zones. It leverages an Application Load Balancer (ALB), Auto Scaling Groups (ASG), and an Amazon RDS Multi-AZ database backend.

## 🏗️ Solution Architecture
![Solution Architecture Diagram](./architecture/web-app-pro-1-architecture-diagram.png)

*Briefly describe the flow of traffic from the user, through Route 53 and CloudFront, into the ALB, and down to the private EC2 compute and RDS data tiers.*

## 📂 Repository Directory Structure

```text
├── app/                      # Web application source code (e.g., HTML/PHP/Node.js files)
│   ├── index.html            # Main application entry point
│   └── assets/               # Static assets (images, CSS, JS) cached by CloudFront
├── architecture/             # Visual representations of the project
│   └── solution-diagram.png  # Exported Solution Architecture Diagram
├── infrastructure/           # Infrastructure as Code (IaC) files (if applicable)
│   ├── main.tf               # Primary Terraform configuration file (or CloudFormation template)
│   ├── variables.tf          # Variable definitions
│   └── outputs.tf            # Output values (e.g., ALB DNS name, CloudFront URL)
├── scripts/                  # Bootstrapping and automation scripts
│   └── userdata.sh           # Bash script for EC2 Launch Template (installs web server)
└── README.md                 # Complete project documentation and instructions
```

## 🛠️ Key AWS Services Utilized
* **Networking:** VPC (Public & Private subnets), NAT Gateway, Security Groups, NACLs.
* **Compute:** EC2, Launch Templates, Auto Scaling Group (ASG) with target tracking.
* **Load Balancing & Security:** Application Load Balancer (ALB), AWS WAF (OWASP Top 10 rules).
* **Database:** Amazon RDS Multi-AZ (MySQL/PostgreSQL) with automated failover.
* **Edge & DNS:** CloudFront for caching, Route 53 for DNS resolution and health checks.
* **Operations:** Systems Manager (Session Manager) for bastion-free secure access, CloudWatch & SNS for monitoring.

## 🚀 Deployment Instructions
*Detail the steps required to replicate your environment. If you used the Management Console, outline the phases. If you used IaC, provide the deployment commands.*
1. Build the network foundation (VPC, Subnets, NAT Gateways).
2. Establish the Security Groups and RDS Multi-AZ database.
3. Create the EC2 Launch Template with the `user-data.sh` script.
4. Deploy the ALB and attach the Auto Scaling Group.
5. Configure CloudFront and Route 53 alias records.

## 🎯 Learning Outcomes Achieved
* Designed a secure VPC with appropriate subnetting, route tables, and NAT Gateway configurations.
* Built a highly available, fault-tolerant architecture spanning multiple Availability Zones.
* Implemented dynamic Auto Scaling based on target tracking policies.
* Secured the application using AWS WAF, robust Security Groups, and private subnets.
* Eliminated the need for public IPs and bastion hosts by utilizing Systems Manager Session Manager.
