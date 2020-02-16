FROM node:lts-slim

MAINTAINER Daniel Widerin <daniel@widerin.net>

ARG SONAR_SCANNER_VERSION=4.2.0.1873

ADD https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip /tmp/sonar-scanner.zip

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y unzip git && \
    unzip -d /opt /tmp/sonar-scanner.zip && \
    apt-get remove -y unzip && \
    rm /tmp/sonar-scanner.zip && \
    rm -rf /var/lib/apt/lists && \
    npm install --silent --save-dev -g typescript

ENV PATH=/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin:$PATH \
    NODE_PATH=/usr/local/lib/node_modules

ENTRYPOINT sonar-scanner
