FROM busybox

COPY server /server
COPY www /www
ENV KUBERNETES_PORT_443_TCP=tcp://10.0.0.1:443
ENV APACHE_PORT_80_TCP=tcp://10.0.0.239:80
EXPOSE 80
ENTRYPOINT ["/server/run.sh"]
