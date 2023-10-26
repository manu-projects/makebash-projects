# TODO: refactor, include genérico para todos los módulos
include modules.cfg
include desktop-environment/Makefile
include security-network/Makefile
include secure-shell/Makefile
include disk-devices/Makefile
include grub-boot/Makefile
include shells-terminal-emulators/Makefile

include $(MODULE_CRYPTO)/Makefile

# TODO. validar si se puede generalizar más
include $(MODULE_APPS_CLI)/*/Makefile
include $(MODULE_APPS_TUI)/*/Makefile
include $(MODULE_APPS_GUI)/*/Makefile

include $(UTILS)/Makefile

.DEFAULT_GOAL=help
