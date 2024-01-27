FROM golang:1.21 AS BuildStage

WORKDIR /app

COPY ./metrics-server/ .

RUN go build -o /metrics-server server.go

FROM alpine:latest

COPY --from=BuildStage /metrics-server /metrics-server

USER guest

ENTRYPOINT ["/metrics-server"]
