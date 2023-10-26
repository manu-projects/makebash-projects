include $(MODULE_SECURE_SHELL)/config.cfg
include $(MODULE_SECURE_SHELL)/utils/*.mk
include $(MODULE_SECURE_SHELL)/*.mk
#include $(MODULE_SECURE_SHELL)/ssh-client.mk
#include $(MODULE_SECURE_SHELL)/ssh-agent.mk
#include $(MODULE_SECURE_SHELL)/ssh-github.mk
#include $(MODULE_SECURE_SHELL)/doc.mk

ssh-install-packages: install-ssh-server

install-ssh-server: ##
	sudo aptitude install openssh-server
