FROM jenkinsci/jnlp-slave:latest

USER root

RUN apt-get update

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -\
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      google-chrome-stable \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

USER jenkins
