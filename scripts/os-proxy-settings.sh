#!/bin/bash
#### RUN ON ALL MACHINES of CLUSTER ####
##### ONLY IF YOU ARE USING PROXY ######
##### 10.0.0.200 is our PROXY IP #####
##### 10.0.0.100 = manager #####
##### 10.0.0.1 = nodeone #####
##### 10.0.0.2 = nodetwo #####
##### 172.16.0.0/16 = pod network #####

clear
echo
echo
echo "********"
echo "configuring proxy for OS"
echo "********"
echo 
echo
sleep 5
cat <<EOF | sudo tee /etc/profile.d/proxy.sh

#!/bin/bash
export http_proxy="http://10.0.0.200:3128/"
export https_proxy="http://10.0.0.200:3128/"
export ftp_proxy="http://10.0.0.200:3128/"
export no_proxy="127.0.0.1,localhost,10.0.0.0/8,10.0.0.100,10.0.0.1,10.0.0.2,172.16.0.0/16"

# For curl
export HTTP_PROXY="http://10.0.0.200:3128/"
export HTTPS_PROXY="http://10.0.0.200:3128/"
export FTP_PROXY="http://10.0.0.200:3128/"
export NO_PROXY="127.0.0.1,localhost,10.0.0.0/8,10.0.0.100,10.0.0.1,10.0.0.2,172.16.0.0/16"


EOF

chmod +x /etc/profile.d/proxy.sh
sh /etc/profile.d/proxy.sh

echo
echo
echo "And run - source /etc/profile.d/proxy.sh"
echo
echo
sleep 5
