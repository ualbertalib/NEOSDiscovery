
FROM ruby:2.3.4
MAINTAINER nnunn

# Need to add jessie-backports repo so we can get FFMPEG, doesn't come with jessie debian by default
# RUN echo 'deb http://ftp.debian.org/debian jessie-backports main'  >> /etc/apt/sources.list

RUN apt-get update -qq \
    && apt-get install -y build-essential \
                          libpq-dev  \
                          nodejs \
                          # npm \
                          # nodejs-legacy \
                          # libreoffice \
                          # imagemagick \
                          # ghostscript \
                          # unzip \
                          # ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

# Preinstall gems in an earlier layer so we don't reinstall every time any file changes.
COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install

# *NOW* we copy the codebase in
ADD . /app

EXPOSE 3000