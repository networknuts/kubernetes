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
echo "Generate token on manager using"
echo "==="
echo "kubeadm token create --print-join-command"
echo
echo
