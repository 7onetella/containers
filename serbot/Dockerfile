ARG BASE_VERSION
FROM docker-registry.7onetella.net/7onetella/base:${BASE_VERSION}

RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    \
      postgresql                     \
      libpq-dev                      \
      unzip


# Install Nomad
ENV NOMAD_VERSION 1.0.0
RUN curl -s -O "https://releases.hashicorp.com/nomad/${NOMAD_VERSION}/nomad_${NOMAD_VERSION}_linux_amd64.zip"  && \
    unzip nomad*.zip                                                                                           && \
    chmod +x ./nomad && mv nomad /usr/local/bin && rm nomad*.zip


# app.py dependencies
RUN pip3 install slackclient slackeventsapi vag


USER 1000
ENV USER=coder
WORKDIR /home/coder
USER coder

RUN git clone https://github.com/7onetella/containers.git

# install serbot app
COPY --chown=coder:coder app.py         /
COPY --chown=coder:coder entrypoint.sh  /
RUN  chmod +x /entrypoint.sh


EXPOSE 22
EXPOSE 3000


CMD /entrypoint.sh