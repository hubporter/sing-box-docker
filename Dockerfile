FROM golang:alpine AS builder

RUN echo '1.1.6' && \
    go install -v -tags with_acme github.com/sagernet/sing-box/cmd/sing-box@latest && \
    go clean -cache -modcache


FROM alpine:latest

RUN apk --no-cache add tzdata

ENV TZ=Asia/Shanghai \
    XDG_DATA_HOME=/opt/sing

WORKDIR ${XDG_DATA_HOME}

COPY --from=builder /go/bin/sing-box /usr/local/bin/sing

ENTRYPOINT [ "sing", "run" ]
