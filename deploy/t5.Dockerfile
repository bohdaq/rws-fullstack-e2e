# Build-on-push test with a release command (kube-dc app jobs tranche 2).
FROM busybox:1.36
ARG BUILD_ID=unset
RUN mkdir -p /www && echo "build=$BUILD_ID" > /www/index.html && echo "$BUILD_ID" > /build-id
EXPOSE 8080
CMD ["httpd", "-f", "-p", "8080", "-h", "/www"]
