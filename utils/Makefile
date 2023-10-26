include $(UTILS)/*.mk

# TODO: presenta problemas si lo utilizamos dentro de un ifeq de GNU Make
PRINT_OCTAL_PERMISSIONS=stat --format='%a'

WHIPTAIL_REDIRECT_STDERR=2>&1 1>/dev/tty
ECHO_NOTHING=echo -n ""

COPY=rsync --progress

# utilizado en condicionales de bash [[ exp ]] && echo "rama-if" || echo "rama-else"
BASH_CHECK_EMPTY_STRING= -z

COPY_TO_CLIPBOARD=xclip -rmlastnl -selection clipboard

# TODO: sustituir los lugares en que lo utilizamos, por COPY_TO_CLIPBOARD (es más expresivo)
COPY_CLIPBOARD=xclip -rmlastnl -selection clipboard

COLORED_OUTPUT=boxes -a hlvc -d parchment | lolcat --animate --duration=1 --seed=3

NEWT_COLOR_PALETTE_DIALOGS="$(shell cat $(UTILS_CONFIGS)/whiptail-theme-green.cfg)"
WHIPTAIL_COLORED=export NEWT_COLORS=$(NEWT_COLOR_PALETTE_DIALOGS); whiptail

# usamos la opción (--assign) para definir una variable (x) que contenga las comillas dobles
AWK_WHIPTAIL_MENU_COLON_FIELDS=awk \
	--assign x="\"" \
	--field-separator=':' \
	'{print x$$1x, x$$2x}'

AWK_WHIPTAIL_CHECKLIST_COLON_FIELDS=awk \
	--assign x="\"" \
	--field-separator=':' \
	'{print x$$1x, x$$2x " ON"}'

# - el checklist de whiptail devuelve las opciones de la forma "opcion1" "opcion2" ..
# - formateamos la salida de la forma opcion1,opcion2
FORMAT_WHIPTAIL_CHECKLIST_RESULT=\
	tr --delete "\"" \
	| tr " " ","

AWK_WHIPTAIL_MENU_COMMA_FIELDS=awk \
	--assign x="\"" \
	--field-separator=',' \
	'{print $$1x, x$$2x}'

# removemos los comentarios y espacios en blanco
AWK_FORMAT_LST_FILES=sed '/^\# /d' | tr -d ' '

# TODO: encontrar targets que lo necesiten
FUZZY_FINDER=fzf \
	--height 30% \
	--header-lines=2 \
	--layout=reverse

# TODO: encontrar targets que lo necesiten
FIND_FILES_HOME_DIR=find $${HOME} -type f

# Nota:
# - definimos una macro para la "coma" y la usamos dónde invocemos a nuestra función color_box de la forma $(,)
# - en las funciones de GNU Make la coma es el separador de parámetros
# - si usamos la coma común, GNU Make considerará que la función recibirá más parámetros, afectando el comportamiento deseado de nuestra función..
# (alternativas de solución fallidas: el comando sed de GNU, la función subst de GNU Make)
, =,

# comando boxes
# ==============
#
# opciones
# --------
# -d		elegir el diseño a mostrar (Ej. parchment, cat, ..)
# -a		para alinear/posicionar el texto dentro de la caja
# -a hx (alinear horizontalmente) dónde "x" puede ser l (left), c (center), r (right)
# -a vx (alinear verticalmente) dónde "x" puede ser t (top), c (center), b (bottom)
#
# Ej. boxes -a hlvc (alinear horizontalmente hacia la izquierda, alinear verticalmente hacia arriba)
#
# TODO: deprecar, en dónde se utilice reemplazar por color_Box_text
define color_box
	echo -e "Notas:\n" $(1) | boxes -a hlvc -d parchment | lolcat --animate --duration=1 --seed=35
endef

define color_box_text
	echo -e "Notas:\n" $(1) | boxes -a hlvc -d parchment | lolcat --animate --duration=1 --seed=35
endef

# TODO: documentar que el guión (-) en el cat es necesario,
# para que tome el `echo` al principio
# https://stackoverflow.com/questions/3005457/combining-echo-and-cat-on-unix
#
# otras alternativas
#	tail --lines=+1 $(1) | sed -E 's/^==> .*\/(.*) <==$$/\1/g' \
# echo "Notas:" | cat - $(1)
define color_box_notes
	tail --lines=+1 $(1) \
	| sed -E '/^==> .* <==$$/d' \
	| boxes -a hlvc -d parchment \
	| lolcat --animate --duration=1 --seed=3
endef

##@ Utilidades
h help: ## Mostrar menú de ayuda
	@awk 'BEGIN {FS = ":.*##"; printf "\nOpciones para usar:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
