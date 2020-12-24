FROM ubuntu:20.04

WORKDIR /root

ENV GO_VERSION 1.15.6
ENV NOMAD_VERSION 1.0.0

# fix tzdata before docker dependencies install
RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    \
      git                            \
      curl                           \
      vim                            \
      `# Docker dependencies       ` \
      apt-transport-https            \
      ca-certificates                \
      curl                           \
      gnupg-agent                    \
      software-properties-common     \
      `# misc                      ` \
      jq                             \
      uuid


# Set up remote ssh environment
COPY .exports         /root/.exports


# Install GoLang
RUN curl -O https://dl.google.com/go/go"${GO_VERSION}".linux-amd64.tar.gz  && \
    tar -xf go"${GO_VERSION}".linux-amd64.tar.gz -C /usr/local             && \
    cat ~/.exports >> ~/.bashrc                                            && \
    rm go"${GO_VERSION}".linux-amd64.tar.gz                                && \
    mkdir /go


# Install Node
# CREDIT https://github.com/nodejs/docker-node/blob/dd05dd89c6e158a4893109e42d51cd0f5065d631/15/buster/Dockerfile
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
COPY /node_install.sh /root/
RUN chmod +x node_install.sh && \ 
    ./node_install.sh        && \ 
    rm /root/node_install.sh


# Install Ember CLI
RUN npm install -g ember-cli


# Docker install: https://docs.docker.com/engine/install/ubuntu/
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN apt-get update && apt-get install -q -y docker-ce docker-ce-cli containerd.io


# Install SSH server
RUN apt-get install -q -y openssh-server > /dev/null
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/'                 /etc/ssh/sshd_config
RUN sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
COPY .ssh            /root/.ssh


# Install tools
RUN pip3 install vag


# Install Nomad
RUN apt-get install -q -y zip > /dev/null
RUN curl -s -O "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"  && \
    unzip nomad*.zip                                                                                           && \
    chmod +x ./nomad && mv nomad /usr/local/bin && rm nomad*.zip
    

# https://www.tutorialspoint.com/run-vs-cmd-vs-entrypoint-in-docker
COPY /entrypoint.sh /
RUN chmod +x  /entrypoint.sh
EXPOSE 22
ENTRYPOINT [ "/entrypoint.sh" ]