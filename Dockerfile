FROM ruby:2.2.3 
RUN apt-get update -qq && \
    apt-get install -y build-essential 

RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs
RUN gem install zeus
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs=4

ENV APP_HOME /sample_app
RUN mkdir -p /sample_app
WORKDIR $APP_HOME

ADD . $APP_HOME
RUN zeus init
ENV RAILS_ENV=development

