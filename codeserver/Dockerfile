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


# Install docker for Debian
RUN sudo apt-get update         && \
    sudo apt-get install -y     \
    apt-transport-https         \
    ca-certificates             \
    curl                        \
    gnupg                       \
    lsb-release
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  && \
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
RUN sudo apt-get update                                             && \
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -a -G docker coder                                      

# Install SSH server
RUN  apt-get install -q -y openssh-server > /dev/null
# RUN  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/'                 /etc/ssh/sshd_config
RUN  sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config


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
    go get -v honnef.co/go/tools/cmd/staticcheck        && \
    go get -v github.com/ramya-rao-a/go-outline

RUN  export PATH=$PATH:.:/usr/local/go/bin/               && \
     go get -v github.com/go-bindata/go-bindata/...       && \
     go get -v github.com/elazarl/go-bindata-assetfs/...  && \
     go get -v github.com/markbates/refresh               && \
     go get -v github.com/mitchellh/gox                   && \
     go get -v github.com/go-swagger/go-swagger

# When python extension issue is fixed: https://github.com/microsoft/vscode-python/issues/12465
# RUN /usr/bin/code-server --install-extension ms-python.python
COPY --chown=coder:coder python-2020.10.332292344_vsixhub.com.vsix /tmp/python-2020.10.332292344_vsixhub.com.vsix
COPY --chown=coder:coder settings.json  /home/coder/.local/share/code-server/User/settings.json

RUN /usr/bin/code-server --install-extension /tmp/python-2020.10.332292344_vsixhub.com.vsix             && \
    /usr/bin/code-server --install-extension golang.go                                                  && \
    /usr/bin/code-server --install-extension jpotterm.simple-vim                                        && \
    rm /tmp/python-2020.10.332292344_vsixhub.com.vsix                                                   && \   
    /usr/bin/python3 -m pip install -U pylint --user 

RUN mkdir -p /home/coder/workspace                    && \
    mkdir -p /home/coder/.local/bin                   && \
    chown -R coder:coder /home/coder/workspace        

RUN git clone https://github.com/7onetella/users.git  /home/coder/workspace/users
RUN git clone https://github.com/7onetella/containers.git  /home/coder/workspace/containers

COPY --chown=coder:coder config.yml     /home/coder/.config/code-server/config.yaml 
COPY --chown=coder:coder .exports       /home/coder/.bashrc
COPY --chown=coder:coder .gitconfig     /home/coder/.gitconfig
COPY --chown=coder:coder entrypoint.sh  /home/coder/.local/bin/entrypoint.sh
COPY --chown=coder:coder .ssh           /home/coder/.ssh

RUN chmod +x /home/coder/.local/bin/entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/home/coder/.local/bin/entrypoint.sh"]