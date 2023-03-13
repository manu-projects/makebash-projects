## CATEGORIA: clasificar comando
## DESCRIPCION: describir comando

# Cuadro de diálogo para notificar un mensaje al usuario
#
# - timeout: finaliza el proceso whiptail luego del tiempo indicado (en éste ejemplo 10 segundos)
# - reset: inicializa la terminal, la deja en un estado anterior estable (al finalizar whiptail, la pantalla se bugea y quedará inutilizable)
# - clear: limpia la terminal (no es lo mismo que reset, no resuelve el bug que genera en la pantalla la finalización de whiptail)
timeout 10 whiptail --msgbox "El servidor se apagará en 10 segundos" 10 50;
reset; clear

# Cuadro de diálogo del tipo Aceptar/Cancelar
#
# - son opcionales las opciones --yes-button y --no-button
# - 2>&1 redirecciona STDERR al STDOUT, porque whiptail escribe los resultados en STDERR (fd 2) y muestra la caja de diálogo por STDOUT (fd 1)
# - 1>/dev/tty redirecciona el STDOUT (fd 1) a la terminal activa (en uso), es opcional indicar el fd 1 porque el operador de redirección > lo  utiliza por default
# - $? almacena el Estado de Salida del último comando ejecutado en la terminal (con valor 0 cero si tuvo éxito, distinto de cero si falló)
whiptail --title "Borrar archivos" --yesno "Desea confirmar la acción?" 10 50 --yes-button "Confirmar" --no-button "Cancelar" 2>&1 1>/dev/tty \
    && test $? -eq 0 && echo "Borrando archivos.." || echo "ok, decidiste no borrar los archivos"

# Cuadro de diálogo que solicita escribir datos por STDIN (fd 0, teclado)
#
# - el último parámetro de whiptail con --inputbox es opcional, será el valor por default que sugerirá escribir
# - el operador pipe (|) redirecciona el STDOUT (que escribió whiptail) como STDIN al comando xargs
# - el comando xargs -I %, le define el símbolo % al input que le redireccionado por el operador pipe
# - 3>&1 2>&1 2>&3 tiene mismo objetivo que 2>&1 1>/dev/tty, pero creando un nuevo File Descriptor (3) que referencia al STDOUT (fd 1) y al que redireccionará el STDERR (fd 2)
whiptail --title "Crear usuario" --inputbox "Escriba el nombre de usuario" 10 50 "root" 3>&1 1>&2 2>&3 \
    | xargs -I % echo "Hola %"

# alternativa al whiptail --inputbox (pero sin la interfáz de whiptail)
read -p "Escriba el nombre de usuario que desea crear: " NOMBRE

# Cuadro de diálogo con un menú de opciones
#
# - luego del alto (10) y ancho (50) de la caja de diálogo, indicamos el alto (2) del menú
# - cada opción necesita dos valores de la forma: "nombre" "descripcion"
whiptail --title "Cambiar de Shell" --menu "Seleccione una opción" 10 50 2 \ "Bash" "(Bourne Again Shell)" \ "Zsh" "(Z Shell)" 2>&1 1>/dev/tty \
    | xargs -I % echo "Cambiando a %"


