FROM codercom/code-server:3.9.1 

COPY --chown=coder:coder config.yml /home/coder/.config/code-server/config.yaml 
COPY --chown=coder:coder .exports   /home/coder/.bashrc
COPY --chown=coder:coder .gitconfig /home/coder/.gitconfig

RUN mkdir -p /home/coder/workspace               && \
    mkdir -p /home/coder/.local/bin              && \
    chown -R coder:coder /home/coder/workspace   && \
    /usr/bin/code-server --install-extension ms-python.python    && \
    /usr/bin/code-server --install-extension golang.go           && \
    /usr/bin/code-server --install-extension jpotterm.simple-vim 

COPY --chown=coder:coder .vscode    /home/coder/workspace/.vscode
COPY --chown=coder:coder node_install.sh /home/coder/.local/bin

USER root
RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    \
      gnupg-agent

ENV GO_VERSION 1.16.2
# Install GoLang
RUN curl -O https://dl.google.com/go/go"${GO_VERSION}".linux-amd64.tar.gz  && \
    tar -xf go"${GO_VERSION}".linux-amd64.tar.gz -C /usr/local             && \
    rm go"${GO_VERSION}".linux-amd64.tar.gz                               

USER coder
# RUN export PATH=$PATH:.:/usr/local/go/bin/            && \
#     mkdir -p ~/go                                     && \
#     go get -v golang.org/x/tools/gopls                && \
#     go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs && \
#     go get -v github.com/ramya-rao-a/go-outline       && \
#     go get -v github.com/go-delve/delve/cmd/dlv       && \
#     go get -v golang.org/x/lint/golint               

RUN cd ~/workspace                                    && \
    git clone https://github.com/7onetella/users.git 
# RUN chmod +x /home/coder/.local/bin/node_install.sh   && \
#     /home/coder/.local/bin/node_install.sh    

ENTRYPOINT ["/usr/bin/entrypoint.sh", "--bind-addr", "0.0.0.0:8080", "/home/coder/workspace"]