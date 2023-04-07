ASK_DIR=read -p "Escriba la ruta absoluta: "
ASK_USER_NAME=read -p "Escriba el nombre del usuario (Ej. root, jelou, ..):"

ASK_DEVICE_NAME=read -p "Escriba el nombre del dispositivo (Ej. sda, sda1, sda2, .., sdb, sdb1, ..): "
ASK_DEVICE_TYPE=read -p "Escriba el tipo de dispositivo (Ej. ext3, ext4, fat32, ntfs, ..): "
ASK_DEVICE_MOUNTPOINT=read -p "Escriba punto de montaje (Ej. /mnt/debian, /mnt/win10, /mnt/storage, ..): "
ASK_DEVICE_PERMISSIONS=read -p "Escriba los permisos ro ó rw (ro: read-only, rw: read-write): "

# - refiere a todo un disco duro, y el nombre del dispositivo puede variar entre /dev/sda y /dev/sdb
# - /dev/sda refiere al 1º disco duro detectado
# - /dev/sdb refiere al 2º disco duro detectado
DEVICE_HARD_DISK=/dev/sda

# TODO: comandos a evaluar cfdisk, mkfs, partx, sfdisk, addpart, delpart, partprobe, fsck

##@ Disk Partition (create/edit)

# partition-table-create: ##
# 	echo creando..

# partition-create: ##
# 	echo creando..

# partition-create-EFI:
# 	echo creando..

##@ Disk Partition (copy info)

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

##@ Disk Partition (show info)

# TODO: decidir si elegir por config entre `fdisk` ó `parted`	(Ej. sudo parted --list /dev/sda)
partition-tables-list: ## listar las tablas de partición y sus particiones (nombre, tamaño, tipo formato)
	sudo fdisk --list

partition-table-by-device-name: ##
	$(ASK_DEVICE_NAME) DEVICE_NAME \
	&& sudo fdisk --list /dev/$${DEVICE_NAME}

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
