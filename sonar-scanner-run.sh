#!/bin/sh

echo "[INFO] This script has been deprecated, use 'sonar-scanner' instead."

if [ -z ${SONAR_URL+x} ]; then
  echo "Undefined \"SONAR_URL\" env" && exit 1
fi

URL=$SONAR_URL

COMMAND="sonar-scanner -Dsonar.host.url=$URL"

if [ ! -z ${SONAR_TOKEN+x} ]; then
  COMMAND="$COMMAND -Dsonar.login=$SONAR_TOKEN"
fi

if [ ! -z ${SONAR_DEBUG+x} ]; then
  COMMAND="$COMMAND -X"
fi

log_dropped() {
    echo "[WARN] $1 has been ignored, please set '$2' in your 'sonar-project.properties' file."
}

if [ ! -z ${SONAR_PROJECT_KEY+x} ]; then
    log_dropped SONAR_PROJECT_KEY sonar.projectKey
fi

if [ ! -z ${SONAR_PROJECT_VERSION+x} ]; then
    log_dropped SONAR_PROJECT_VERSION sonar.projectVersion
fi

if [ ! -z ${SONAR_GITLAB_PROJECT_ID+x} ]; then
    log_dropped SONAR_GITLAB_PROJECT_ID
fi

if [ ! -z ${SONAR_SOURCES+x} ]; then
    log_dropped SONAR_SOURCES sonar.sources
fi

if [ ! -z ${SONAR_PROFILE+x} ]; then
    log_dropped SONAR_PROFILE sonar.profile
fi

if [ ! -z ${SONAR_LANGUAGE+x} ]; then
    log_dropped SONAR_LANGUAGE sonar.language
fi

if [ ! -z ${SONAR_ENCODING+x} ]; then
    log_dropped SONAR_ENCODING sonar.sourceEncoding
fi

if [ ! -z ${SONAR_BRANCH+x} ]; then
    log_dropped SONAR_BRANCH sonar.branch.name
fi

if [ ! -z ${SONAR_ANALYSIS_MODE+x} ]; then
    log_dropped SONAR_BRANCH sonar.branch.name
fi

$COMMAND $@
