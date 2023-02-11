# TODO: si usamos alpine:3.17 e intentamos correr nodejs arroja /bin/sh: Unknown: not found
FROM alpine:3.10

MAINTAINER neverkas

# Nota: shadow nos permite usar groupadd y useradd que no son propios de alpine
RUN apk add --update shadow make nodejs-current npm

# TODO: utilizar algún archivo .env inyectado en docker-compose ó exportar variables de entorno con Makefile
ARG PUBLIC_HTML=/var/www/public
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=1000

# creamos el usuario
RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

# Nota: otra manera (ó bien como debería ser en alpine linux)
# RUN addgroup -S ${USERNAME} && adduser -S ${USERNAME} -G ${USERNAME}

# Nota: operaciones mkdir, chown en /var/www requieren de usuario root (1000) ó usuario del grupo root (1000)
RUN mkdir -p ${PUBLIC_HTML}

USER node
COPY --chown=node:node ["./public", "${PUBLIC_HTML}"]

WORKDIR /home/user/src/manu-app
COPY --chown=node:node ["Makefile", "Makefile.cfg", "npm.mk", "docker.mk", "./"]

RUN make npm-init
CMD ["make", "npm-run"]