#!/bin/bash
#/* **************** Network Nuts k8snode.sh **************** */
#!/bin/bash -x
## v1.19.0 CKA
echo  '\033[1mThis Script will work on Ubuntu 18.04\033[0m'

sleep 3
echo
echo  '\033[7mLoading Bridge Modules & Enabling them\033[0m'
echo

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system
echo
echo "---DONE"
echo
echo
echo  '\033[7mDisabling SWAP until next reboot\033[0m'
echo 
sudo swapoff -a

echo
echo  '\033[7mInstalling Docker Engine version 19.03\033[0m'
echo
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce=5:19.03.14~3-0~ubuntu-bionic docker-ce-cli=5:19.03.14~3-0~ubuntu-bionic 

## check this link https://stackoverflow.com/questions/27657888/how-to-install-docker-specific-version
echo
echo  '\033[7mStarting & Enabling Docker\033[0m'
echo
sudo systemctl start docker
sudo systemctl enable docker

echo
echo  '\033[7mInstalling Kubeadm, Kubelet & Kubectl\033[0m'
## Adding Repos
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"
sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo apt-get update
sudo apt install -y kubeadm=1.19.0-00
sudo apt install -y kubectl=1.19.0-00 --allow-downgrades
sudo apt install -y kubelet=1.19.0-00 --allow-downgrades


#sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

#sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

#sudo apt-get update

#sudo apt-get install -y kubeadm=1.19.0-00 kubelet=1.19.0-00 kubectl=1.19.0-00

sudo apt-mark hold kubelet kubeadm kubectl

## Installing openssh-server
echo 
echo  '\033[7mInstalling Openssh-server & starting sshd\033[0m'
sudo apt install -y openssh-server
systemctl start sshd
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
