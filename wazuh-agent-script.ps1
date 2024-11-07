$hostname = hostname
$server_ip = "<ip>"
Invoke-WebRequest -Uri https://packages.wazuh.com/4.x/windows/wazuh-agent-4.9.2-1.msi -OutFile $env:tmp\wazuh-agent; msiexec.exe /i $env:tmp\wazuh-agent /q WAZUH_MANAGER=$server_ip WAZUH_AGENT_NAME=$hostname 
NET START WazuhSvc