#!/bin/bash
cd misp
mv template.env .env
docker compose pull
cd ..
cd hive_cortex_elasticsearch
docker compose pull
cd ..
cd kibana
docker compose pull
docker compose up -d