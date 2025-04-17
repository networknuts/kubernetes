# Certified Kubernetes Administrator (CKA) Challenges

A curated list of hands-on Kubernetes tasks to test your skills and prepare for the CKA exam.

---

## 📅 Task #1 - Scheduling

- Deploy a pod named `heavy-pod` with **Guaranteed QoS**:
  - CPU: `50m`
  - Memory: `50Mi`
- Ensure the pod is in the **Running** state.
- Edit the pod's resources to:
  - CPU: `100m`
  - Memory: `100Mi`

---

## 🚀 Task #2 - Workload & Scheduling

- The deployment `video-app` has undergone several **rolling updates and rollbacks**.
- Your task:
  - Find the total number of **revisions**.
  - Extract the **image name used in the 3rd revision**.
  - Record it in a file `app-file.txt` using the format:  
    ```
    REVISION_TOTAL_COUNT,IMAGE_NAME
    ```

---

## 🌐 Task #3 - Pod & Service Web App

- **Pod `app-pod`**:
  - Container name: `app-container`
  - Image: `httpd:latest`
  - Port: `80`
  - Label: `app=app-lab`
  
- **Service `app-svc`**:
  - Type: `ClusterIP`
  - Port: `80`
  - Selects the `app-pod`

- **Access**:
  - Use `kubectl port-forward` to map local port to the Pod.
  - Use `curl` to test the app returns: `It works!`

---

## 🔐 Task #4 - ConfigMap

- Create a `ConfigMap` named `creds` with the content:
  ```bash
  username=batman
  ```

---

## 🔧 Task #5 - ConfigMap & Deployment

- A deployment `webapp-deployment` needs dynamic env var control.
- Steps:
  - Create a `ConfigMap` named `webapp-deployment-config-map` with:
    ```bash
    APPLICATION=web-app
    ```
  - Update the deployment to use this ConfigMap as an environment variable.

---

## 🧪 Task #6 - Namespaces, Deployment, Service, HPA

- **Namespace**: `test`
- **Deployment**: `testing-app` (in `test` namespace)
  - Replicas: `3`
  - Labels: `app=testing-app`
  - Node selector: `cpu=i5`
  - QoS: `Burstable`
  - Image: `nginx:latest`
  - Port: `80/tcp`

- **Service**: `testing-app-svc`
  - Type: `ClusterIP`
  - Exposes deployment on port `80`

- **Horizontal Pod Autoscaler (HPA)**:
  - Name: `testing-app-hpa`
  - Min pods: `3`
  - Max pods: `10`
  - CPU utilization target: `20%`
  - Scale-down stabilization: `30s`, max 1 pod per 20s
  - Scale-up stabilization: `20s`, max 1 pod per 30s

---

## 🥇 Task #7 - Priority Classes

- Create a `PriorityClass` named `high-value` with value `2` less than max.
- Create a deployment `high-value-application`:
  - Image: `lovelearnlinux/webserver:v1`
  - Replicas: `3`
  - Label: `app=webapp`
  - Uses the `high-value` priority class

---

## 🌍 Task #8 - ConfigMap with HTML Template

- Namespace: `prod`
- ConfigMap: `welcome` with:
  ```html
  <html>
  <title>sample application using configmap</title>
  <h1>welcome to our test environment</h1>
  </html>
  ```

- Deployment: `welcome-app`
  - Image: `lovelearnlinux/webserver:v1`
  - Label: `app=welcome`
  - QoS: `Burstable`
  - Mounts ConfigMap to `/var/www/html`

- Service: `welcome-app-svc`, ClusterIP on port `80`

- Update ConfigMap:
  Replace:
  ```html
  <h1>welcome to our test environment</h1>
  ```
  with:
  ```html
  <h1>welcome to our best environment</h1>
  ```

- Confirm the changes are applied.

---

## 🤝 Task #9 - Affinity & Anti-Affinity

1. Deploy pod `webapp`:
   - Image: `nginx:latest`
   - Label: `name=webapp`

2. Deploy pod `dbapp` **on the same node** as `webapp`:
   - Image: `redis`
   - Label: `name=dbapp`
   - Use `topologyKey: kubernetes.io/hostname`

3. Delete `dbapp` and redeploy it **on a different node** than `webapp`.

---

## 🔐 Task #10 - RBAC & Service Account

1. Namespace: `nsone`
2. Create a Service Account: `nsone-sa`
3. Grant access to:
   - Create, get, list: **pods** and **configmaps**
   - Scope: `nsone` namespace only
4. Create a pod using `nsone-sa`
5. Verify permissions using:
   ```bash
   kubectl auth can-i
   ```

