# 🚀 Kubernetes Admin Interview Guide

![Status](https://img.shields.io/badge/README-Interactive-brightgreen)\
![Kubernetes](https://img.shields.io/badge/Kubernetes-Admin-blue)\
![License](https://img.shields.io/badge/License-MIT-yellow)

A comprehensive and interactive set of Kubernetes Admin interview
questions designed to test real-world operational knowledge.\
This guide includes practical explanations, examples, diagrams, and
troubleshooting workflows.

------------------------------------------------------------------------

## 📚 Table of Contents

-   [Introduction](#introduction)
-   [Interview Questions](#interview-questions)
    -   [1. What is a Headless Service?](#1-what-is-a-headless-service)
    -   [2. Talking to a Service in Another
        Namespace](#2-talking-to-a-service-in-another-namespace)
    -   [3. Troubleshooting
        CrashLoopBackOff](#3-troubleshooting-crashloopbackoff)
    -   [4. Ingress vs LoadBalancer](#4-ingress-vs-loadbalancer)
    -   [5. Importance of Ingress
        Controller](#5-importance-of-ingress-controller)
    -   [6. ConfigMap Changes Not
        Reflecting](#6-configmap-changes-not-reflecting)
    -   [7. Node Affinity Explained](#7-node-affinity-explained)
    -   [8. Node Selector vs Node
        Affinity](#8-node-selector-vs-node-affinity)
    -   [9. Pod Anti-Affinity Usage](#9-pod-anti-affinity-usage)
-   [Contributing](#contributing)

------------------------------------------------------------------------

## 🧭 Introduction

This document covers short but deeply insightful Kubernetes
administrator interview questions that relate to **real-world cluster
operations**, covering networking, scheduling, troubleshooting, and
resource management.

------------------------------------------------------------------------

## Interview Questions

------------------------------------------------------------------------

### 1) What is a Headless Service?

A **Headless Service** is a Kubernetes service **without a ClusterIP**.\
Instead of load-balancing traffic, it returns **direct Pod IPs** through
DNS.

**Use Case:**\
Ideal for StatefulSets such as **Kafka, Cassandra, MongoDB**, where each
Pod needs a stable and discoverable identity.

    service-name.namespace.svc.cluster.local

------------------------------------------------------------------------

### 2) Talking to a Service in Another Namespace

Pods can access Services using the service **FQDN**:

    <service-name>.<namespace>.svc.cluster.local

Example:\
`nginx-service.prod.svc.cluster.local`

------------------------------------------------------------------------

### 3) Troubleshooting CrashLoopBackOff

CrashLoopBackOff indicates a container keeps crashing.

#### 🔍 Steps:

``` bash
kubectl logs <pod-name> -n <ns>
kubectl logs <pod-name> -n <ns> --previous
kubectl describe pod <pod-name>
```

#### 🛑 Common Causes:

-   Wrong image tag\
-   Missing ConfigMap/Secret\
-   App error\
-   Failing liveness probe

------------------------------------------------------------------------

### 4) Ingress vs LoadBalancer

  Feature               LoadBalancer          Ingress
  --------------------- --------------------- --------------------------
  External LB           Yes (1 per service)   One LB for many services
  Routes traffic        To one service        To multiple services
  Cost                  High                  Low
  Requires controller   No                    Yes

**Example:** 10 services → 10 LBs vs 1 Ingress LB.

------------------------------------------------------------------------

### 5) Importance of Ingress Controller

Ingress is just a **set of rules**.\
It does nothing on its own.

The **Ingress Controller** (NGINX, Traefik, ALB) implements the routing
rules and configures the actual reverse proxy.

------------------------------------------------------------------------

### 6) ConfigMap Changes Not Reflecting

If used as: - **Volume** → auto-updates\
- **Environment variable** → requires Pod restart

Restart deployment:

``` bash
kubectl rollout restart deployment <name>
```

------------------------------------------------------------------------

### 7) Node Affinity Explained

Node Affinity lets you control Pod placement using node labels.

-   `requiredDuringSchedulingIgnoredDuringExecution` → **hard rule**
-   `preferredDuringSchedulingIgnoredDuringExecution` → **soft rule**

**Use Cases:** - Run GPU Pods only on GPU nodes\
- Use spot nodes for cost-optimized batch jobs

------------------------------------------------------------------------

### 8) Node Selector vs Node Affinity

**Node Selector:**\
Straightforward key=value matching.

**Node Affinity:**\
Advanced, supports operators like `In`, `NotIn`, `Exists`.

Affinity = more flexible.

------------------------------------------------------------------------

### 9) Pod Anti-Affinity Usage

Ensures Pods **do NOT** run on the same node.

#### Benefits:

-   High Availability\
-   Performance isolation

Example: Spread replicas across multiple nodes for resilience.

------------------------------------------------------------------------

## 🤝 Contributing

Contributions are welcome!\
Feel free to submit a PR or open an issue.

------------------------------------------------------------------------

Made with ❤️ for Kubernetes learners and engineers.
