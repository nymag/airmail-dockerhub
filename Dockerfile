FROM docker:stable

COPY LICENSE README.md /

# Get some base tools into the system
RUN apk update && \
  apk add curl docker jq bash ca-certificates git openssl openssh-client openrc unzip wget gettext less

RUN rc-update add docker boot

# Install Python3
RUN apk add python3 && \
  python3 -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip3 install --upgrade pip setuptools && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  rm -r /root/.cache

# Install AWS CLI
RUN pip install awscli airmail==0.0.8

#  Clean up
RUN rm -rf /tmp/* && \
  rm -rf /var/cache/apk/* && \
  rm -rf /var/tmp/*

ENV HOME=/usr/src/

WORKDIR $HOME/

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
