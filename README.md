##Building the AppDynamics Infra Agent

###To build the Infra Agent follow the outlined steps:

1. Download the Linux Infra Agent package from AppDynamic's downloads portal (https://download.appdynamics.com/). The artifacts
name should follow the pattern __appdynamics-infra-agent-linux-amd64-BUILD_NUMBER.zip__. Currently, the Infra Agent can only run as a Linux container.
2. Make sure you download it to the same directory where the Dockerfile and the start_appdynamics script reside.
3. Build the image by typing `docker build -t appd-infra-agent:latest .`
4. Run a container by typing the following. You must run as sudo in order to use the Infra Agent's container monitoring capabilities. If you only want the server
monitoring capabilities, you may omit sudo.  
```
sudo docker run -d --rm \  
     --volume=/proc:/host/proc:ro \  
     --volume=/:/rootfs:ro,rslave \  
     --volume=/var/run:/var/run:ro \  
     --volume=/sys:/sys:ro \  
     --volume=/var/lib/docker/:/var/lib/docker:ro \  
     --volume=/dev/disk/:/dev/disk:ro \  
     --volume=<path/to/logs/on/local/machine>:/opt/appdynamics/infra-agent/logs \  
     --net=host \  
     --name=infraagent \  
     --privileged \  
     --device=/dev/kmsg \  
     --env APPDYNAMICS_IA_CONTROLLER_HOST=<host> \  
     --env APPDYNAMICS_IA_CONTROLLER_PORT=<port> \  
     --env APPDYNAMICS_IA_CONTROLLER_ACCOUNT_NAME=<name> \  
     --env APPDYNAMICS_IA_CONTROLLER_ACCESS_KEY=<key> \  
     appd-infra-agent:latest
```   
5. You must fill in the values for the following keys: APPDYNAMICS_IA_CONTROLLER_HOST, APPDYNAMICS_IA_CONTROLLER_PORT, APPDYNAMICS_IA_CONTROLLER_ACCOUNT_NAME, APPDYNAMICS_IA_CONTROLLER_ACCESS_KEY.
6. Now you will be able to obtain critical insight into your infrastructure!

