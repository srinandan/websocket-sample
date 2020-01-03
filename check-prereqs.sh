#!/bin/bash

if [ -z "$1" ]
  then
    echo "org name is a mandatory parameter. Usage: 'install-oauth-sharedflow {org} {env} {path-to-service-account.json}'"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "env name is a mandatory parameter. Usage: 'install-oauth-sharedflow {org} {env} {path-to-service-account.json}'"
    exit 1
fi

if [ -z "$3" ]
  then
    echo "service account is a mandatory parameter. Usage: 'install-oauth-sharedflow {org} {env} {path-to-service-account.json}'"
    exit 1
fi

apigeecli 2>&1 >/dev/null
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "this script depends on apigeecli (https://github.com/srinandan/apigeecli)"
  exit 1
fi

zip --help 2>&1 >/dev/null
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "this script depends on the zip utility. Please install zip and re-run the command"
  exit 1
fi

exit 0