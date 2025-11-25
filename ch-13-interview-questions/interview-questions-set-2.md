# Cloud & DevOps Interview Questions -- README

A curated collection of real-world Cloud & DevOps interview questions
covering AWS, Docker, Kubernetes, and Terraform. This guide is
structured for recruiters, engineers, and learners preparing for
hands‑on technical rounds.

------------------------------------------------------------------------

## 🚀 Project Overview

This repository includes deeply practical questions that reflect actual
scenarios asked in DevOps interviews. It is designed to help you
understand concepts, commands, configurations, and real-world
troubleshooting.

------------------------------------------------------------------------

## ⭐ Key Features

-   AWS, Docker, Kubernetes & Terraform practical questions\
-   Code snippets and command examples\
-   Real‑world explanations\
-   Beginner‑friendly and interview‑focused

------------------------------------------------------------------------

## 📦 Installation (Optional)

Clone the repository:

``` bash
git clone https://github.com/yourusername/devops-interview-prep.git
cd devops-interview-prep
```

------------------------------------------------------------------------

## 📘 Usage

Simply open the README to start learning.

Or view individual questions to prepare for interviews:

``` bash
cat README.md
```

------------------------------------------------------------------------

## 📑 DevOps Questions & Answers

### **Q1. What is a Static IP and a Public IP?**

-   **Static IP:** A fixed IP address that never changes. Used for
    servers requiring consistent access.\
-   **Public IP:** Accessible over the internet. Assigned by ISPs or
    cloud providers.\
    👉 All static IPs can be public, but not all public IPs are static.

------------------------------------------------------------------------

### **Q2. Difference between a Security Group and a Network ACL?**

-   **Security Group:**
    -   Operates at instance level\
    -   **Stateful**\
    -   Only allow rules\
-   **Network ACL:**
    -   Operates at subnet level\
    -   **Stateless**\
    -   Can allow or deny traffic

------------------------------------------------------------------------

### **Q3. What are AWS Policies and their types?**

AWS Policies are JSON documents that define permissions.

Types: - Identity-based\
- Resource-based\
- Permission boundaries\
- Service Control Policies (SCPs)

------------------------------------------------------------------------

### **Q4. How do you create S3 Cross‑Region Replication (CRR)?**

1.  Enable Versioning on source & destination buckets\
2.  Go to **S3 → Management → Replication**\
3.  Choose destination region\
4.  Assign IAM replication role

------------------------------------------------------------------------

### **Q5. If a file is deleted in Bucket A, what happens in Bucket B?**

-   If **Delete Marker Replication** is ON → Deletion replicates\
-   If OFF → File remains in Bucket B

------------------------------------------------------------------------

### **Q6. What is Containerization?**

Packaging applications with dependencies into isolated containers using
a shared OS kernel.

------------------------------------------------------------------------

### **Q7. What is a Dockerfile?**

A Dockerfile contains instructions to build a Docker image.

------------------------------------------------------------------------

### **Q8. Sample Dockerfile**

``` dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

------------------------------------------------------------------------

### **Q9. What is a Docker Network?**

A way for containers to communicate securely with other containers or
external systems.

------------------------------------------------------------------------

### **Q10. Default Docker Network**

`bridge`

------------------------------------------------------------------------

### **Q11. Create a Docker Network**

``` bash
docker network create my_network
```

------------------------------------------------------------------------

### **Q12. Create a Docker Container**

``` bash
docker run -d --name my_container nginx
```

------------------------------------------------------------------------

### **Q13. Run a Dockerfile**

``` bash
docker build -t my-app .
docker run -p 3000:3000 my-app
```

------------------------------------------------------------------------

### **Q14. What is a Deployment in Kubernetes?**

A Deployment manages the lifecycle of Pods---scaling, rolling updates,
and rollbacks.

------------------------------------------------------------------------

### **Q15. Explain a Kubernetes Pod to a 5‑year‑old**

A Pod is like a lunchbox holding your food containers (apps). They
always stay together.

------------------------------------------------------------------------

### **Q16. Types of Kubernetes Deployments**

-   Recreate\
-   Rolling Update\
-   Canary\
-   Blue‑Green

------------------------------------------------------------------------

### **Q17. What is a StatefulSet?**

Manages Pods requiring persistent storage or stable network identity.

------------------------------------------------------------------------

### **Q18. What is a DaemonSet?**

Ensures a Pod runs on **every node** (e.g., monitoring agents).

------------------------------------------------------------------------

### **Q19. What is a Service in Kubernetes?**

A stable network endpoint exposing Pods for communication.

------------------------------------------------------------------------

### **Q20. LoadBalancer vs Ingress Controller**

-   **LoadBalancer:** Layer 4 traffic distribution\
-   **Ingress Controller:** Layer 7 HTTP routing & SSL termination

------------------------------------------------------------------------

### **Q21. Can you create a Pod without a Deployment?**

``` bash
kubectl run my-pod --image=nginx
```

But you lose scaling & self‑healing.

------------------------------------------------------------------------

### **Q22. Terraform script for EC2 & S3**

``` hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-terraform-bucket-example"
  acl    = "private"
}
```

------------------------------------------------------------------------

### **Q23. Explain the Terraform Script**

-   Provider → AWS region\
-   aws_instance → EC2 server\
-   aws_s3_bucket → S3 storage bucket

------------------------------------------------------------------------

### **Q24. How to set up Kubernetes on AWS using EKS?**

``` bash
eksctl create cluster --name myCluster --region us-east-1
aws eks update-kubeconfig --name myCluster
kubectl get nodes
```

------------------------------------------------------------------------

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open
issues.

------------------------------------------------------------------------

## 📄 License

This project is open-source and available under the MIT License.
