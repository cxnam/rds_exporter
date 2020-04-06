FROM golang:1.13.9-alpine as builder
WORKDIR /go/src/github.com/cxnam/rds_exporter/
COPY . /go/src/github.com/cxnam/rds_exporter/
RUN go build -o ./dist/rds_exporter

FROM alpine:3.11.5
RUN apk add --update ca-certificates

WORKDIR /app
COPY --from=builder go/src/g.ghn.vn/station/eros/dist/eros .
EXPOSE 9042
ENTRYPOINT ["./rds_exporter", "--config.file=./config.yml"]
