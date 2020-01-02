#!/bin/bash

./check-prereqs.sh
RESULT=$?
if [ $RESULT -ne 0 ]; then
  exit 1
fi

# zip the bundle
zip -r websockets.zip apiproxy
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to zip bundle"
  exit 1
fi

set echo on

# import the api proxy bundle
apigeecli apis create -o $1 -n websockets -p websockets.zip -a $3
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to import api proxy bundle"
  exit 1
fi

# deploy the api proxy
apigeecli apis deploy -o $1 -e $2 -n oauth-sharedflow -r 1
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to deploy api proxy"
  exit 1
fi

# create an api product
apigeecli products create -o $1 -f auto -n websocket_product -m "Websockets Product" -e $2 -p websockets -d "A sample products for websockets"
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to create an api product"
  exit 1
fi

# create a developer
apigeecli developers create -o $1 -n websocket-dev@sample.com -u websocket-dev -f sample -s user
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to create developer"
  exit 1
fi

# create a sample app
apigeecli apps create -o $1 -n websocket-app -p websocket_product -e websocket-dev@sample.com
RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "failed to create developer app"
  exit 1
fi
