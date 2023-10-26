include $(MODULE_DISK_DEVICES)/traditional-partition.mk
include $(MODULE_DISK_DEVICES)/logical-volume-manager.mk
include $(MODULE_DISK_DEVICES)/repair-disk.mk
include $(MODULE_DISK_DEVICES)/utils.mk

# - refiere a todo un disco duro, y el nombre del dispositivo puede variar entre /dev/sda y /dev/sdb
# - /dev/sda refiere al 1º disco duro detectado
# - /dev/sdb refiere al 2º disco duro detectado
DEVICE_HARD_DISK=/dev/sda

##@ Disk Devices (copy info)

# comando xclip
# - opción (-rmlastnl): si el último caracter del texto seleccionado es '\n' (salto de linea), entonces lo remueve
# "si NO removemos el salto de linea, al pegar el texto del portapapeles el emulador de terminal lo interpretará como presionar enter"
#
# ALTERNATIVAs a la opción (-rmlastnl) de xclip:
# Ej. ... | tr -d '\n' | xclip -selection clipboard
# Ej. ... | tr -d '\n' | xsel --clipboard
#
copy-uuid-from-block-device: ##
	$(info Se copiará en el clipboard/portapapeles el UUID del nombre de dispositivo)
	$(ASK_DEVICE_NAME) DEVICE_NAME \
	&& lsblk --noheadings --output=UUID /dev/$${DEVICE_NAME} \
	| xclip -rmlastnl -selection clipboard

##@ Disk Devices (doc)
device-types: ##
	@bat $(MODULE_DISK_DEVICES_RESOURCES)/device-types.txt

# comando lsblk
# - opción (--paths): imprime la ruta absoluta de los dispositivo de bloque (Ej. /dev/sda1, /dev/sda2, ..)
# - opción (--output): nombrar las columnas a imprimir de c/dispositivo
#
# comando alternativo (sin usuario root): blkid
block-devices-list: ## listar dispositivos de bloque (label/UUID del dispositivo y de la partición, punto de montaje)
	lsblk \
	--paths \
	--output NAME,FSTYPE,LABEL,PARTLABEL,UUID,PARTUUID,MOUNTPOINT,SIZE

# comando df
# - opción (h): transforma las unidades en un formato más humanizado/entendible (en GB)
# - opción (T): agrega la columna del tipo de filesystem
filesystem-disk-space-usage: ## espacio utilizado "por los filesystem" (tipo, espacio total/utilizado/libre, punto de montaje)
	sudo df -hT

# comando du
# - opción (h): transforma las unidades en un formato más humanizado/entendible (en KB,MB,GB)
# - opción (c): muestra el tamaño total de todos los archivos
# - opción (s): da un resumen de cada directorio, sin listar cada archivo/subdirectorio
# - patrón ruta/*: el asterísco (*) representa todos los archivos que tenga esa ruta
file-space-usage-by-dir: ## espacio utilizado "por un directorio"
	$(ASK_DIR) DIR \
	&& du -hcs $${DIR}/*

# comando mount
# - modo de uso: mount /dev/nombre ruta_de_punto_de_montaje
#
# - opción (-t): tipo del file system (Ej. ext3, ext4, fat32, ntfs, ..)
#
mount-block-device: ## Montar un filesystem
	$(ASK_DEVICE_TYPE) DEVICE_TYPE \
	&& $(ASK_DEVICE_NAME) DEVICE_NAME \
	&& $(ASK_DEVICE_MOUNTPOINT) DEVICE_MOUNTPOINT \
	sudo mount -t $${DEVICE_TYPE} /dev/$${DEVICE_NAME} $${DEVICE_MOUNTPOINT}

# comando mount
# - opción (-options): agregamos flags
mount-block-device-advanced: ## Montar un filesystem + asignación de usuario y permisos
	$(ASK_DEVICE_TYPE) DEVICE_TYPE \
	&& $(ASK_DEVICE_NAME) DEVICE_NAME \
	&& $(ASK_DEVICE_MOUNTPOINT) DEVICE_MOUNTPOINT \
	&& $(ASK_USER_NAME) USER_NAME \
	&& $(ASK_DEVICE_PERMISSIONS) DEVICE_PERMISSIONS \
	&& sudo mount \
		-t $${DEVICE_TYPE} \
		--options $${DEVICE_PERMISSIONS},user,uid=`id --user $${USER_NAME}` \
		/dev/$${DEVICE_NAME} $${DEVICE_MOUNTPOINT}
