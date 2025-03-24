FROM alpine
COPY rootfs /
RUN apk add --update --no-cache python3 py3-pip \
    && wget https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64-installer -O /tmp/s6-overlay-installer \
    && chmod +x /tmp/s6-overlay-installer \
    && /tmp/s6-overlay-installer / \
    && cd /app \
    && pip3 install -r requirements.txt \
    && rm -rf /root/.cache /var/cache/apk/* /tmp/* 
EXPOSE 5000
ENTRYPOINT ["/init"]
