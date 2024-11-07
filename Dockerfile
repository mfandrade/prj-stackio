FROM    golang:1.22-alpine AS builder
WORKDIR /builder
COPY    dockerize .
RUN go mod init dockerize && go mod tidy && \
    go build -o /builder/myapp webserver.go
