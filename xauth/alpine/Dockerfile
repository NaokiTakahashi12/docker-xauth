
FROM alpine

RUN apk update \
    && apk add --no-cache \
        xauth

ENTRYPOINT [ \
    "sh", \
    "-c", \
    " \
        xauth nlist $DISPLAYs | \
        sed -e 's/^..../ffff/' | \
        xauth -f /tmp/.docker.xauth nmerge - \
    " \
]

