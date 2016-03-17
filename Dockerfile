FROM gliderlabs/alpine:latest

# Openshift labels
# https://docs.openshift.com/enterprise/3.1/creating_images/metadata.html

LABEL io.openshift.tags haproxy,http-https-redirector \
      io.k8s.description This Image just redirect from http to https \
      io.openshift.expose-services 8080/tcp:http


RUN apk add --no-cache --update \
    haproxy \
    && rm -rf /var/cache/apk/*

COPY containerfiles /

EXPOSE 8080/tcp

#USER default

ENTRYPOINT ["/usr/sbin/haproxy"]

CMD ["-f","/etc/haproxy/haproxy.cfg","-db"]
