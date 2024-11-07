#!/bin/bash
cd misp
docker compose up -d
cd ..
cd hive_cortex_elasticsearch
docker compose up -d