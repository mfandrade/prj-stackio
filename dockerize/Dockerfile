FROM    golang:1.22-alpine AS builder
WORKDIR /go/src/dockerize
COPY    webserver ./webserver
COPY    webserver.go ./webserver.go
RUN go mod init dockerize && go mod tidy && \
    CGO_ENABLED=0 go build -o /go/bin/webserver

FROM    alpine:3
COPY    --from=builder /go/bin/webserver /bin/webserver
RUN ln -s /dev/stdout /log.txt
WORKDIR /srv/app
USER    guest
COPY    --chown=guest src ./html
COPY    --chown=guest server.conf ./
COPY    --chown=guest entrypoint.sh ./
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "/bin/webserver"]
EXPOSE  8080

# HEALTHCHECK CMD wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1
