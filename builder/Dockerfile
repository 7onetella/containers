FROM ubuntu:20.04

WORKDIR /root

ENV GO_VERSION 1.16.3
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