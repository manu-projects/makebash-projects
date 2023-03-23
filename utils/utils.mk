CURRENT_DIRECTORY=$(shell pwd)

APP_AUTHOR=neverkas
APP_NAME=command-helper

BASH_ALIAS_SYMBOL= ?
BASH_ALIASES_FILE=~/.bash_aliases

BASH_ALIAS="alias $(BASH_ALIAS_SYMBOL)='make --no-print-directory -C $(CURRENT_DIRECTORY)' \
	CURRENT_TTY_PATH=$$(pwd) \
	APP_AUTHOR=$(APP_AUTHOR)"

# alias ?='make --no-print-directory -C /home/jelou/Documents/git/manu-makefiles/command-helper CURRENT_TTY_PATH=$(pwd)'
BASH_ALIAS_ESCAPE_SLASH=$(subst /,\/,$(BASH_ALIAS))

POPUP_EDIT = sh ./scripts/edit-popup.sh $(TEXT_EDITOR)

APP_INSTALLED=$(shell grep -q "^alias ?='make.*APP_AUTHOR=neverkas" ~/.bash_aliases && echo true)
