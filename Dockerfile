FROM jenkinsci/jnlp-slave:latest

USER root

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 10.14.1

RUN apk add --no-cache gnupg git jq curl nodejs=$NODE_VERSION npm rsync python build-base

ADD wait-for-it /usr/local/bin

RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -\
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      google-chrome-stable \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

USER jenkins
