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
