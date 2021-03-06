ARG TOOLS_VERSION
FROM docker-registry.7onetella.net/7onetella/tools:${TOOLS_VERSION}

USER 1000
ENV USER=coder
WORKDIR /home/coder
USER coder

ENV CDR_VERSION=3.10.0
RUN curl -sfOL https://github.com/cdr/code-server/releases/download/v${CDR_VERSION}/code-server_${CDR_VERSION}_amd64.deb    && \
    sudo dpkg -i code-server_${CDR_VERSION}_amd64.deb                                                                       && \
    sudo systemctl enable code-server@$USER                                                                                 && \
    sudo rm code-server_${CDR_VERSION}_amd64.deb 


# vscode extention go tools prior to installing vscode go extention 
RUN export PATH=$PATH:.:/usr/local/go/bin/                  && \
    export GOPATH=/home/coder/go                            && \
    sudo mkdir -p /home/coder/go                            && \
    sudo chown coder:coder /home/coder/go                   && \
    go get -v golang.org/x/tools/gopls                      && \
    go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs       && \
    go get -v github.com/cweill/gotests/gotests             && \
    go get -v github.com/fatih/gomodifytags                 && \
    go get -v github.com/josharian/impl                     && \
    go get -v github.com/haya14busa/goplay/cmd/goplay       && \
    go get -v github.com/go-delve/delve/cmd/dlv             && \
    go get -v honnef.co/go/tools/cmd/staticcheck            && \
    go get -v github.com/ramya-rao-a/go-outline             && \
    `# project specific libraries `                         && \
    go get -v github.com/go-bindata/go-bindata/...          && \
    go get -v github.com/elazarl/go-bindata-assetfs/...     && \
    go get -v github.com/markbates/refresh                  && \
    go get -v github.com/mitchellh/gox                      && \
    go get -v github.com/go-swagger/go-swagger              && \
    `# terminal app `                                       && \
    go get -v github.com/sorenisanerd/gotty

# vscode extention
#   /usr/bin/code-server --install-extension jpotterm.simple-vim    && \
RUN /usr/bin/code-server --install-extension ms-python.python       && \               
    /usr/bin/code-server --install-extension golang.go              && \
    /usr/bin/python3 -m pip install -U pylint --user