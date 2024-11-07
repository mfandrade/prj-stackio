FROM    golang:1.22-alpine AS builder
WORKDIR /myapp
COPY    dockerize .
RUN go mod init dockerize && go mod tidy && \
    go build -o webserver
