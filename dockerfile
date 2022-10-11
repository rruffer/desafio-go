FROM golang:1.16-alpine as builder

RUN apk update && apk add --no-cache git

WORKDIR /build

COPY ./src/main.go /build

RUN go mod init build

# RUN go mod download

RUN go get -d -v

ENV GOOS=linux

ENV GOARCH=amd64

# RUN go build -o /go/bin/app
RUN go build -ldflags="-w -s" -o /go/bin/app

FROM scratch

COPY --from=builder /go/bin/app /go/bin/app

ENTRYPOINT ["/go/bin/app"]
