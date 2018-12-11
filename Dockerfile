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

# install firefox from mint
RUN echo "deb http://packages.linuxmint.com debian import" | tee -a /etc/apt/sources.list \
    && apt-get update \
    && cd /tmp \
    && gpg --keyserver pgp.mit.edu --recv-keys 3EE67F3D0FF405B2 \
    && gpg --export 3EE67F3D0FF405B2 > 3EE67F3D0FF405B2.gpg \
    && apt-key add ./3EE67F3D0FF405B2.gpg \
    && rm ./3EE67F3D0FF405B2.gpg \
    && apt-get install firefox firefox-l10n-en-us

# install firefox manually
RUN cd /tmp \
    && wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" \
    && mkdir /opt/firefox \
    && tar xjf FirefoxSetup.tar.bz2 -C /opt/firefox/

ENV FIREFOX_BIN /opt/firefox/firefox/firefox

USER jenkins
