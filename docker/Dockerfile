FROM docker.prod.pdc.digital.csaa-insurance.aaa.com/ubuntu-ruby-aws:latest

RUN \
  apt-get update &&\
  gem install dogapi --no-ri --no-rdoc && \
  rm -rf /var/lib/apt/lists/*
