FROM ubuntu:14.04
MAINTAINER ir2sora ir2sora@gmail.com

ENV REFRESHED_AT 2015-04-06
ENV RM_VERSION 2.3.0
ENV RUBY_VERSION 1.8
ENV RAILS_VERSION 3.2.13

RUN apt-get -qq update && apt-get install -y -qq \
	git \
	software-properties-common \
	libmysqlclient-dev


# install RVM, Ruby, Rails, and Bundler
RUN apt-add-repository ppa:brightbox/ruby-ng && \
	apt-get -qq update && apt-get install -y -qq \
	ruby$RUBY_VERSION \
	rubygems$RUBY_VERSION \
	ruby-switch
RUN gem install rails -v $RAILS_VERSION --no-rdoc --no-ri -q
RUN gem install bundler --no-rdoc --no-ri -q

# install Redmine
RUN cd /usr/local && \
	git clone -q --depth=1 -b $RM_VERSION https://github.com/redmine/redmine.git && \
 	cd redmine && \
	rm -rf .git

WORKDIR /usr/local/redmine
VOLUME /usr/local/redmine/log
VOLUME /usr/local/redmine/files

COPY database.yml /usr/local/redmine/config/
RUN bundle install --without development test rmagick postgresql sqlite --quiet
RUN rake generate_secret_token