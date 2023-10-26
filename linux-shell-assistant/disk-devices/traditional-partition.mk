# TODO: comandos a evaluar cfdisk, mkfs, partx, sfdisk, addpart, delpart, partprobe, fsck

##@ Tradition Disk Partition (create/edit)

# partition-table-create: ##
# 	echo creando..

# partition-create: ##
# 	echo creando..

# partition-create-EFI:
# 	echo creando..

##@ Disk Partition (doc)
partition-tables-types: ##
	@bat $(MODULE_DISK_DEVICES_RESOURCES)/partition-tables-types.txt

##@ Disk Partition (show system info)
# TODO: decidir si elegir por config entre `fdisk` ó `parted`	(Ej. sudo parted --list /dev/sda)
partition-tables-list: ## listar las tablas de partición y sus particiones (nombre, tamaño, tipo formato)
	sudo fdisk --list

partition-table-by-device-name: ##
	$(ASK_DEVICE_NAME) DEVICE_NAME \
	&& sudo fdisk --list /dev/$${DEVICE_NAME}
