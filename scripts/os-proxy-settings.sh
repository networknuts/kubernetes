#!/bin/bash
echo "configuring proxy for OS"

cat <<EOF | sudo tee /etc/profile.d/proxy.sh

export http_proxy="http://10.0.0.200:3128/"
export https_proxy="http://10.0.0.200:3128/"
export ftp_proxy="http://10.0.0.200:3128/"
export no_proxy="127.0.0.1,localhost"

#for curl

export HTTP_PROXY="http://10.0.0.200:3128/"
export HTTPS_PROXY="http://10.0.0.200:3128/"
export FTP_PROXY="http://10.0.0.200:3128/"
export NO_PROXY="127.0.0.1,localhost"

EOF

chmod +x /etc/profile.d/proxy.sh
source /etc/profile.d/proxy.sh

echo "configure proxy for wget"

cat <<EOF | sudo tee ~/.wgetrc
use_proxy = on
http_proxy = http://10.0.0.200:3128/ 
https_proxy = http://10.0.0.200:3128/ 
ftp_proxy = http://10.0.0.200:3128/ 

EOF

source ~/.wgetrc