## CATEGORIA: información usuarios del sistema
## DESCRIPCION: mostrar información de los usuarios logeados y que comandos ejecutan
## OBSERVACIONES: Agrupamos los comandos w, who, whoami, users

# Mostrar el nombre de usuario actual (Who am I?)
whoami

# Mostrar información de (who) quienes están logeados
who

# Mostrar que están haciendo los usuarios logeados
# - que comandos están ejecutando (Ej. /bin/bash /bin/sh xfce4-session)
# - muestra métricas del sistema operativo (tiempo activo, tiempo inactivo, ..)
w

# Mostrar información de un usuario específico (Ej. jelou)
# - Cada subshell en ejecución (Ej. pts/0 pts/1 pts/2 ..)
# - Que comando está ejecutando en cada subshell (Ej. /bin/bash xfce4-session ...)
w jelou

# Contar la cantidad de usuarios activos (logeados) y mostrar su nombre de usuario
who --count
who -c

# Imprimir los nombres de usuarios activos (logeados)
users
