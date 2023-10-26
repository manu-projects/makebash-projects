ECHO_NOTHING=echo -n ""

# - el $? NO es una macro de GNU Make, es propio de linux y guarda el Estado de Salida luego de ejecutar un comando de linux (programas)
EXIT_STATUS= $$?

# - el valor 0 indíca que el comando de linux se ejecutó con éxito
# (se le pasaron opciones que posee, parámetros válidos como rutas, ...)
EXIT_STATUS_SUCCESS=0

# lo utilizamos en condicionales de la forma.. [[ $(CHECK_EXIT_STATUS) ]]
CHECK_EXIT_STATUS=$(EXIT_STATUS) -eq $(EXIT_STATUS_SUCCESS)
