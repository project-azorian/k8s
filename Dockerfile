FROM ubuntu:20.04

SHELL ["bash", "-exc"]
ENV DEBIAN_FRONTEND noninteractive

# Update distro and install ansible
RUN apt-get update ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y --no-install-recommends \
        python3-minimal \
        python3-pip \
        python3-apt \
        python3-setuptools \
        openssh-client ;\
    pip3 install --upgrade wheel ;\
    pip3 install --upgrade ansible ;\
    rm -rf /var/lib/apt/lists/*


COPY assets /opt/assets

CMD /opt/assets/entrypoint.sh