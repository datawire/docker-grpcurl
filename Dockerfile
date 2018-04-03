FROM golang:1.10-alpine3.7
MAINTAINER Datawire <dev@datawire.io>
LABEL PROJECT_REPO_URL         = "git@github.com:datawire/docker-grpcurl.git" \
      PROJECT_REPO_BROWSER_URL = "https://github.com/datawire/docker-grpcurl" \
      DESCRIPTION              = "Grpcurl in Docker" \
      VENDOR                   = "Datawire, Inc." \
      VENDOR_URL               = "https://datawire.io/"

ENV GOSU_VERSION=1.10
ENV KUBECTL_VERSION=v1.8.10

RUN apk --no-cache add ca-certificates \
  && apk --no-cache add --virtual build-dependencies curl git \
  && curl -O --location --silent --show-error https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 \
  && mv gosu-amd64 /usr/local/bin/gosu \
  && chmod +x /usr/local/bin/gosu \
  && go get -u github.com/fullstorydev/grpcurl \
  && go install github.com/fullstorydev/grpcurl/... \
  && grpcurl --help \
  && apk del --purge build-dependencies

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
