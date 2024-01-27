FROM golang:1.21 AS BuildStage

WORKDIR /app

COPY ./metrics-server/ .

RUN go build -o /metrics-server server.go

FROM alpine:latest

RUN apk add --no-cache bash

COPY --from=BuildStage /metrics-server /metrics-server

COPY ./metrics-server/generate-data.sh /generate-data.sh

USER guest

ENTRYPOINT ["/metrics-server"]
