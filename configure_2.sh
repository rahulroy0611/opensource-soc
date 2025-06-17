#!/bin/bash
cd misp
PUBLICIP="$(curl https://ifconfig.me)"
sed -i "s|BASE_URL=|BASE_URL=https://${PUBLICIP}|" .env
docker compose up -d
cd ..
cd hive_cortex_elasticsearch
docker compose up -d
cat << EOF
-----------------------------------------------------
MISP URL: https://${PUBLICIP}
Username: admin@admin.test
Password: admin
-----------------------------------------------------
TheHive URL: http://${PUBLICIP}:9000
Username: admin
Password: secret
-----------------------------------------------------
Cortex URL: http://${PUBLICIP}:9001
You need to create credential after opening the url
-----------------------------------------------------
EOF
