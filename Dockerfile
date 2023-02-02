FROM golang:alpine AS build-env

ARG LATEST_VERSION

RUN go install tailscale.com/cmd/derper@${LATEST_VERSION}

FROM tailscale/tailscale
COPY --from=build-env $HOME/go/bin/derper /usr/local/bin/derper