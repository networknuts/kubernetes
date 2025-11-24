DevOps Interview Questions — Interactive README

A curated, collapsible, GitHub-friendly DevOps interview guide.

📘 Table of Contents

AWS & Cloud Networking

Kubernetes

Terraform

DevOps Practices & Security

Cost Optimization

AWS & Cloud Networking
Q1) How would you isolate a network within an AWS VPC?
<details> <summary>Click to expand</summary>

Create dedicated public/private subnets

Use NACLs, Security Groups, and custom route tables

Use AWS Network Firewall or Transit Gateway segmentation for strict isolation

</details>
Q3) Architectural differences between GCP VPC and AWS VPC?
<details> <summary>Click to expand</summary>

AWS VPC

Region-scoped

Subnets tied to specific AZs

Requires peering for cross-VPC communication

GCP VPC

Global VPC (spans multiple regions)

Subnets are regional

Cross-region communication works by default

</details>
Q9) How would you connect two VPCs in AWS?
<details> <summary>Click to expand</summary>

VPC Peering → simple, point-to-point

Transit Gateway → scalable hub-and-spoke

PrivateLink → service-level connectivity

</details>
Kubernetes
Q2) How do you handle rollbacks in Kubernetes?
<details> <summary>Click to expand</summary>

Run:

kubectl rollout undo deployment/<name> --to-revision=<rev>


Kubernetes keeps old ReplicaSets for rollback

Use GitOps/CI tools like ArgoCD, Helm, Spinnaker

</details>
Q4) What are network policies?
<details> <summary>Click to expand</summary>

Act as firewalls for pods

Control IP-level communication between:

Pod ↔ Pod

Pod ↔ Service

Pod ↔ External

</details>
Q7) How would you upgrade a Kubernetes cluster?
<details> <summary>Click to expand</summary>

Upgrade control plane

Upgrade worker nodes

Cordon + drain nodes

Replace nodes safely

Applies to EKS/GKE/AKS.

</details>
Q11) How would you back up a cluster?
<details> <summary>Click to expand</summary>

Velero for cluster backup & restore

For databases: AWS Backup, RDS snapshots, EBS snapshots

For stateful workloads: PVC snapshots

</details>
Q12) What are Kubernetes Operators?
<details> <summary>Click to expand</summary>

Controllers that extend Kubernetes using CRDs

Automate application lifecycle

Examples:

Prometheus Operator

MySQL Operator

ElasticSearch ECK

</details>
Q13) What are admission controllers?
<details> <summary>Click to expand</summary>

Two types:

Validating → validate API requests

Mutating → modify API requests

Use cases:

Enforce security policies

Inject sidecars

Block privileged pods

</details>
Terraform
Q6) How do you bring an existing resource into Terraform state?
<details> <summary>Click to expand</summary>
terraform import <resource_type>.<name> <resource_id>


Example:

terraform import aws_instance.myec2 i-123456


Then run terraform plan to reconcile.

</details>
Q10) What is Terraform state drift? How do you detect & solve it?
<details> <summary>Click to expand</summary>

Drift = infrastructure changed manually outside Terraform.

Detect with:

terraform plan


Fix by re-applying Terraform or importing changes using terraform import.

</details>
DevOps Practices & Security
Q5) What would you do if you accidentally pushed credentials to a repo?
<details> <summary>Click to expand</summary>

Revoke/rotate the keys immediately

Remove secrets from git history

git filter-repo

BFG Repo Cleaner

Add secret scanning in CI

Trufflehog

GitGuardian

</details>
Cost Optimization
Q8) What practices reduce compute costs?
<details> <summary>Click to expand</summary>

Auto Scaling

Reserved & Spot instances

Rightsizing

Serverless (Lambda, Fargate)

Monitoring unused resources using CloudWatch, Grafana, Prometheus

</details>

If you want, I can also:

✅ Convert this into a fully styled README with badges
✅ Add a sidebar navigation
✅ Turn this into a documentation website (MkDocs, Docusaurus)
Just tell me!
