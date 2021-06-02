ARG CODESERVER_BASE
FROM docker-registry.7onetella.net/7onetella/codeserver-base:${CODESERVER_BASE}

RUN mkdir -p /home/coder/workspace                  && \
    mkdir -p /home/coder/.local/bin                 && \
    chown -R coder:coder /home/coder/workspace        

COPY --chown=coder:coder settings.json              /home/coder/.local/share/code-server/User/settings.json
COPY --chown=coder:coder config.yml                 /home/coder/.config/code-server/config.yaml 
COPY --chown=coder:coder .gitconfig                 /home/coder/.gitconfig
COPY --chown=coder:coder entrypoint.sh              /home/coder/.local/bin/entrypoint.sh
COPY --chown=coder:coder .ssh/                      /home/coder/.ssh
COPY --chown=coder:coder git_clone.sh               /home/coder/.local/bin/git_clone.sh
COPY --chown=coder:coder repositories.txt           /home/coder/.local/bin/repositories.txt
COPY --chown=coder:coder runtime_install.sh         /home/coder/.local/bin/runtime_install.sh
COPY --chown=coder:coder git-ssh-config             /home/coder/.git-ssh-config
COPY --chown=coder:coder gotty.sh                   /home/coder/.local/bin/gotty.sh

RUN chmod +x /home/coder/.local/bin/entrypoint.sh

EXPOSE 9991
EXPOSE 22

ENTRYPOINT ["/home/coder/.local/bin/entrypoint.sh"]