# DevOps Interview Preparation Guide

A curated collection of DevOps interview questions and structured
answers covering AWS, Kubernetes, Terraform, networking, operators,
admission controllers, and more.

## 🚀 Project Overview

This repository contains commonly asked DevOps interview questions along
with concise, high-quality answers.

## ⭐ Key Features

-   Well-structured Q&A format
-   Cloud concepts (AWS, GCP)
-   Kubernetes essentials
-   Terraform usage & state management
-   Security best practices
-   CI/CD and rollback strategies
-   Infrastructure & cost-optimization guidelines

## 📥 Installation

``` bash
git clone https://github.com/your-username/devops-interview-guide.git
cd devops-interview-guide
```

## 📘 Usage

``` bash
cat README.md
```

# 📚 DevOps Interview Questions & Answers

## Q1. How would you isolate a network within an AWS VPC?

-   Use separate public/private subnets, NACLs, and security groups.
-   Use dedicated subnets with restricted route tables.
-   Optionally use AWS Network Firewall or Transit Gateway.

## Q2. How do you handle rollbacks in Kubernetes?

``` bash
kubectl rollout undo deployment/<name> --to-revision=<rev>
```

-   Kubernetes keeps previous ReplicaSets.
-   Tools like ArgoCD, Helm, Spinnaker can handle rollbacks.

## Q3. Architectural differences between GCP VPC and AWS VPC

-   AWS VPC: Region-scoped, AZ-specific subnets, explicit peering
    required.
-   GCP VPC: Global, regional subnets, cross-region communication
    enabled by default.

## Q4. What are network policies in Kubernetes?

-   Control pod-to-pod/service/external traffic.
-   Act as firewalls for pods.

## Q5. What would you do if you accidentally pushed credentials to a remote repo?

-   Revoke/rotate keys immediately.
-   Clean history using git filter-repo or BFG.
-   Add secret scanning to CI/CD.

## Q6. How do you bring an existing resource into Terraform state?

``` bash
terraform import <resource_type>.<name> <resource_id>
```

Then run terraform plan.

## Q7. How would you upgrade a Kubernetes cluster?

-   Upgrade control plane → nodes.
-   Cordon & drain nodes.
-   Test in staging first.

## Q8. What practices would you propose to reduce compute costs across the org?

-   Auto Scaling
-   Reserved/Spot instances
-   Rightsizing
-   Serverless (Lambda, Fargate)
-   Monitoring unused resources

## Q9. How would you connect two VPCs in AWS?

-   VPC Peering
-   Transit Gateway
-   PrivateLink

## Q10. What is Terraform state drift? How can you detect and solve it?

-   Drift occurs when infra is changed manually.
-   Detect with terraform plan.
-   Fix by terraform apply or import.

## Q11. How would you back up a cluster? What tools would you use?

-   Velero for Kubernetes.
-   AWS Backup, snapshots for databases.
-   PVC snapshots for stateful workloads.

## Q12. What are Kubernetes Operators?

-   Operators = controllers that extend Kubernetes API using CRDs (Custom Resource Definitions).
-   Automate deploy/upgrade/healing.
-   Examples: Prometheus Operator, MySQL Operator.

## Q13. What are Admission Controllers?

- Kubernetes plugins that intercept API requests before they’re persisted in etcd.
Two types:
Validating → validate requests.
Mutating → modify requests.
Example: Enforce security policies, inject sidecars, deny privileged pods, resource quota, limit range

## 🤝 Contributing

1.  Fork the repo\
2.  Create a branch\
3.  Commit changes\
4.  Open PR

## 📝 License

MIT License
