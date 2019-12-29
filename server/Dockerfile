FROM golang:latest as builder
RUN useradd -U app
ADD . /go/src/websocket 
WORKDIR /go/src/websocket
COPY . /go/src/websocket
ENV GO111MODULE=on
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-w -extldflags "-static"' -o /go/bin/websocket

#without these certificates, we cannot verify the JWT token
FROM alpine:latest as certs
RUN apk --update add ca-certificates

FROM scratch
WORKDIR /
COPY --from=builder /go/bin/websocket .
COPY --from=builder /go/src/websocket/index.html .
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
USER app
EXPOSE 3000
CMD ["./websocket"]