export GO111MODULE=on
go mod download
export CGO_ENABLED=0 
go build -a -ldflags '-w -extldflags "-static"' -o websocket-client