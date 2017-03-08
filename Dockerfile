FROM ruby:2.3.3
MAINTAINER Diego P. Steiner diego.steiner@u041.ch

ENV APP /app
WORKDIR $APP
ENV BUNDLE_PATH $APP/hitobito/vendor/bundle
RUN mkdir $APP || true
ARG APP_PORT

RUN apt-get update -qq && apt-get install -y build-essential \
 libxml2-dev libxslt1-dev libqt4-webkit libqt4-dev xvfb nodejs
RUN gem install bundler
RUN gem install foreman
#ADD hitobito/Gemfile hitobito/Gemfile.lock hitobito/.ruby-version ./
#RUN sed -i "s/^\(gem .mysql2.\),.*$/\1/" hitobito/Gemfile
# RUN bundle install --deployment --jobs 20 --retry 5

ADD ./bin $APP/bin
ADD ./wagons.yml $APP

RUN ./bin/setup
CMD ./bin/run
#EXPOSE $APP_PORT
