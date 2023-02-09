FROM alpine:3.10

RUN apk add --update make nodejs-current npm
RUN addgroup -S node && \
    adduser -S node -G node

USER node

WORKDIR /home/user/src/manu-app

COPY ["public/", "Makefile", "Makefile.cfg", "npm.mk", "docker.mk", "./"]

RUN pwd
RUN ls -la .

RUN make npm-init

COPY . .

CMD ["make", "npm-run"]