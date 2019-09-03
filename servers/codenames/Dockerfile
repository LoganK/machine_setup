FROM golang:stretch as builder

WORKDIR $GOPATH/src

RUN git clone https://github.com/jbowens/codenames

RUN go get -d -v \
  github.com/jbowens/codenames/cmd/codenames

# Uncomment during development
COPY codenames github.com/jbowens/codenames

# Disable CGO_ENABLED to force a totally static compile.
RUN CGO_ENABLED=0 GOOS=linux go install -v \
  github.com/jbowens/codenames/cmd/codenames


FROM alpine:latest

WORKDIR /app
EXPOSE 80

#RUN apk --no-cache add ffmpeg

# Handle templates for plugins automatically
COPY --from=builder /go/src/github.com/jbowens/codenames/assets/ assets/

COPY --from=builder /go/bin/codenames .

# `exec` allows us to receive shutdown signals.
CMD exec /app/codenames 

