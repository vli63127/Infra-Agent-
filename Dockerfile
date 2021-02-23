FROM ubuntu:18.04

LABEL name="AppDynamics Infrastructure Agent"

# Install required packages
RUN apt-get update && apt-get install -y ca-certificates unzip wget && update-ca-certificates \
 	&& rm -rf /var/lib/apt/lists/*

RUN apt-get clean

# Add Tini (same as --init flag for docker run)
ENV TINI_VERSION v0.19.0
RUN wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -O /tini && \
	chmod +x /tini

# Install AppDynamics Infrastructure Agent
ENV INFRA_AGENT_HOME /opt/appdynamics/infra-agent/
COPY start_appdynamics ${INFRA_AGENT_HOME}
COPY appdynamics-infra-agent-linux-amd64-*.zip /tmp/infra-agent.zip
RUN mkdir -p ${INFRA_AGENT_HOME} && \
    unzip -oq /tmp/infra-agent.zip -d ${INFRA_AGENT_HOME} && \
    chmod 744 ${INFRA_AGENT_HOME}/start_appdynamics && \
    rm /tmp/infra-agent.zip

# Changing directory to INFRA_AGENT_HOME
WORKDIR ${INFRA_AGENT_HOME}

# Required configs for startup passed into container via environment variables
ENTRYPOINT ["/tini", "-g", "--"]
CMD ["./start_appdynamics"]