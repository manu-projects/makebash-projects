install-grub-efi:
	sudo aptitude install grub-efi

install-emulator-grub:
	sudo aptitude install grub-emu

# TODO: avisar con whiptail que puede trabarse y debas matarlo con kill-emulator-grub
# TODO: avisar con whiptail que los inputs NO los recibe la ventana con la interfáz gráfica,
# los inputs los recibe la terminal dónde se ejecutó el comando (es medio raro, si)
run-emulator-grub:
	grub-emu

# en caso de no poder matar el proceso de forma manual
kill-emulator-grub:
	pkill -9 grub-emu

# comando grub-install
# - opción (--target): elegir la plataforma (Ej. x86_64-efi, i386-efi, i386-emu, ..)
#
# - opción (--boot-directory): dónde se copiará la imagen de GRUB, por defecto es /boot quedando /boot/grub
#
# - opción (--efi-directory): ruta raíz de la Sistema de Partición EFI
#
# - opción (--removable): si el dispositivo que utilizamos para la instalación es removible (Ej. usb)
#
# - opción (--recheck): -

# Nota: deberiamos activar el modo UEFI en la BIOS (reemplaza al Modo BIOS Legacy) previo a poder crear la partición EFI
grub-install-efi:
	grub-install \
	--target=x86_64-efi \
	--efi-directory=/boot/efi \
	--boot-directory=/boot \
	--removable --recheck
