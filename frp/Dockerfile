FROM alpine

ENV LANG C.UTF-8
ENV TZ=Asia/Shanghai
ENV FRP_VERSION 0.39.0

RUN apk add --update --no-cache curl tzdata bash \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && curl -L -o frp.tar.gz https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -xf frp.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64/ /opt/frp \
    && rm -rf frp.tar.gz /tmp/* /var/cache/apk/*

WORKDIR /opt/frp

CMD ["./frps","-c","/opt/frp/frps.ini"]