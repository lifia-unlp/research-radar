FROM ghcr.io/ba-st/pharo-loader:v11.0.0 AS loader
ADD install.st /opt/pharo
RUN ./pharo ./Pharo.image --save --quit st ./install.st

# Stage providing BusyBox + musl loader
FROM alpine:3.20 AS bb

FROM ghcr.io/ba-st/pharo:v11.0.0

# Copy BusyBox and its only runtime dep (musl loader)
COPY --from=bb /bin/busybox /bin/wget
COPY --from=bb /lib/ld-musl-*.so.1 /lib/

COPY --from=loader /opt/pharo/Pharo.image /opt/pharo
COPY --from=loader /opt/pharo/Pharo.changes /opt/pharo
COPY --from=loader /opt/pharo/Pharo*.sources /opt/pharo
ADD run.st /opt/pharo

EXPOSE 8080
ENTRYPOINT ["/opt/pharo/pharo", "/opt/pharo/Pharo.image", "--no-quit", "st", "/opt/pharo/run.st" ] 