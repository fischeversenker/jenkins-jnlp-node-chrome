FROM jenkinsci/jnlp-slave:latest

USER root

# add sources
# RUN rm /etc/apt/sources.list \
#     && touch /etc/apt/sources.list \
#     && echo "deb http://deb.debian.org/debian stretch main" | tee -a /etc/apt/sources.list

# update sources
RUN apt-get update

# install node
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -\
    && apt-get update
RUN apt-get install -y nodejs

# install chrome
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | tee -a /etc/apt/sources.list \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -\
    && apt-get update \
    && apt-get install -y --no-install-recommends google-chrome-stable

# install firefox
RUN apt-get install -y --no-install-recommends firefox

# RUN cd /tmp \
#     && wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" \
#     && mkdir /opt/firefox \
#     && tar xjf FirefoxSetup.tar.bz2 -C /opt/firefox/

USER jenkins
