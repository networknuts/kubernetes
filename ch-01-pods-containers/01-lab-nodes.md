### Interview Questions

<details><summary>Which command can be used to get node details?</summary>
<p>

#### kubectl describe node nodename

</p>
</details>

<details><summary>Not all cpu & memory on node can be given to pods. Why?</summary>
<p>

#### In a Kubernetes node, CPU and memory are divided into:
  1. Operating System
  2. Kubelet, CNI & system daemons
  3. Pods
  4. Eviction Threshold

</p>
</details>

<details><summary>Which command will list all nodes in the cluster?</summary>
<p>

#### kubectl get nodes
</p>
</details>
