FROM jenkinsci/jnlp-slave:latest

USER root
RUN apt-get update

# install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# install chrome
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -\
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable

# install firefox via mozilla PPA
RUN echo "deb http://ppa.launchpad.net/mozillateam/firefox-next/ubuntu bionic main" | tee -a /etc/apt/sources.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CE49EC21 \
    && apt-get update \
    && apt-get install -y --no-install-recommends firefox

# install firefox-esr via mozilla PPA
RUN add-apt-repository ppa:mozillateam/ppa \
   && apt-get update \
   && apt-get install -y firefox-esr

USER jenkins
