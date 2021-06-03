ARG BASE_VERSION
FROM docker-registry.7onetella.net/7onetella/base:${BASE_VERSION}

RUN apt-get update --fix-missing  && \
    apt-get -q -y  install           \
      python3                        \
      python3-pip                    

# app.py dependencies
RUN pip3 install slackclient slackeventsapi vag

USER 1000
ENV USER=coder
WORKDIR /home/coder

# install serbot app
COPY --chown=coder:coder app.py         /
COPY --chown=coder:coder entrypoint.sh  /

RUN  chmod +x /entrypoint.sh

EXPOSE 22
EXPOSE 3000

CMD /entrypoint.sh