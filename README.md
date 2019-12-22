# websocket-sample

This sample is sample is meant to demonstrate websockets with Apigee hybrid.

## Server

A sample websocket sample is included which responds with `hello`. To install the server, 

### Server Prequisites

* go 1.12 or higher
* docker
* kubectl (to deploy to kubernetes)

### Server deploy steps

1. Build the [docker image](./server/Dockerfile)
2. Deploy to a container register
3. Modify the kubernetes [manifest](./server/websockets.yaml)
4. Deploy the server `kubectl apply -f websockets.yaml`

## Client

A sample websocket sample is included which takes an input from the user and sends it to the server. 

### Client Prequisites

* go 1.12 or higher

### Client deploy steps

1. [./build.sh](./client/build.sh)

## API Proxy

An API Proxy is included which verifies an API Key before allowing the websocket connection.  

* Apigee hybrid runtime
* GKE 1.13.x

## Test

Input:

```bash

export API_KEY=xxx
export ENDPOINT=example.com
#use this flag to use ws:// vs. wss://  ; default is false
export TLS=false

./websocket-client
```

Output:

```bash

2019/12/21 21:27:12 connecting to ws://example.com/v1/ws?apikey=xxx
2019/12/21 21:27:13 recv: Replying to: '2019-12-21 21:27:13.403018 -0800 PST m=+1.010449853' with 'hello'
2019/12/21 21:27:14 recv: Replying to: '2019-12-21 21:27:14.400193 -0800 PST m=+2.007614408' with 'hello'
2019/12/21 21:27:15 recv: Replying to: '2019-12-21 21:27:15.403358 -0800 PST m=+3.010769896' with 'hello'
2019/12/21 21:27:16 recv: Replying to: '2019-12-21 21:27:16.400729 -0800 PST m=+4.008131894' with 'hello'
```
