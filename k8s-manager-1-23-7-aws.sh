#!/bin/bash
echo "disabling swap"
swapoff -a
echo "installing kubernetes version 1.23.7-00"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet=1.23.7-00 kubeadm=1.23.7-00 kubectl=1.23.7-00 docker.io
apt-mark hold kubelet kubeadm kubectl
cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl daemon-reload
systemctl restart docker
systemctl restart kubelet
echo "==="
echo "Initializing cluster"
echo "==="
kubeadm init --apiserver-advertise-address 10.0.1.100
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml
echo "wait for 60 seconds"
#sleep 60
echo "use - "
echo "# kubectl get nodes"
echo "verify READY status"
echo
echo
echo "use - "
echo "# kubectl get pods -n kube-system"
echo "to vertify all pods 1/1"
