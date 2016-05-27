FROM ruby:2.3.3
MAINTAINER Diego P. Steiner diego.steiner@u041.ch

ENV APP /app
WORKDIR $APP
ENV BUNDLE_PATH $APP/hitobito/vendor/bundle
RUN mkdir $APP || true
ARG APP_PORT

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb
RUN apt-get install -y nodejs
RUN gem install bundler
#ADD hitobito/Gemfile hitobito/Gemfile.lock hitobito/.ruby-version ./
#RUN sed -i "s/^\(gem .mysql2.\),.*$/\1/" hitobito/Gemfile
# RUN bundle install --deployment --jobs 20 --retry 5

ADD . $APP
#RUN sed -i "s/^\(gem .mysql2.\),.*$/\1/" Gemfile
#RUN bundle install --jobs 20 --retry 5

RUN ./bin/docker_setup
CMD ./hitobito/bin/rails s -p $APP_PORT -b 0.0.0.0
#EXPOSE $APP_PORT
