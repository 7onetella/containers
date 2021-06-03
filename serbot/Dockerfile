ARG BASE_VERSION
FROM docker-registry.7onetella.net/7onetella/base:${BASE_VERSION}

RUN apt-get update --fix-missing  &&    \
    apt-get -q -y  install              \
    python3                             \
    python3-pip                         \
    `# Docker dependencies       `      \
    apt-transport-https                 \
    ca-certificates                     \
    gnupg                               \
    `# vag dependencies          `      \
    postgresql                          \
    libpq-dev                           \
    `# nomad dependencies        `      \
    zip


# Install Nomad
ENV NOMAD_VERSION 1.0.0
RUN curl -s -O "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"  && \
    unzip nomad*.zip                                                                                           && \
    chmod +x ./nomad && mv nomad /usr/local/bin && rm nomad*.zip


# app.py dependencies
RUN pip3 install slackclient slackeventsapi vag



# Install docker for Debian
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg  && \
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 
RUN sudo apt-get update                                             && \
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
RUN usermod -a -G docker coder                                      



USER 1000
ENV USER=coder
WORKDIR /home/coder
USER coder

COPY .ssh /home/${USER}/.ssh
RUN git clone https://github.com/7onetella/containers.git

# install serbot app
COPY --chown=coder:coder app.py         /
COPY --chown=coder:coder entrypoint.sh  /
RUN  chmod +x /entrypoint.sh


EXPOSE 22
EXPOSE 3000


CMD /entrypoint.sh