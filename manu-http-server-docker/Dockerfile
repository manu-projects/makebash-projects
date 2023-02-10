FROM alpine:3.10

RUN apk add --update make nodejs-current npm
RUN addgroup -S node && \
    adduser -S node -G node

USER node

# TODO: usar una variable de entorno para las rutas
WORKDIR /home/user/src/manu-app/public
COPY --chown=node:node ["public/", "./"]

# TODO: usar una variable de entorno para las rutas
WORKDIR /home/user/src/manu-app
COPY --chown=node:node ["Makefile", "Makefile.cfg", "npm.mk", "docker.mk", "./"]

RUN make npm-init

CMD ["make", "npm-run"]