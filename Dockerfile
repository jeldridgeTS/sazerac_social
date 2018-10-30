FROM ruby:2.4

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app
COPY . /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install

ADD . /airapp
