ARG BASE_VERSION
FROM docker-registry.7onetella.net/7onetella/base:$BASE_VERSION


RUN apt-get update --fix-missing  &&    \
    apt-get -q -y  install              \
    python3                             \
    python3-pip                         \
  && rm -rf /var/lib/apt/lists/*


ENV GO_VERSION 1.16.3
RUN curl -s -O https://dl.google.com/go/go"${GO_VERSION}".linux-amd64.tar.gz    && \
    tar -xf go"${GO_VERSION}".linux-amd64.tar.gz -C /usr/local                  && \
    rm go"${GO_VERSION}".linux-amd64.tar.gz                                     && \
    mkdir /go


# Install Node
# CREDIT https://github.com/nodejs/docker-node/blob/dd05dd89c6e158a4893109e42d51cd0f5065d631/15/buster/Dockerfile
COPY node_install.sh /root/
RUN  chmod +x /root/node_install.sh  && \ 
     /root/node_install.sh           && \ 
     rm /root/node_install.sh


# Install Ember CLI
# RUN npm install -g ember-cli
