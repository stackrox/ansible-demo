FROM frolvlad/alpine-glibc:alpine-3.11_glibc-2.31

ARG OC_VERSION=4.6
 
ENV ANSIBLE_VERSION 2.10.4
 
ENV BUILD_PACKAGES \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  python3 \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-paramiko \
  py-pip \
  py-yaml \
  ca-certificates
 
# If installing ansible@testing
#RUN \
#	echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> #/etc/apk/repositories
 
RUN set -x && \
    \
    echo "==> Adding build-dependencies..."  && \
    apk --update add --virtual build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      openssl-dev \
      tar \
      gzip \
      curl \
      ca-certificates \
      gettext \
      python3-dev && \
    \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..."  && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    pip3 install python-keyczar docker-py && \
    \
    echo "==> Installing Ansible & dependencies..."  && \
    pip3 install jmespath openshift ansible==${ANSIBLE_VERSION} && \
    \
    echo "==> Cleaning up..."  && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    \
    echo "==> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible /ansible && \
    echo "[local]" >> /etc/ansible/hosts && \
    echo "localhost" >> /etc/ansible/hosts

# install kubectl & oc

RUN mkdir /tools && \
    curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v$(echo $OC_VERSION | cut -d'.' -f 1)/clients/oc/$OC_VERSION/linux/oc.tar.gz &&\
    tar xzvf /tmp/oc.tar.gz -C /bin &&\
    rm -rf /tmp/oc.tar.gz 

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
     && chmod u+x kubectl && mv kubectl /bin/kubectl

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library

ADD playbooks/roles/ /ansible/playbooks/roles/
ADD playbooks/*.yml /ansible/playbooks/

RUN mkdir /ansible/playbooks/files

WORKDIR /ansible/playbooks

RUN ansible-galaxy install -r requirements.yml
 
ENTRYPOINT ["ansible-playbook"]
CMD ["-i", "inventory.yml", "main.yml"]
