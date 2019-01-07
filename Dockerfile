FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

# an editor
RUN apt-get install -y vim

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y apt-transport-https ca-certificates
RUN apt-get update && apt install -y yarn

# app directory
ENV APP_HOME /cthdb
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# setup bundler
COPY Gemfile* $APP_HOME/
ENV GEM_HOME=/bundle
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile
ENV BUNDLE_JOBS=2
ENV BUNDLE_PATH=/bundle
ENV BUNDLE_BIN=/bundle/bin

ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV RAILS_ENV=development
RUN bundle install

COPY . $APP_HOME
