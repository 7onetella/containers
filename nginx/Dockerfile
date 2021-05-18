FROM base:latest

ENV username=coder

RUN apt-get update && apt-get install -y nginx

COPY /.ssh /home/${username}/.ssh

COPY entrypoint.sh /
RUN chmod +x  /entrypoint.sh                            && \
    chown -R ${username}:${username} /home/${username}  

EXPOSE 80
EXPOSE 22

CMD ["/entrypoint.sh"]