FROM ubuntu:20.04

WORKDIR /root

ENV GO_VERSION 1.16.3
ENV NOMAD_VERSION 1.0.0

# fix tzdata before docker dependencies install
RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && apt-get install -y --no-install-recommends tzdata
RUN apt-get update --fix-missing  &&    \
    apt-get -q -y  install              \
      python3                           \
      python3-pip                       \
      git                               \
      curl                              \
      vim                               \
      sudo                              \
      `# Docker dependencies       `    \
      apt-transport-https               \
      ca-certificates                   \
      curl                              \
      gnupg-agent                       \
      software-properties-common        \
      `# misc                      `    \
      jq                                \
      uuid                              \
      `# nomad install needs zip   `    \
      zip                               \
      openssh-server                    \
      zsh                         &&    \
      rm -rf /var/lib/apt/lists/*


RUN adduser --gecos '' --disabled-password builder                      && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd


RUN ARCH="$(dpkg --print-architecture)"                                 && \
    curl -fsSL "https://github.com/boxboat/fixuid/releases/download/v0.5/fixuid-0.5-linux-$ARCH.tar.gz" | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid                               && \
    chmod 4755 /usr/local/bin/fixuid                                    && \
    mkdir -p /etc/fixuid                                                && \
    printf "user: builder\ngroup: builder\n" > /etc/fixuid/config.yml   


# Enable SSH server
RUN  sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config


# Install GoLang
RUN curl -s -O https://dl.google.com/go/go"${GO_VERSION}".linux-amd64.tar.gz    && \
    tar -xf go"${GO_VERSION}".linux-amd64.tar.gz -C /usr/local                  && \
    rm go"${GO_VERSION}".linux-amd64.tar.gz                                     && \
    mkdir /go


# Install Nomad
RUN curl -s -O "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"  && \
    unzip nomad*.zip                                                                                           && \
    chmod +x ./nomad && mv nomad /usr/local/bin && rm nomad*.zip


# Set up remote ssh environment
COPY .exports         /home/builder/.bashrc


# Install tools
RUN sudo pip3 install vag
    

# https://www.tutorialspoint.com/run-vs-cmd-vs-entrypoint-in-docker
COPY /entrypoint.sh /

COPY .ssh /home/builder/.ssh
RUN chmod +x  /entrypoint.sh                && \
    chown -R builder:builder /home/builder  && \
    chown -R builder:builder /go            

USER 1000
ENV USER=builder
WORKDIR /home/builder

EXPOSE 22
CMD [ "/entrypoint.sh" ]