#!/usr/bin/env sh

USER_ID=${HOST_USER_ID:-9001}
COMMAND=${COMMAND:-/go/bin/grpcurl}

adduser -s /bin/sh -u ${USER_ID} -D user
export HOME=/home/user

exec /usr/local/bin/gosu user ${COMMAND} "$@"
