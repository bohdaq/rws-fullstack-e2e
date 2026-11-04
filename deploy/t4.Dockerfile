# Build-on-push test (kube-dc T4): a build argument, a build secret and a
# runtime secret; the page shows only short hashes, never a value.
FROM busybox:1.36
ARG GREETING=unset
RUN --mount=type=secret,id=password mkdir -p /www \
 && echo "greeting=$GREETING" > /www/index.html \
 && if [ -f /run/secrets/password ]; then echo "build-secret=$(sha256sum /run/secrets/password | cut -c1-8)" >> /www/index.html; \
    else echo "build-secret=absent" >> /www/index.html; fi
EXPOSE 8080
CMD ["sh", "-c", "mkdir -p /tmp/www && cp /www/index.html /tmp/www/ && echo \"runtime-secret=$(printf %s \"$APP_KEY\" | sha256sum | cut -c1-8)\" >> /tmp/www/index.html && exec httpd -f -p 8080 -h /tmp/www"]
