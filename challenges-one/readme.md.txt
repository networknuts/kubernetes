Here’s a beautifully formatted `README.md` version of your CKA 2025 Challenge tasks:

---

# 🏆 Certified Kubernetes Administrator (CKA) 2025 - Challenge Tasks

Welcome to the CKA Challenge! Below are 17 practical tasks designed to test your skills and readiness for the CKA exam. Each task reflects real-world Kubernetes administration scenarios. Let's dive in!

---

## 📘 Task 1: RBAC - Extracting Information

- Extract all kubeconfig context names to `/tmp/contexts`, one per line.
- Write the current context name to `/tmp/current-context`.
- Base64-decode the client certificate of user `account-0027` and save it to `/tmp/cert`.

---

## 📦 Task 2: Helm - Installing Application

1. Create the `minio` namespace.
2. Install the `minio/operator` Helm chart into the `minio` namespace as release `minio-operator`.
3. Edit `/opt/course/2/minio-tenant.yaml` to enable SFTP:
   ```yaml
   features:
     enableSFTP: true
   ```
4. Apply the updated Tenant resource.

---

## 📊 Task 3: Pod Management

- In the `project-h800` namespace, scale the two `o3db-*` Pods down to **one replica** to conserve resources.

---

## ⚖️ Task 4: Pod Management & QoS

- Identify the Pods in `project-c13` that are likely to be **terminated first** under resource pressure.
- Write their names to `/tmp/pods-terminated-first.txt`.

---

## 🔄 Task 5: HPA Setup

Replace the existing autoscaler with a HorizontalPodAutoscaler for the `api-gateway`:

1. Remove the `horizontal-scaling-config` ConfigMap.
2. Create an HPA:
   - Name: `api-gateway`
   - Min replicas: 2
   - Max replicas: 4 (6 in prod)
   - Target CPU utilization: 50%
3. Apply changes using:
   ```bash
   kubectl kustomize /opt/course/5/api-gateway/staging | kubectl apply -f -
   kubectl kustomize /opt/course/5/api-gateway/prod | kubectl apply -f -
   ```

---

## 💾 Task 6: Persistent Volumes

- **PersistentVolume**
  - Name: `safari-pv`
  - Capacity: 2Gi
  - AccessMode: `ReadWriteOnce`
  - Path: `/Volumes/Data`
- **PersistentVolumeClaim** in `project-t230`
  - Name: `safari-pvc`
  - Storage: 2Gi
- **Deployment**
  - Name: `safari`
  - Mount: `/tmp/safari-data`
  - Image: `httpd:2-alpine`

---

## 📈 Task 7: Monitoring Resource Consumption

- Write two bash scripts using `kubectl` to gather resource metrics (details assumed to be provided separately).

---

## ⚙️ Task 8: Upgrade & Join Worker

- Upgrade `cka3962-node1` to match the control plane Kubernetes version.
- Join it to the cluster using `kubeadm`.

---

## 🔐 Task 9: Service Account

- Create a Pod `api-contact` in `project-swan` using the `secret-reader` ServiceAccount.
- Use `curl` inside the Pod to query all Secrets from the Kubernetes API.
- Save the result to `/opt/course/9/result.json`.

---

## 🔑 Task 10: RBAC

In `project-hamster`:

- Create:
  - ServiceAccount: `processor`
  - Role: `processor`
  - RoleBinding: `processor`
- Grant permissions to **create** only:
  - Secrets
  - ConfigMaps

---

## 🚫 Task 11: Taints and Tolerations

In `project-tiger`:

- Create a DaemonSet `ds-important`:
  - Image: `httpd:2-alpine`
  - Labels: `id=ds-important`, `uuid=18426a0b-5f59-4e10-923f-c0e078e82462`
  - Resource requests: 10m CPU, 10Mi Memory
  - Must run on all nodes (including control planes)

---

## 🚀 Task 12: Deployment

In `project-tiger`:

- Deployment: `deploy-important`
  - Replicas: 3
  - Labels: `id=very-important`
  - Two containers:
    - `container1`: `nginx:1-alpine`
    - `container2`: `google/pause`
  - Use `topologyKey: kubernetes.io/hostname` to ensure 1 Pod per node

---

## 🌐 Task 13: Gateway API

In `project-r500`:

1. Migrate from Ingress (`/opt/course/13/ingress.yaml`) to Gateway API.
2. Create HTTPRoute: `traffic-director`
   - Replicate routes
   - Add `/auto` path logic:
     - Redirect to `/mobile` if `User-Agent: mobile`
     - Else redirect to `/desktop`
3. Ensure it works with:
   ```bash
   curl r500.gateway:30080/desktop
   curl r500.gateway:30080/mobile
   curl r500.gateway:30080/auto -H "User-Agent: mobile"
   curl r500.gateway:30080/auto
   ```

---

## 📜 Task 14: Cluster Certificates

1. Check kube-apiserver certificate expiration with `openssl` or `cfssl`.
2. Save the date to `/opt/course/14/expiration`.
3. Use `kubeadm` to confirm the expiration.
4. Save the `kubeadm` renew command to `/opt/course/14/kubeadm-renew-certs.sh`.

---

## 🛡️ Task 15: Network Policy

In `project-snake`, create `np-backend`:

- Allow `backend-*` Pods to:
  - Connect to `db1-*` on port **1111**
  - Connect to `db2-*` on port **2222**

---

## 🧭 Task 16: CoreDNS Custom Domain

1. Backup current CoreDNS config to `/tmp/coredns_backup.yaml`.
2. Update CoreDNS to support:
   ```
   SERVICE.NAMESPACE.custom-domain
   ```
   in addition to `SERVICE.NAMESPACE.cluster.local`.

- Test using:
  ```bash
  nslookup kubernetes.default.svc.cluster.local
  nslookup kubernetes.default.svc.custom-domain
  ```

---

## 🐅 Task 17: Container Debugging

In `project-tiger`:

1. Create Pod `tigers-reunite` with labels `pod=container`, `container=pod`, image `httpd:2-alpine`.
2. SSH into the node where it’s scheduled.
3. Use `crictl` to:
   - Save container ID and `info.runtimeType` to `/tmp/pod-container.txt`
   - Save container logs to `/tmp/pod-container.log`

---

Let me know if you want this saved as a file or want a version with collapsible sections for better navigation.