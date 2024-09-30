## Environment Setup
    git clone https://github.com/rahulroy0611/opensource-soc
    cd misp
    docker compose pull
    cd ..
    cd hive_cortext_elasticsearch
    docker compose pull
    cd ..
    cd kibana
    docker compose pull

> replace public ip on **misp/.env**

    BASE_URL='https://<public_ip>

## Run the Setup
    cd misp
    docker compose up -d
    cd ..
    cd hive_cortex_elasticsearch
    docker compose up -d

### TheHive Integration with WAZUH

First of all, we install TheHive Python module:
``` sudo /var/ossec/framework/python/bin/pip3 install thehive4py==1.8.1 ```

1. copy custom-w2thive.py & copy-w2thive.sh toWAZUH server (/var/osses/integration/)
2. mv custom-w2thive.sh custom-w2thive
3. chmod +x custom-w2thive
4. Modify /var/ossec/etc/ossec.conf
```
<ossec_config>
    …
    <integration>
        <name>custom-w2thive</name>
        <hook_url>http://TheHive_Server_IP:9000</hook_url>
        <api_key><hive_api_key></api_key>
        <alert_format>json</alert_format>
    </integration>
    …
</ossec_config>
```
Restart the manager to apply the changes:
```sudo systemctl restart wazuh-manager```





