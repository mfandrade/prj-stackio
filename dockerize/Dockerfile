FROM    golang:1.22-alpine AS builder
WORKDIR /go/src
COPY    webserver .
COPY    webserver.go .
RUN go mod init webserver && go mod tidy && \
    go build -o /go/bin/webserver
