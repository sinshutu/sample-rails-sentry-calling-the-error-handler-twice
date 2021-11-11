FROM ruby:2.7.4-slim

WORKDIR /app

ENV TZ Asia/Tokyo
ENV RUBYOPT -EUTF-8
ENV DEBCONF_NOWARNINGS yes

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -qq  \
    && apt-get install -y \
    git \
    build-essential \
    sqlite3 libsqlite3-dev \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*
RUN gem install bundler -v 2.1.4

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install -j4
#
# EXPOSE 3000
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
