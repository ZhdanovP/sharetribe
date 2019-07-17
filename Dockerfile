FROM ruby:2.3.4

MAINTAINER Sharetribe Team <team@sharetribe.com>

ENV REFRESHED_AT 2016-11-08

# NOTE: we will migrate soon to newer ruby version and away from Debian
# Jessie-based image. For now, enable only package repositories that are still
# maintained for jessie for LTS.

RUN echo 'deb http://deb.debian.org/debian jessie main' > /etc/apt/sources.list \
    && echo 'deb http://security.debian.org jessie/updates main' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get dist-upgrade -y

#
# Node (based on official docker node image)
#

# gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 7.8.0

RUN apt-get update && apt-get install -yq \
    sudo \
    git \
    tmux \
    wget \
    zsh \
    vim \
    fonts-powerline \
    meld

RUN mkdir -p /home/app/marketplace

# ZSH config
RUN git clone https://github.com/robbyrussell/oh-my-zsh /opt/oh-my-zsh && \
    cp /opt/oh-my-zsh/templates/zshrc.zsh-template .zshrc && \
    cp -r /opt/oh-my-zsh .oh-my-zsh && \
    cp /opt/oh-my-zsh/templates/zshrc.zsh-template /home/app/.zshrc && \
    cp -r /opt/oh-my-zsh /home/app/.oh-my-zsh && \
    sed  "s/robbyrussell/bira/" -i /home/app/.zshrc && \
    echo "PROMPT=\$(echo \$PROMPT | sed 's/%m/%f\$IMAGE_NAME/g')" >> /home/app/.zshrc && \
    echo "RPROMPT=''" >> /home/app/.zshrc

# Sublime instalation
ARG SUBLIME_BUILD="${SUBLIME_BUILD:-3207}"
RUN wget --no-check-certificate  https://download.sublimetext.com/sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb --no-check-certificate && \
    dpkg -i sublime-text_build-"${SUBLIME_BUILD}"_amd64.deb

RUN wget --no-check-certificate -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
RUN echo "deb http://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
RUN apt-get update && apt-get install -y sublime-merge

RUN apt-get --assume-yes install nodejs
RUN apt-get --assume-yes install npm

#
# Sharetribe
#

# Install nginx - used to serve maintenance mode page
RUN apt-get install -y nginx

# Install latest bundler
ENV BUNDLE_BIN=
RUN gem install bundler

WORKDIR /home/app

COPY Gemfile /home/app
COPY Gemfile.lock /home/app

ENV RAILS_ENV production

RUN bundle install --deployment --without test,development

COPY package.json /home/app
COPY client/package.json /home/app/client/
COPY client/customloaders/customfileloader /home/app/client/customloaders/customfileloader

ENV NODE_ENV production
ENV NPM_CONFIG_LOGLEVEL error
ENV NPM_CONFIG_PRODUCTION true

COPY . /home/app

EXPOSE 3000

CMD ["script/startup.sh"]
#ENTRYPOINT ["script/entrypoint.sh"]

#
# Assets
#


# If assets.tar.gz file exists in project root
# assets will be extracted from there.
# Otherwise, assets will be compiled with `rake assets:precompile`.
# Useful for caching assets between builds.
#RUN script/prepare-assets.sh

COPY script/entrypoint.sh /usr/bin/
WORKDIR /home/app
ENTRYPOINT ["/bin/bash", "-e", "/usr/bin/entrypoint.sh"]
CMD ["/bin/zsh"]