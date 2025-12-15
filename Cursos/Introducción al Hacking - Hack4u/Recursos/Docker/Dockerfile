FROM ubuntu:latest

MAINTAINER Luka Tinarelli aka lukatinarelli "lrtinarelli@paradigmadigital.com"

ENV DEBIAN_FRONTEND moninteractive

RUN apt update && apt install -y apache2 php

EXPOSE 80

ENTRYPOINT service apache2 start && /bin/bash
