CURRENT_DISPLAY_MANAGER=$(shell cat /etc/X11/default-display-manager | xargs basename)

install-gdm3:
	@sudo aptitude install gdm3

install-lightdm:
	@sudo aptitude install lightdm

# TODO: validar https://github.com/fairyglade/ly
install-lydm:
	@cd /tmp \
	&& git clone --recurse-submodules https://github.com/fairyglade/ly \
	&& cd ly \
	&& make && make install

install-sddm:
	@sudo aptitude install sddm

# TODO: refactor
# TODO: agregar un popup de confirmar
# gdm: gnome display manager
# lightdm: es el que utilizamos actualmente
disable-display-manager:
# usar whiptail
	$(info Al desactivar el Display Manager desaparerá la Interfáz Gráfica, está seguro?)
# usar boxes
	$(info Presione el atajo Ctrl+Alt+F1 para acceder a la Consola Virtual)
	$(info Para ejecutar el X Session Script ejecutar el comando`startx`)
	sleep 5 \
	&& /etc/init.d/$(CURRENT_DISPLAY_MANAGER) stop
