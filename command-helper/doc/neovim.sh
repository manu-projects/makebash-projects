# Desactivar las palabras resaltadas hasta la próxima búsqueda
:noh

# Mostrar número de linea
:setnumber

# Buscar/Reemplazar en la misma linea que el cursor
.s/cadena/nueva/g

# Buscar/Reemplazar globalmente pero pide confirmación al reemplazar
s/cadena/nueva/gc

## Atajos Simples
#
# k,j,h,l	up,down,left,right
# r+nuevoCaracter	Sustituir el caracter donde esté el cursor
# f+caracterABuscar	Buscar caracter desde el cursor hasta fin de linea
# F+caracterABuscar	Buscar caracter desde el cursor al principio de linea
#
# gg	Cursor al principio del archivo
# G	Cursor al fin del archivo
# w	Avanzar a la siguiente palabra
# b	Retroceder a la anterior palabra
# 0	Cursor al principio de linea
# $	Cursor al fin de linea
# i	Editar en donde esté el cursor
# a	Editar un caracter adelante al cursor
# I	Editar en el primer caracter de la linea
# A	Editar al fin de linea

## Atajos Extra
#
# v+$	Seleccionar texto hasta fin de linea
# v+^	Seleccionar texto hasta el principio de linea
# v+%	Seleccionar texto hasta donde balancee alguno de los operadores (,{, [
# 5i* Repetir 5 veces el escribir el símbolo asterisco (util para separar textos)
