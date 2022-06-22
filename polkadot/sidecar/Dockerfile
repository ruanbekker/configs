FROM docker.io/parity/substrate-api-sidecar:v11.3.18
USER root
RUN apk --no-cache add curl
HEALTHCHECK --interval=60s --timeout=5s CMD curl --fail http://localhost:8080/blocks/head || kill 1
USER node
