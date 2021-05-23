FROM docker-registry.7onetella.net/7onetella/base:1.0.0

ENV username=coder

RUN apt-get update && apt-get install -y nginx

COPY .ssh /home/${username}/.ssh

COPY entrypoint.sh /
COPY sites-available /etc/nginx/sites-available
RUN set -x                                                      && \
    chmod +x  /entrypoint.sh                                    && \
    chown -R ${username}:${username} /home/${username}          && \
    sudo mkdir -p /var/www/www.7onetella.net/htdocs             && \
    sudo mkdir -p /var/www/www.curiosityworks.org/htdocs        && \
    chown -R ${username}:${username} /var/www                   && \
    sudo ln -s /etc/nginx/sites-available/www.7onetella.net        \
               /etc/nginx/sites-enabled/www.7onetella.net       && \
    sudo ln -s /etc/nginx/sites-available/www.curiosityworks.org   \
               /etc/nginx/sites-enabled/www.curiosityworks.org               

EXPOSE 80
EXPOSE 22

CMD ["/entrypoint.sh"]