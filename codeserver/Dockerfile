FROM codercom/code-server:3.9.1 

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    \
      `# Docker dependencies       ` \
      apt-transport-https            \
      ca-certificates                \
      curl                           \
      gnupg-agent                    \
      software-properties-common     \
      `# misc                      ` \
      jq                             \
      uuid


# Install Node
# CREDIT https://github.com/nodejs/docker-node/blob/dd05dd89c6e158a4893109e42d51cd0f5065d631/15/buster/Dockerfile
# RUN  groupadd --gid 1000 node && useradd --uid 1000 --gid node --shell /bin/bash --create-home node
COPY node_install.sh /root/
RUN  chmod +x /root/node_install.sh  && \ 
     /root/node_install.sh           && \ 
     rm /root/node_install.sh


# Install Ember CLI
RUN npm install -g ember-cli


# Docker install: https://docs.docker.com/engine/install/ubuntu/
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
# RUN add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
# RUN apt-get update && apt-get install -q -y docker-ce docker-ce-cli containerd.io


# Install SSH server
RUN  apt-get install -q -y openssh-server > /dev/null
RUN  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/'                 /etc/ssh/sshd_config
RUN  sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
COPY .ssh /home/coder/.ssh


# Install GoLang
ENV GO_VERSION 1.16.2
RUN curl -O https://dl.google.com/go/go"${GO_VERSION}".linux-amd64.tar.gz  && \
    tar -xf go"${GO_VERSION}".linux-amd64.tar.gz -C /usr/local             && \
    rm go"${GO_VERSION}".linux-amd64.tar.gz    


USER coder
# vscode go extention go tools
RUN export PATH=$PATH:.:/usr/local/go/bin/              && \
    mkdir -p ~/go                                       && \
    go get -v golang.org/x/tools/gopls                  && \
    go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs   && \
    go get -v github.com/cweill/gotests/gotests         && \
    go get -v github.com/fatih/gomodifytags             && \
    go get -v github.com/josharian/impl                 && \
    go get -v github.com/haya14busa/goplay/cmd/goplay   && \
    go get -v github.com/go-delve/delve/cmd/dlv         && \
    go get -v honnef.co/go/tools/cmd/staticcheck 

RUN  export PATH=$PATH:.:/usr/local/go/bin/               && \
     go get -v github.com/go-bindata/go-bindata/...       && \
     go get -v github.com/elazarl/go-bindata-assetfs/...  && \
     go get -v github.com/markbates/refresh               && \
     go get -v github.com/mitchellh/gox                   && \
     go get -v github.com/go-swagger/go-swagger

RUN /usr/bin/code-server --install-extension ms-python.python     && \
    /usr/bin/code-server --install-extension golang.go            && \
    /usr/bin/code-server --install-extension jpotterm.simple-vim 

RUN mkdir -p /home/coder/workspace                    && \
    mkdir -p /home/coder/.local/bin                   && \
    chown -R coder:coder /home/coder/workspace        

RUN git clone https://github.com/7onetella/users.git  /home/coder/workspace/users

COPY --chown=coder:coder config.yml     /home/coder/.config/code-server/config.yaml 
COPY --chown=coder:coder .vscode        /home/coder/workspace/.vscode
COPY --chown=coder:coder .exports       /home/coder/.bashrc
COPY --chown=coder:coder .gitconfig     /home/coder/.gitconfig
COPY --chown=coder:coder entrypoint.sh  /home/coder/.local/bin/entrypoint.sh

RUN chmod +x /home/coder/.local/bin/entrypoint.sh

ENTRYPOINT ["/home/coder/.local/bin/entrypoint.sh"]