#!/bin/sh
# $1: primer parámetro, recibe el tipo de editor (Ej. vim, neovim, nano)
# $2: segundo parámetro, recibe la ruta para editar los comandos del comando en formato .sh
# $3: tercer parámetro, recibe la ruta para editar los shortcuts del comando en formato .org
read -p "Si desea editar los comandos escriba sin los paréntesis (c) y para shortcuts (s): " choice
case "$choice" in
    c ) $1 $2;;
    s ) $1 $3;;
    * ) echo no && exit 1
esac
