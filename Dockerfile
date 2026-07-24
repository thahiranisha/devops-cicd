FROM ubuntu
RUN apt-get update
# There can be only one CMD for a Dockefile
CMD ["echo", "My first image"]
