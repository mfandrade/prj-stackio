FROM    golang:1.22-alpine AS builder
WORKDIR /go/src/dockerize
COPY    webserver webserver
COPY    webserver.go webserver.go
RUN go mod init dockerize && go mod tidy && \
    CGO_ENABLED=0 go build -o /go/bin/webserver

FROM    alpine:3
COPY    --from=builder /go/bin/webserver /bin/webserver
COPY    entrypoint.sh /bin/entrypoint.sh
RUN ln -s /dev/stdout /log.txt && \
    chmod a+x /bin/entrypoint.sh
WORKDIR /srv/app
COPY    --chown=guest src .
USER    guest
ENTRYPOINT [ "/bin/entrypoint.sh" ]
EXPOSE  8080

# HEALTHCHECK CMD wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1
