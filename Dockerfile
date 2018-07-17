FROM busybox

COPY server /server
EXPOSE 80
ENTRYPOINT ["/server/run.sh"]
