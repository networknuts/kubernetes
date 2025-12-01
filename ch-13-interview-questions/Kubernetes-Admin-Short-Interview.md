# Kubernetes Admin Interview Guide

[![Kubernetes](https://img.shields.io/badge/Kubernetes-Admin-blue)]()\
[![DevOps](https://img.shields.io/badge/DevOps-Interview%20Prep-green)]()\
[![Markdown](https://img.shields.io/badge/Format-README.md-lightgrey)]()

A comprehensive and interactive **Kubernetes Admin Interview README**
designed to help you quickly grasp real-world Kubernetes scenarios.\
This guide covers critical concepts like Services, Ingress,
CrashLoopBackOff troubleshooting, Affinity rules, and more.

------------------------------------------------------------------------

## 🚀 Key Features

-   Real-world Kubernetes interview Q&A\
-   Well-structured explanations with examples\
-   Covers Services, DNS, Scheduling, Affinity, Ingress,
    Troubleshooting\
-   Developer-friendly formatting with code blocks\
-   Ideal for GitHub README usage

------------------------------------------------------------------------

## 📦 Installation

Simply clone or download this repository:

``` bash
git clone <your-repo-url>
cd <your-project-folder>
```

No dependencies required --- this is a Markdown-based knowledge guide.

------------------------------------------------------------------------

## 📘 Kubernetes Admin Interview Questions

### **1️⃣ What is a Headless Service in Kubernetes, and when do you use it?**

A **Headless Service** is created **without a ClusterIP**, enabling
clients to receive Pod IPs directly via DNS instead of load‑balanced
traffic.

**📌 When to Use:**\
When you need direct Pod‑to‑Pod communication, especially in
**StatefulSets** like:

-   Cassandra\
-   MongoDB\
-   Kafka

Each Pod must be uniquely addressable (`pod-0`, `pod-1`, etc.).

------------------------------------------------------------------------

### **2️⃣ How can a Pod talk to a Service in another namespace?**

Use the service's **FQDN**:

    <service-name>.<namespace>.svc.cluster.local

**Example:**

A Pod in `dev` accessing a service in `prod`:

    nginx-service.prod.svc.cluster.local

------------------------------------------------------------------------

### **3️⃣ Pod stuck in CrashLoopBackOff --- how do you troubleshoot?**

A Pod goes into **CrashLoopBackOff** when its container keeps crashing
and restarting.

#### ✔️ Steps:

``` bash
kubectl logs <pod-name> -n <namespace>
kubectl logs <pod-name> -n <namespace> --previous
kubectl describe pod <pod-name>
```

#### 🔍 Common Causes:

-   Incorrect image or tag\
-   Missing ConfigMap/Secret\
-   Application runtime error\
-   Failing liveness probe

------------------------------------------------------------------------

### **4️⃣ Ingress vs LoadBalancer --- What's the difference?**

#### **LoadBalancer Service**

-   Allocates a cloud load balancer (AWS ELB, GCP LB)
-   One LB per service → **expensive**

#### **Ingress**

-   Routes multiple services behind **one** load balancer\
-   Can route via hostname/path rules\
-   Requires an **Ingress Controller**

------------------------------------------------------------------------

### **5️⃣ Why do we need an Ingress Controller?**

Because the **Ingress resource only defines routing rules** --- it does
*nothing* by itself.

The **Ingress Controller** implements those rules using a reverse proxy
such as:

-   NGINX\
-   Traefik\
-   AWS ALB

------------------------------------------------------------------------

### **6️⃣ ConfigMap changes not showing in Pods --- why?**

#### ✔️ Reason:

-   If mounted as a **volume** → updates auto-refresh (small delay)
-   If used as **environment variables** → **Pod restart required**

#### 🔧 Fix:

``` bash
kubectl rollout restart deployment <deployment-name>
```

------------------------------------------------------------------------

### **7️⃣ What is Node Affinity and when to use it?**

**Node Affinity** controls which nodes a Pod can be scheduled on using
labels.

-   `requiredDuringSchedulingIgnoredDuringExecution` → hard rule\
-   `preferredDuringSchedulingIgnoredDuringExecution` → soft rule

#### 🛠 Use Cases:

-   Schedule GPU workloads on GPU nodes\
-   Cost optimization using spot vs on-demand nodes

Example:\
Run batch jobs on spot nodes, critical apps on on-demand nodes.

------------------------------------------------------------------------

### **8️⃣ Node Selector vs Node Affinity**

  Feature       Node Selector   Node Affinity
  ------------- --------------- -------------------
  Complexity    Simple          Advanced
  Operators     Exact match     In, NotIn, Exists
  Soft Rules    ❌ No           ✔️ Yes
  Flexibility   Low             High

------------------------------------------------------------------------

### **9️⃣ When to use Pod Anti-Affinity?**

Pod Anti-Affinity **prevents Pods from running on the same node**.

#### 🟢 Use Cases:

1.  **High Availability**\
    Spread replicas across nodes to avoid single-node failure.

2.  **Performance Isolation**\
    Prevent two heavy workloads from competing on the same node.

**💡 Summary:**\
Use Pod Anti-Affinity for resilience, fault tolerance, and performance.

------------------------------------------------------------------------

## 📚 Usage

You may integrate this README into:

-   DevOps interview prep repositories\
-   Kubernetes study guides\
-   Knowledge-sharing documentation

------------------------------------------------------------------------

## 🤝 Contributing

Contributions are welcome!

1.  Fork the repository\
2.  Create a new branch\
3.  Commit enhancements\
4.  Open a pull request

------------------------------------------------------------------------

## ⭐ Support

If you found this helpful, consider giving the repo a **star**!
