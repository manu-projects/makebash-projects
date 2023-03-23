## CATEGORIA: -
## DESCRIPCION: Ejecuta un comando por un tiempo límite

# ejecutar por 5 segundos, un loop infinito que hace operaciones de escritura
echo -n "" > duplicados.txt && timeout 5 bash -c 'while true; do echo "escribiendo.."; echo "carlos" >> duplicados.txt ; sleep 1; done;'

# ejecutar por 10 segundos el comando ping (verifica el estado de un servidor haciendo ping)
timeout 10s ping localhost

# ejecutar por 1 minuto, el comando top (lista el estado de los procesos del sistema operativo)
timeout 1m top

# ejecutar por 1 hora, el comando tail -f para observar un log
timeout 1h tail -f /var/log/syslog

# por defecto utiliza la unidad de tiempo en segundos
timeout 10 ping localhost

# indicar el nombre de la señal para detener el proceso (por defecto es SIGTERM)
timeout -s SIGKILL 10 ping localhost

# indicar el número de la señal para detener el proceso
# (para conocer el número ejecutar kill -l)
timeout -s 9 10 ping localhost

# manera más sencilla de mandar la señal SIGKILL
timeout --kill-after=10 ping localhost
timeout -k 10 ping localhost

