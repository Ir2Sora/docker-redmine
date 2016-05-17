FROM ubuntu:14.04
MAINTAINER ir2sora ir2sora@gmail.com

ENV REFRESHED_AT 2016-05-16
ENV RM_VERSION 3.2.2
ENV RUBY_VERSION 1.9.3

RUN apt-get -qq update && apt-get install -y -qq \
	git \
	libmysqlclient-dev \
	make \
	ruby$RUBY_VERSION \ 
	ruby-mysql2

# install Rails, and Bundler
RUN gem install bundler --no-rdoc --no-ri -q

# install Redmine
RUN cd /usr/local && \
	git clone -q --depth=1 -b $RM_VERSION https://github.com/redmine/redmine.git && \
	cd redmine && \
	rm -rf .git

WORKDIR /usr/local/redmine

COPY database.yml /usr/local/redmine/config/

RUN bundle install --without development test rmagick postgresql sqlite --quiet
RUN rake generate_secret_token

VOLUME /usr/local/redmine/log
VOLUME /usr/local/redmine/files
VOLUME /usr/local/redmine/plugins