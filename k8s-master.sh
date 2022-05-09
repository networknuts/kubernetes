#!/bin/bash
#/* **************** Network Nuts k8sMaster.sh **************** */
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

sysctl --system
echo  '\033[1mInstalling Docker\033[0m'
apt-get update

#apt-get install ca-certificates curl gnupg lsb-release -y

#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#apt-get update

#apt-get install -y docker.io

echo  '\033[1mInstalling Kubeadm, Kubelet and Kubectl\033[0m'
apt-get update

apt-get install -y apt-transport-https ca-certificates curl

sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

apt-get update

apt-get install -y kubelet=1.20.10-00 kubeadm=1.20.10-00 kubectl=1.20.10-00 docker.io

apt-mark hold kubelet kubeadm kubectl

## Installing openssh-server
echo 
echo  '\033[7mInstalling Openssh-server & starting sshd\033[0m'
sudo apt install -y openssh-server
systemctl start sshd
echo

echo  '\033[7mInitializing the cluster\033[0m'

## If you are going to use a different plugin you'll want
## to use a different IP address, found in that plugins 
## readme file. 

sleep 3

sudo kubeadm init --kubernetes-version 1.19.0 --pod-network-cidr 192.168.0.0/16 --apiserver-advertise-address 10.0.0.100

sleep 5

echo  '\033[7mRunning the steps explained at the end of script for you\033[0m'

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo  '\033[7mInstalling Calico Network Plugin\033[0m'

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
echo
echo
echo  '\033[5mWait for 40 seconds\033[0m'
sleep 40
echo  '\033[7mYou should see this node in the output below\033[0m'
echo  '\033[7mIt can take some time to show READY\033[0m'
echo
kubectl get node
echo
echo
echo  '\033[5mScript finished, move to next step\033[0m'
echo  '\033[5mDont forget to comment swap line from /etc/fstab\033[0m'
