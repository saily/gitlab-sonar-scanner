FROM node:lts-slim

ARG SONAR_SCANNER_VERSION=4.2.0.1873

ADD https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip /tmp/sonar-scanner.zip

RUN apt-get update -qq && \
    apt-get install -y unzip && \
    unzip -d /opt /tmp/sonar-scanner.zip && \
    apt-get remove -y unzip && \
    rm /tmp/sonar-scanner.zip && \
    rm -rf /var/lib/apt/lists && \
    npm install --silent --save-dev -g typescript

ENV PATH=/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin:$PATH

ENTRYPOINT sonar-scanner
