FROM ubuntu:14.04

ENV CONFIGURE_OPTS --disable-install-rdoc --enable-shared
ENV JRUBY_OPTS --2.0
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget build-essential ca-certificates libmysqlclient-dev libpq-dev autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN mkdir ruby-build && \
    wget -qO- https://github.com/sstephenson/ruby-build/archive/v20141225.tar.gz | \ 
    tar xz -C ruby-build/ --strip-components 1 && \
    cd ruby-build && \
    ./bin/ruby-build 2.1.5 /usr/local && rm -rf ruby-build
    
RUN git clone https://github.com/rubycas/rubycas-server /myapp
WORKDIR /myapp

RUN gem install bundler -v 1.10.0

# greatly speeds up nokogiri install
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1

# dependencies for nokogiri gem, sqlite3
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libxml2 libxml2-dev libxslt1-dev libsqlite3-dev

# To lock dependencies
COPY Gemfile /myapp
RUN bundle install
ADD config.yml /myapp

# With adapter overwrite for MySql
ADD casserver.rb /myapp/lib

EXPOSE 3012
CMD ["bundle", "exec", "rubycas-server", "-c", "config.yml"]
