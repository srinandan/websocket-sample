FROM golang:latest as builder
ADD . /go/src/websocket 
WORKDIR /go/src/websocket
COPY . /go/src/websocket
ENV GO111MODULE=on
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/websocket

#without these certificates, we cannot verify the JWT token
FROM alpine:latest as certs
RUN apk --update add ca-certificates

FROM scratch
WORKDIR /
COPY --from=builder /go/bin/websocket .
COPY --from=builder /go/src/websocket/index.html .
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
EXPOSE 3000
CMD ["./websocket"]