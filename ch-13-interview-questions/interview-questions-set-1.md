DevOps Interview Questions & Practical Answers










A curated set of real-world DevOps interview questions focused on cloud infrastructure, Kubernetes, Terraform, networking, cost optimization, and operational excellence.
Compiled for professionals with 5+ years of hands-on experience maintaining servers, clusters, and cloud environments.

📘 Table of Contents

AWS & Cloud Networking

Kubernetes

Security & Incident Response

Terraform & IaC

Cluster Management

Cost Optimization

Backup & Recovery

Kubernetes Advanced Concepts

AWS & Cloud Networking
Q1. How would you isolate a network within an AWS VPC?

Use public/private subnets, security groups, and NACLs.

For strict isolation:

Create dedicated subnets.

Restrict routing with custom route tables.

Use VPC peering limitations or Transit Gateway segmentation.

For enhanced inspection:

AWS Network Firewall, or

TGW with separate route domains.

Q3. Architectural differences between AWS VPC and GCP VPC?

AWS VPC

Region-scoped.

Subnets tied to individual AZs.

Cross-VPC requires explicit peering or TGW.

GCP VPC

Global resource spanning regions.

Subnets are regional.

Cross-region traffic works without peering.

Q9. How do you connect two VPCs in AWS?

Options:

VPC Peering (simple, point-to-point)

Transit Gateway (hub-and-spoke for multi-VPC scaling)

PrivateLink (service-level private access)

Kubernetes
Q2. How do you handle rollbacks in Kubernetes?

Use:

kubectl rollout undo deployment/<name> --to-revision=<rev>


Kubernetes stores previous ReplicaSets for rollback.

GitOps/CI/CD tools also support controlled rollbacks:

ArgoCD

Helm

Spinnaker

Q4. What are Network Policies?

Kubernetes IP-layer firewall rules.

Control pod-to-pod, pod-to-service, and pod-to-external communication.

Match traffic using labels.

Enforced by CNI providers such as Calico, Cilium, or Weave.

Security & Incident Response
Q5. What would you do if you accidentally pushed credentials to a remote repo?

Immediately revoke/rotate exposed credentials.

Remove from history using:

git filter-repo

BFG Repo Cleaner

Add CI/CD secrets scanning:

GitGuardian

Trufflehog

GitHub Advanced Security

Terraform: Infrastructure as Code
Q6. How do you bring an existing resource into your Terraform state?

Use:

terraform import <resource_type>.<name> <resource_id>


Run terraform plan to align configuration with state.

Q10. What is Terraform drift? How do you detect and fix it?

Drift = infrastructure changed manually outside Terraform.

Detect: terraform plan

Fix:

Re-apply Terraform (terraform apply), or

Import manual changes into Terraform state.

Cluster Management
Q7. How would you upgrade a Kubernetes cluster?

Upgrade control plane

Upgrade worker nodes

Cordon + drain old nodes

Replace nodes if managed (EKS/GKE/AKS)

Always test in a staging cluster first

Cost Optimization
Q8. Practices to reduce compute costs across an organization

Autoscaling (HPA, VPA, EC2 ASG)

Reserved/Spot instances

Rightsizing workloads

Serverless (Lambda, Fargate)

Monitoring unused resources:

CloudWatch

Grafana

Prometheus

Backup & Recovery
Q11. How do you back up a cluster? What tools do you use?

Kubernetes: Velero

Databases: AWS Backup, native RDS/EBS snapshots

Stateful apps: PVC snapshots

Kubernetes Advanced Concepts
Q12. Kubernetes Operators

Extend Kubernetes using CRDs.

Automate complex application lifecycles.

Examples:

Prometheus Operator

MySQL Operator

Elastic ECK

Q13. Admission Controllers

Intercept API requests before persistence in etcd.

Types:

Validating controllers → enforce checks.

Mutating controllers → modify requests.

Use cases:

Security policy enforcement

Sidecar injection

Restrict privileged workloads