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
    docker compose up -d

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

1. copy custom-w2thive.py & copy-w2thive.sh to WAZUH server (/var/ossec/integration/)
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

```
sudo systemctl restart wazuh-manager
```

### MISP Integration with WAZUH

copy custom-misp.py file to WAZUH server (/var/ossec/integration)

```
mv custom-misp.py custom-misp
```

Add Integration Block To Wazuh’s ossec.conf
```
<integration>
    <name>custom-misp</name>
    <group>sysmon_event1,sysmon_event3,sysmon_event6,sysmon_event7,sysmon_event23,sysmon_event24,sysmon_event25,sysmon_event_22,syscheck</group>
    <alert_format>json</alert_format>
</integration>
```
Must Restart the Wazuh Manager to apply the changes.
```
sudo systemctl restart wazuh-manager
```

#### Creating MISP custom rules
Lastly, we need to configure custom rules so that Wazuh can generate an alert if MISP responds with a positive hit.
```
<group name="misp,">
<rule id="100620" level="10">
<field name="integration">misp</field>
<match>misp</match>
<description>MISP Events</description>
<options>no_full_log</options>
</rule>
<rule id="100621" level="5">
<if_sid>100620</if_sid>
<field name="misp.error">\.+</field>
<description>MISP - Error connecting to API</description>
<options>no_full_log</options>
<group>misp_error,</group>
</rule>
<rule id="100622" level="12">
<field name="misp.category">\.+</field>
<description>MISP - IoC found in Threat Intel - Category: $(misp.category), Attribute: $(misp.value)</description>
<options>no_full_log</options>
<group>misp_alert,</group>
</rule>
</group>
```






