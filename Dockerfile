FROM node:lts-slim

ARG SONAR_SCANNER_VERSION=4.2.0.1873

RUN npm install --silent --save-dev -g typescript

COPY sonar-scanner-run.sh /usr/bin/gitlab-sonar-scanner
ADD https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip /tmp/sonar-scanner.zip

RUN apt-get update -qq && \
    apt-get install -y unzip && \
    unzip -d /opt /tmp/sonar-scanner.zip && \
    rm /tmp/sonar-scanner.zip && \
    rm -rf /var/lib/apt/lists

ENV PATH=/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux/bin:$PATH

ENTRYPOINT /usr/bin/gitlab-sonar-scanner
