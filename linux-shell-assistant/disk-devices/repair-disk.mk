##@ Repair Disk (actions)

# Observaciones:
# - es necesario desmontar el dispositivo previo a utilizar comandos como `badblocks`

# TODO: boxes que notifique "comando principal" a modo de aprendizaje
#
# comando `badblocks`
# - opción (-s): muestra el progreso en % de los bloques escaneados
# - opción (-n): las operaciones de prueba lectura/escritura serán NO-destructivas (no borrará contenido del dispositivo)
# - opción (-o): redirecciona a un archivo el resultado de la lista de bloques dañados a un archivo en vez de (STDOUT)
#
# - opción (-f): NO SE RECOMIENDA (puede dañar el filesystem)
check-bad-blocks: ##
	$(info Comando principal utilizado `badblocks`)
	@$(ASK_DEVICE_NAME) DEVICE_NAME \
	&& sudo badblocks \
		-o $(MODULE_DISK_DEVICES_RESOURCES)/logs/log.txt \
		-nvs /dev/$${DEVICE_NAME}

# comando `badblock`
# - opción (-w): las operaciones serán destructivas
# - opción (-v): activa el modo verboso, detallando la cantidad de errores
#
# - opción (-n) y (-w): NO se pueden combinar, son mutuamente exclusivas
repair-bad-blocks: ##
	$(info Comando principal utilizado `badblocks`)
	$(warning Esta operación podría eliminar datos del dispositivo, se recomienda hacer un respaldo)
	@$(ASK_DEVICE_NAME) DEVICE_NAME \
	&& sudo badblocks -wvs /dev/$${DEVICE_NAME}
