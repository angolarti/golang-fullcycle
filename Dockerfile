FROM golang:1.16.0 AS builder

WORKDIR /go/src/github.com/angolarti/
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app app.go

FROM busybox:stable-uclibc
WORKDIR /usr/srv
COPY --from=builder /go/src/github.com/angolarti/app .
CMD [ "./app" ]