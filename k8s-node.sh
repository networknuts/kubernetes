#!/bin/bash
#/* **************** Network Nuts k8snode.sh **************** */
#!/bin/bash -x
## v1.19.0 CKA
echo  '\033[1mThis Script will work on Ubuntu 18.04\033[0m'

echo  '\033[1mAdding Bridge\033[0m'
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system
echo  '\033[1mInstalling Docker\033[0m'
#sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release -y

#sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#sudo apt-get update

echo  '\033[1mInstalling Kubeadm, Kubelet and Kubectl\033[0m'
apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

sudo echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet=1.20.10-00 kubeadm=1.20.10-00 kubectl=1.20.10-00 docker.io

sudo apt-mark hold kubelet kubeadm kubectl

## Installing openssh-server
echo
echo  '\033[7mInstalling Openssh-server & starting sshd\033[0m'
sudo apt install -y openssh-server
sudo systemctl start sshd
echo

echo
echo  '\033[7mScript finished. You need to join node to cluster\033[0m'
echo  '\033[7mRun on master node to get join token - \033[0m'
echo
echo  '\033[1mkubeadm token create --print-join-command\033[0m'
echo
echo
echo  '\033[5mkubeadm token create --print-join-command\033[0m'
echo
echo
