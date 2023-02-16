FROM alpine:latest

LABEL org.opencontainers.image.authors="andronics@gmail.com" \
    org.opencontainers.image.source="https://github.com/andronics/docker-nordproxy.git" \
    org.opencontainers.image.url="https://github.com/andronics/docker-nordproxy"

COPY app /app

RUN \
    echo "# Installing Packages #" && \
        apk update --no-cache add \
            bash \
            jq \
            openvpn \
            privoxy \
            runit \
            unzip && \
    echo "# Removing Cache #" && \
        rm -rf /var/cache/apk/* && \
    echo "# Chaning Permissions #" && \
        find /app -name run | xargs chmod u+x && \
        find /app -name *.sh | xargs chmod u+x

CMD ["runsvdir", "/app"]