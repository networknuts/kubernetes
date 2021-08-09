#!/bin/bash
#/* **************** Network Nuts k8sMaster.sh **************** */
#!/bin/bash -x
## v1.19.0 CKA
echo  '\033[1mThis Script will work on Ubuntu 18.04\033[0m'

sleep 3

echo  '\033[7mLoading Bridge Modules & Enabling them\033[0m'

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

echo "---DONE"
echo
echo  '\033[7mDisabling SWAP until next reboot\033[0m'
echo 
sudo swapoff -a

echo  '\033[7mInstalling Docker Engine version 19.03\033[0m'

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce=5:19.03.14~3-0~ubuntu-bionic docker-ce-cli=5:19.03.14~3-0~ubuntu-bionic 

## check this link https://stackoverflow.com/questions/27657888/how-to-install-docker-specific-version

echo  '\033[7mStarting & Enabling Docker\033[0m'
sudo systemctl start docker
sudo systemctl enable docker

echo
echo  '\033[7mInstalling Kubeadm, Kubelet & Kubectl\033[0m'
sleep 3

## Adding Repos
sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"
sudo apt-get update

## Installing kubernetes components
echo "Install kubeadm"
sudo apt install -y kubeadm=1.19.0-00
echo "Install kubectl"
sudo apt install -y kubectl=1.19.0-00 --allow-downgrades
echo "Install Kubelet"
sudo apt install -y kubelet=1.19.0-00 --allow-downgrades


#sudo sh -c "echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main' >> /etc/apt/sources.list.d/kubernetes.list"

#sudo sh -c "curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -"

#sudo apt-get update

#sudo apt-get install -y kubeadm=1.19.0-00 kubelet=1.19.0-00 kubectl=1.19.0-00

sudo apt-mark hold kubelet kubeadm kubectl

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
echo  '\033[5mDon't forget to comment swap line from /etc/fstab\033[0m'
