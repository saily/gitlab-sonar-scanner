gitlab-sonar-scanner
====================

> This is a fork with `Typescript` support

[![pulls][docker hub svg]][docker hub]

Container to be used with Typescript based repositories and SonarQube >= `8.1`.
[sonar-scanner](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)
ships an embedded JRE so image is now based on `node:lts-slim`.

- [latest](https://github.com/saily/gitlab-sonar-scanner/blob/master/Dockerfile)

Using it in your gitlab projects
--------------------------------

Add the next stage to your `.gitlab-ci.yml`.

~~~yaml
stages:
- analysis

sonarqube:
  stage: analysis
  image: widerin/gitlab-sonar-scanner:latest
  variables:
    SONAR_URL: http://your.sonarqube.server
  before_script:
    - sonar-scanner --version
  script:
    - sonar-scanner
      -Dsonar.login="${SONAR_LOGIN}"
      -Dsonar.host.url="${SONAR_URL}"
      -Dsonar.branch.name=${CI_COMMIT_REF_NAME}
      -Dsonar.projectBaseDir="$(pwd)"
      -Dsonar.projectName="${CI_PROJECT_PATH}"
      -Dsonar.projectKey="gitlab-${CI_PROJECT_ID}"
      -Dsonar.projectVersion="$(git describe --tags $(git rev-list --tags --max-count=1))"
~~~

Remember to also create a `sonar-project.properties` file:

~~~conf
sonar.projectKey=your-project-key
sonar.exclusions=node_modules/**,coverage/**

sonar.sources=.
~~~

Before running the analysis stage you should ensure to have the project created
in your sonarqube + having it configured to use the gitlab plugin (specifying the
gitlab repo url).

You also need to give developer permissions to the user that will comment in gitlab.

Environment variables
---------------------

Can be checked in the official documentation: https://docs.sonarqube.org/latest/analysis/analysis-parameters/

- `SONAR_URL`
- `SONAR_TOKEN`
- `SONAR_DEBUG`

Deprecated and ignored environment variables:

- `SONAR_PROJECT_KEY`
- `SONAR_PROJECT_VERSION`
- `SONAR_GITLAB_PROJECT_ID`
- `SONAR_SOURCES`
- `SONAR_PROFILE`
- `SONAR_LANGUAGE`
- `SONAR_ENCODING`
- `SONAR_BRANCH`
- `SONAR_ANALYSIS_MODE`

### Deprecated docker tags

- [ts](https://github.com/saily/gitlab-sonar-scanner/blob/ts/Dockerfile)
- [jdk10](https://github.com/saily/gitlab-sonar-scanner/blob/jdk10/Dockerfile)
- [jdk11](https://github.com/saily/gitlab-sonar-scanner/blob/jdk11/Dockerfile)
- [jdk12](https://github.com/saily/gitlab-sonar-scanner/blob/jdk12/Dockerfile)

LICENSE
=======

All the code contained in this repository is licensed under a GNU-GPLv3 license.

Copyright Alvarium.io 2017-2018.

See [LICENSE][] for more details

[sonar gitlab plugin]: https://github.com/gabrie-allaigre/sonar-gitlab-plugin
[variables]: https://docs.gitlab.com/ce/ci/variables
[docker hub]: https://hub.docker.com/r/widerin/gitlab-sonar-scanner
[LICENSE]: ./LICENSE

[docker hub svg]: https://img.shields.io/docker/pulls/widerin/gitlab-sonar-scanner.svg
