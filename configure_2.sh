#!/bin/bash
cd misp
PUBLICIP="$(curl https://ifconfig.me)"
sed -i "s|BASE_URL=|BASE_URL=https://${PUBLICIP}|" .env
docker compose up -d
cd ..
cd hive_cortex_elasticsearch
docker compose up -d
