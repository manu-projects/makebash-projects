FROM pandoc/core

RUN apk add --no-cache make rsync

RUN addgroup -g 1000 -S pandoc && adduser -u 1000 -G pandoc -D pandoc
USER pandoc

WORKDIR /data
COPY export.mk .
COPY functions.mk .
COPY ./docs ./docs
COPY ./src/views ./src/views

# necesario, porque el punto de entrada por defecto de la imagen base es /bin/pandoc
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["make --no-print-directory -f export.mk watch"]