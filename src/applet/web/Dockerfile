# https://www.cnblogs.com/davygeek/p/6524317.html
# docker configuration
FROM scratch
MAINTAINER none "none@none"

COPY ./app /app/
COPY ./res/ /app/res/
COPY ./public/ /app/public/

# TODO: /app/etc为只读卷
# TODO: /app/var为可变更卷
VOLUME ["/app/etc","/app/var"]

ENV PJ_ROOT=/app \
    GIN_MODE=release
WORKDIR /app/
CMD ["./app"]

