FROM    golang:1.22-alpine AS builder
WORKDIR /go/src
COPY    webserver .
COPY    webserver.go .
RUN go mod init webserver && go mod tidy && \
    go build -o /go/bin/webserver

FROM    alpine:3
COPY    --from=builder /go/bin/webserver /bin/webserver
RUN ln -s /dev/stdout /log.txt
WORKDIR /srv/myapp
COPY    --chown=guest src .
CMD [ "/bin/webserver" ]
EXPOSE 8080
