FROM lang:latest

ENV username=coder

RUN apt-get update --fix-missing  &&    \
    apt-get -q -y  install              \
    `# Docker dependencies       `      \
    apt-transport-https                 \
    ca-certificates                     \
    gnupg                               \
    `# misc                      `      \
    jq                                  \
    uuid                                \
    `# nomad install needs zip   `      \
    zip                                 \
  && rm -rf /var/lib/apt/lists/*


# Install docker for Debian
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  && \
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
RUN sudo apt-get update                                             && \
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -a -G docker coder                                      


# Install Nomad
ENV NOMAD_VERSION 1.0.0
RUN curl -s -O "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"  && \
    unzip nomad*.zip                                                                                           && \
    chmod +x ./nomad && mv nomad /usr/local/bin && rm nomad*.zip


# Install tools
RUN sudo pip3 install vag


COPY /builder/entrypoint.sh /
COPY /builder/.ssh /home/${username}/.ssh
RUN chmod +x  /entrypoint.sh                            && \
    chown -R ${username}:${username} /home/${username}  && \
    chown -R ${username}:${username} /go            


USER 1000
ENV USER=${username}
WORKDIR /home/${username}


EXPOSE 22
CMD [ "/entrypoint.sh" ]