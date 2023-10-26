include $(MODULE_TTYSHELL)/shell.mk
include $(MODULE_TTYSHELL)/tty-emulators.mk

# TODO: solicitar confirmación del cambio, si ya existe la función man() y el export MANPAGER en .bashrc
apply-colors-man-pages:
	cat $(MODULE_TTYSHELL)/configs/colore-man-pages.sh \
	>> $${HOME}/.bashrc
