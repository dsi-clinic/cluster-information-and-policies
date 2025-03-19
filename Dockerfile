FROM ruby:3.1-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  libffi-dev \
  zlib1g-dev \
  libssl-dev  

WORKDIR /site

# Update to the specific Bundler version
RUN gem install bundler:2.4.19

RUN bundle config force_ruby_platform true
COPY Gemfile* ./

RUN bundle install

# RUN bundle config set force_ruby_platform true

EXPOSE 4000

# Default command to run - unused
CMD ["bundle", "exec", "jekyll", "serve", "--livereload", "--host", "0.0.0.0"]