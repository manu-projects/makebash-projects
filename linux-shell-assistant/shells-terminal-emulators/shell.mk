CURRENT_SHELL=$(shell echo $${SHELL})
CURRENT_USER=$(shell whoami)

ASK_NAME_SHELL=read -p "Ingrese el nombre la Shell (Ej. bash, fish, zsh, ..): "

DOC_VALID_LOGIN_SHELLS=$(MODULE_TTYSHELL_RESOURCES)/valid-login-shells.lst
DOC_LOGIN_SHELLS=$(MODULE_TTYSHELL_RESOURCES)/interactive-login-shell.txt
DOC_NONLOGIN_SHELLS=$(MODULE_TTYSHELL_RESOURCES)/interactive-non-login-shell.txt
DOC_SHELLSCRIPT=$(MODULE_TTYSHELL_RESOURCES)/noninteractive-nonlogin-shell.txt
DOC_RESTRICTED_SHELLS=$(MODULE_TTYSHELL_RESOURCES)/restricted-shell.txt

##@ Shell (edit)
change-shell: ##
	@$(ASK_NAME_SHELL) NAME_SHELL \
	&& chsh --shell /usr/bin/$${NAME_SHELL} \
	&& $(call color_box, \
		"- utilizamos el comando 'chsh' para esta operación\n" \
		"- cerrar la sesión de Linux para que se aplique éste cambio de Shell" \
	)

##@ Shell (examples)
# Nota: en utils.mk se explica porque utilizamos $(,) en vez de una coma simple en color_box
try-interactive-login-shell: ##
	@bat $(DOC_LOGIN_SHELLS)
	@echo "Ejecutando ejemplo (c), pero el ejemplo (a) sería más común.." \
	&& $(call color_box,\
	"- comprobar si es una Login Shell$(,) con el comando 'shopt login_shell'\n" \
	"- salir de la Shell Interactiva CON inicio de sesión$(,) con el comando 'logout'" \
	) \
	&& ssh $(CURRENT_USER)@127.0.0.1

# Nota: en utils.mk se comenta porque usamos la coma de la forma $(,)
try-interactive-nonlogin-shell: ##
	@bat $(DOC_NONLOGIN_SHELLS)
	@echo "Ejecutando ejemplo (b), pero el ejemplo (a) sería más común.." \
	&& $(call color_box,\
	"- comprobar si es una Login Shell$(,) con el comando 'shopt login_shell'\n" \
	"- salir de la Shell Interactiva SIN inicio$(,) con el comando 'exit'" \
	) \
	&& $(CURRENT_SHELL) -i

# - usamos \ para escapar el - (guión), y el $ para escapar el $ (pesos)
# - devolvemos true para que GNU Make no lance un error
try-noninteractive-nonlogin-shell: ##
	@bat $(DOC_SHELLSCRIPT)
	@echo "Ejecutando ejemplo (a), pero el ejemplo (b) sería más común.."
	@bash -c 'echo $$\-: $$-; shopt login_shell;true'

# TODO: validación para fish no dispone ésta feature
try-restricted-shell: ##
	@bat $(DOC_RESTRICTED_SHELLS)
	@echo "Ejecutando Bash Shell restricta.." \
	&& $(call color_box,"- salir de la Shell Restrictiva$(,) con el comando 'exit'") \
	&& $(CURRENT_SHELL) --restricted

##@ Shell (show info)
print-current-shell: ##
	@echo $(CURRENT_SHELL)

print-valid-login-shells: ##
	@bat $(DOC_VALID_LOGIN_SHELLS)
