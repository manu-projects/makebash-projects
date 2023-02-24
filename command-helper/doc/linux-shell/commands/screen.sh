## Multiplexor de terminales (crear multiples instancias de terminal en una sesión)

# crear una sesión con nombre
screen -S nombre

# listar sesiones
screen -ls

# vincular una sesión (por nombre ó id) a la terminal actual
screen -r nombre

# cerrar una sesión
screen -X -S nombre quit
