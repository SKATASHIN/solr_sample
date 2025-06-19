FROM ruby:3.2

# 必要なパッケージ
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-jdk

# Railsインストール
RUN gem install rails bundler

WORKDIR /myapp