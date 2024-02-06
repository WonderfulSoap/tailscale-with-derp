# tailscale-with-derp
a tailscale docker image with derp server. It will auto get newest tailscale version, and build docker image in 00:00 every day.

https://hub.docker.com/r/wondersoap/tailscale-with-derp

```Dockerfile
FROM golang:alpine AS build-env

ARG LATEST_VERSION

RUN go install tailscale.com/cmd/derper@${LATEST_VERSION}

FROM tailscale/tailscale
COPY --from=build-env $HOME/go/bin/derper /usr/local/bin/derper
```

