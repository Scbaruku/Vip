#!/bin/bash
# Edition : Stable Edition V3.0
# Auther  : MyridWan Project
# (C) Copyright 2023
# =========================================
#!/bin/bash
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
# Getting
CHATID=""
KEY=""
export TIME="10"
export URL="https://api.telegram.org/bot$KEY/sendMessage"
clear
#IZIN SCRIPT
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "\e[32mloading...\e[0m"
clear
ns_domain_cloudflare1() {
apt install jq curl -y
clear

read -rp "Sub Domain (Contoh: Myrid): " sub
DOMAIN=xstore.web.id
echo $sub > /root/cfku
SUB_DOMAIN=${sub}.xstore.web.id
CF_ID=ridwanstoreaws@gmail.com
CF_KEY=4ecfe9035f4e6e60829e519bd5ee17d66954f
echo ".xstore.web.id" > /root/domain
echo $SUB_DOMAIN > /root/domain

set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);
echo "Record DNS ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Host : $SUB_DOMAIN"
echo "IP=" >> /var/lib/kyt/ipvps.conf
echo $SUB_DOMAIN > /root/domain
echo $SUB_DOMAIN > /etc/xray/domain
rm -f /root/f1.sh
}
function pointing(){
ns_domain_cloudflare1

echo -e "Done Record Domain= ${SUB_DOMAIN} For VPS"
sleep 1
}
pointing
rm -rf cf.sh