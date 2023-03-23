PWD=$(shell pwd)
COPY=rsync -avz
RM=rm -rf
MKDIR=mkdir -p

BOX_CONFIRM_CLEAN=whiptail --title "Eliminar archivos directorio padre" \
									--yesno "Está seguro de confirmar la acción?" 0 0 \
									--no-button "Cancelar" --yes-button "Confirmar"

# - el $? NO es una macro de GNU Make, es propio de linux y guarda el Estado de Salida luego de ejecutar un comando de linux (programas)
EXIT_STATUS=$(shell echo $$?)

# - el valor 0 indíca que el comando de linux se ejecutó con éxito
# (se le pasaron opciones que posee, parámetros válidos como rutas, ...)
EXIT_STATUS_SUCCESS=0

