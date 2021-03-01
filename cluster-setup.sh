#!/bin/bash
#this will create kubernetes cluster
#and install all packages required on
#all the nodes.

#run this on all machines

echo "### Enabling Bridging"
sleep 2
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

clear
echo "### Adding repositories"
echo "### Installing kubelet, kubeadm, kubectl & docker"
sleep 2

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl docker.io
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl start docker; systemctl enable docker

echo ""
echo "### Packages installed successfully"
echo "Clearing screen"
sleep 2
echo ""
echo "### On Master, run"
echo "kubeadm init --apiserver-advertise-address 10.0.0.100 --ignore-preflight-errors all"
echo ""
echo ""
echo "mkdir -p $HOME/.kube"
echo "sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config"
echo "sudo chown $(id -u):$(id -g) $HOME/.kube/config"
echo ""
echo "install overlay network"
echo "curl https://docs.projectcalico.org/manifests/calico.yaml -O"
echo "kubectl apply -f calico.yaml"
echo ""
echo "get worker join token"
echo "kubeadm token create --print-join-command"
echo ""
echo "copy the output of previous command and paste on all nodes"
echo "## we are done"
