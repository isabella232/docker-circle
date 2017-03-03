FROM koding/base
MAINTAINER Sonmez Kartal <sonmez@koding.com>

RUN pip install --upgrade awscli s3cmd

RUN apt-add-repository ppa:duggan/jo --yes && \
    apt-get update --quiet && \
    apt-get install --yes apt-transport-https ca-certificates \
            gettext-base jo netcat-openbsd zip

RUN curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && apt-get install --yes docker-ce

ENV DOCKER_COMPOSE_VERSION=1.12.0
RUN curl --silent \
         --location https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` \
         --output /usr/local/bin/docker-compose && \
         chmod +x /usr/local/bin/docker-compose

ENV PACKER_VERSION=1.0.0
RUN wget --quiet --output-document /tmp/packer.zip \
  https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_${PACKER_VERSION}_linux_amd64.zip && \
  unzip /tmp/packer.zip -d /usr/local/bin && \
  packer version

ENV TERRAFORM_VERSION=0.9.5
RUN wget --quiet --output-document /tmp/terraform.zip \
  https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip /tmp/terraform.zip -d /usr/local/bin && \
  terraform version
