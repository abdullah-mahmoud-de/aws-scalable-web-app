# Manara AWS SAA Projects - Project 1 - Web App

## Response:

Here is the step-by-step implementation guide to building this highly available, EC2-based architecture. We will structure this logically, starting from the network foundation up to the edge caching and monitoring layers.

### **Step 1: Build the Network Foundation (VPC)**

Before deploying any servers, you must create a secure, isolated network environment.

1.  **Create the VPC:** Deploy a Virtual Private Cloud (VPC) with a CIDR block large enough to accommodate your subnets.
2.  **Design Subnets:** Create subnets across exactly two Availability Zones to achieve high availability.
    - **Public Subnets:** For internet-facing resources (Load Balancers, NAT Gateways).

    - **Private Subnets:** For your compute instances and database backend.

3.  **Routing & Internet Access:** \* Attach an Internet Gateway to the VPC and route public subnet traffic to it.
    - Deploy a NAT Gateway in the public subnets.
    - Update the private subnet route tables to send outbound internet traffic to the NAT Gateway, allowing instances to download patches without being publicly exposed.

### **Step 2: Configure Security Groups & NACLs**

Implement a defense-in-depth approach to control traffic flow.

1.  **ALB Security Group:** Allow inbound HTTP (80) and HTTPS (443) traffic from the internet.
2.  **EC2 Security Group:** Allow inbound HTTP/HTTPS traffic _only_ from the ALB Security Group. This ensures users cannot bypass the load balancer.
3.  **RDS Security Group:** Allow database port traffic (e.g., 3306 for MySQL, 5432 for PostgreSQL) _only_ from the EC2 Security Group.
4.  **NACLs:** Set up Network Access Control Lists as an additional stateless firewall layer at the subnet level.

### **Step 3: Provision the Data Tier (RDS)**

Set up the stateful database backend before deploying the compute resources that rely on it.

1.  **Deploy RDS:** Launch an Amazon RDS instance (MySQL or PostgreSQL) into the private database subnets.
2.  **Enable Multi-AZ:** Configure the instance as Multi-AZ so AWS automatically maintains a synchronous standby replica in the second Availability Zone for automated failover.

### **Step 4: Build the Compute and Scaling Tier (EC2, ALB, ASG)**

Deploy the application logic so it can scale dynamically.

1.  **Create a Launch Template:** Define the EC2 configuration, including the AMI, instance type, and a bootstrap script (User Data) to install your web application. Attach an IAM role with permissions for AWS Systems Manager.
2.  **Deploy the ALB:** Provision an Application Load Balancer in the public subnets. Configure listener rules for Layer 7 routing and set up a target group with health checks.

3.  **Configure Auto Scaling:** Create an Auto Scaling Group (ASG) in the private subnets using your Launch Template. Attach the ASG to the ALB target group and implement target tracking and step scaling policies based on metrics like CPU utilization.


### **Step 5: Secure the Edge and Configure DNS (CloudFront, WAF, Route 53)**

Optimize performance and protect the application from common web exploits.

1.  **Deploy CloudFront:** Set up a CloudFront distribution to cache static assets globally, which will reduce latency for your end users.
2.  **Attach AWS WAF:** Apply a Web Application Firewall to your ALB (or CloudFront) configured with managed rules to protect against OWASP Top 10 vulnerabilities like SQL injection and cross-site scripting.
3.  **Configure DNS:** Use Route 53 to create an Alias record that points your domain name to the Application Load Balancer. Set up Route 53 health checks to monitor endpoint availability.

### **Step 6: Operations and Observability (Systems Manager, CloudWatch)**

Ensure you can securely access your servers and monitor the health of the entire architecture.

1.  **Secure Access:** Use Systems Manager Session Manager to securely connect to your EC2 instances in the private subnets. This provides bastion-free access without needing public IPs or SSH keys.
2.  **Monitoring:** Set up CloudWatch dashboards to monitor infrastructure metrics. Configure Amazon SNS to trigger alarms and send notifications if any system resources exceed safe thresholds (e.g., high database CPU or ASG scaling events).

---

Powered by [Abdullah Mahmoud](https://www.linkedin.com/in/abdullah-mahmoud-de1344/)
