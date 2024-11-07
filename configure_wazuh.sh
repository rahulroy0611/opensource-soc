#!/bin/bash
git clone https://github.com/wazuh/wazuh-docker.git -b v4.9.2
cd wazuh-docker/single-node
docker-compose -f generate-indexer-certs.yml run --rm generator
sed -i 's/- 443:5601/- 4433:5601/g' docker-compose.yml
docker-compose up -d