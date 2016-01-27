FROM williamyeh/ansible:ubuntu14.04-onbuild

# ==> Specify requirements filename;  default = "requirements.yml"
#ENV REQUIREMENTS  requirements.yml

# ==> Specify playbook filename;      default = "playbook.yml"
ENV PLAYBOOK ansible/playbook.yml

# ==> Specify inventory filename;     default = "/etc/ansible/hosts"
#ENV INVENTORY     inventory.ini

# ==> Executing Ansible (with a simple wrapper)...
RUN ansible-playbook-wrapper

# ==> Clean out no longer needed docker-ansible files
WORKDIR  /tmp
RUN rm -rf ansible/ Dockerfile Makefile README.md
WORKDIR  /

# ==> Start container w/entrypoint script, defaulting it to running as a daemon
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["-daemon"]
