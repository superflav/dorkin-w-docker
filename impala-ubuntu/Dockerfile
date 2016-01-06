FROM cloudera/impala-dev:minimal

WORKDIR /home/dev/Impala
RUN git pull

# have to do this because:
# "The user to run build has to be the same as the Jenkins slave user so files
#   created in workspace have adequate owner and permission set. Side effect is
#   you can't configure the user to run inside docker (until Docker do support
#   user namespace)"
RUN chmod -R 777 .

CMD ["echo", "Ubuntu build container for Impala"]
