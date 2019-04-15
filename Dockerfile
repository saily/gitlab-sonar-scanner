FROM openjdk:11-jdk-slim

ENV SONAR_SCANNER_VERSION 3.3.0.1492

COPY sonar-scanner-run.sh /usr/bin

ADD https://bintray.com/sonarsource/SonarQube/download_file?file_path=org%2Fsonarsource%2Fscanner%2Fcli%2Fsonar-scanner-cli%2F${SONAR_SCANNER_VERSION}%2Fsonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip /tmp/sonar-scanner.zip

WORKDIR /tmp

RUN \
    unzip /tmp/sonar-scanner.zip && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/lib/* /usr/lib

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*  && \
    ls -lha /usr/bin/sonar* && \
    ln -s /usr/bin/sonar-scanner-run.sh /usr/bin/gitlab-sonar-scanner

WORKDIR /usr/bin
