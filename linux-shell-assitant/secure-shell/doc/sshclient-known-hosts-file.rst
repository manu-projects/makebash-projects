=======================================
Configuración desde el lado del Cliente
=======================================
Utilizamos a github como ejemplo para explicar utilizar el **Listado de Hosts conocidos**

Conexión SSH con Github
=======================
1. Agregar nuestra **Clave Pública de SSH** en https://github.com/settings/ssh/new
2. Agregar en la lista de Hosts Conocidos de nuestro sistema la Clave Pública (la que subimos a github)

   - ejecutar desde la linea de comandos ``ssh-keyscan -H -t ed25519 github.com >> /home/nombre-de-usuario/.ssh/known_hosts``

3. (opcional) Si ya teníamos agregada la Clave Pública en ``/home/nombre-de-usuario/.ssh/known_hosts``

   - **hashear el nombre del Host** para proteger la privacidad
   - ejecutar desde la linea de comandos ``ssh-keygen -H -f /home/nombre-de-usuario/.ssh/known_hosts``

4. Comprobar la conexión SSH entre nuestra maquina (cliente) y github (servidor)

   - ejecutar desde la linea de comandos ``ssh -vT git@github.com``

ssh-keyscan
-----------
- programa que escanéa todas las **Claves Públicas de SSH** de un Servidor SSH
- opción ``-t``, elegimos el **tipo de algoritmo de clave pública** que queremos buscar (Ej. rsa, ed25519, ..)
- opción ``-H``, **hashea el nombre del Host** cuando nos devuelve las **claves públicas** de ese Host

Listado de Hosts conocidos
---------------------------
- archivo regular ``/home/nombre-de-usuario/.ssh/known_hosts`` **del lado del Cliente** y hace de **base de datos**

  - contiene los **(fpr) fingerprint** de las **claves públicas** de los **servidores remotos** a los que nos conectamos nosotros como Clientes
  - por defecto en texto plano (sin cifrar, clear text) que representa un RIESGO, porque pueden conocer a cuales Hosts nos conectamos
  - podemos **cifrar el nombre de los hosts** (en realidad generamos un Hash del nombre)

- el Cliente SSH, sólo confiará en esas conexiones SSH (Ej. nos permitirá clonar un repositorio de github, hacer un pull/push en github, ..)
- el Cliente SSH, desconfiará en cada 1º conexión con un Servidor SSH que NO esté incluido en ésta lista
- el Cliente SSH, en cada 1º conexión **preguntará de forma interactiva con si/no**, si queremos agregarlo a la lista

  - si elegimos "si" entonces NO volverá a preguntar la próxima vez que nos conectemos a ese Host
  - si elegimos "no", entonces NO se conectará (aclaramos para no creer que se agrega a una blacklist**

Columnas del Listado de Hosts conocidos
----------------------------------------
Cada columna está delimitada/separada por un espacio

1. Primera columna, identifica el nombre del Host (Ej. github.com)
2. Segunda columna, el tipo del Par de Claves del Host (Ej. ssh-rsa, ssh-ed25519)
3. Tercer columna, el valor de la Clave Pública del Host (Ej. ABAAC3NzaC1lC3I1NTE5BBBBIOMzzncVzrm23dG6UMoqKLczsgH5C9okWi0dh2l8GKJl)
4. Cuarta columna, un comentario (es opcional)

Ejemplos de un Host conocido (los valores pueden variar, los acortamos para facilitar la lectura)

1. por default, con el nombre de host sin hashear: ``github.com ssh-ed25519 ABAAC3NzaC1lC3I1NTE5BBBBIOMzznc``
2. si queremos privacidad, con el nombre del host hasheado: ``|1|ubZjkle2nLmqF2LSZio=|Mno0/GVUTM= ssh-ed25519 ABAAC3NzaC1lC3I1NTE5BBBBIOMzznc``

(recomendado) Proteger el Listado de Hosts conocidos
----------------------------------------------------
- agregamos protección al **hashear los nombres de los Hosts** de ``/home/nombre-de-usuario/.ssh/known_hosts``
- agregamos la opción ``HashKnownHosts yes`` para que sea obligatorio el nombre de los host como hash

  - en ``/home/nombre-de-usuario/.ssh/config`` si tenemos/utilizamos sólo un usuario
  - en ``/etc/ssh/ssh_config`` si tenemos/utilizamos varios usuarios en el mismo sistema

- si ya teníamos hosts agregados, ejecutar desde la linea de comandos ``ssh-keygen -H -f /home/nombre-de-usuario/.ssh/known_hosts``
- si agregamos un nuevo Host, ejecutar desde la linea de comandos ``ssh-keyscan -H -t ed25519 github.com >> /home/nombre-de-usuario/.ssh/known_hosts``

  - reemplazar ``ed25519`` por el algoritmo de clave pública utilizado
  - reemplazar ``github.com`` por otro dominio ó IP del Servidor SSH que queramos conectarnos

Archivos de Configuración
-------------------------
- información detallada sobre las opciones ejecutar ``man ssh_config``
- el OpenSSH del lado del Cliente sobreescribe las opciones, utilizando éste orden de prioridad

  1. la linea de comandos (mayor prioridad para sobreescribir opciones)
  2. ``/home/nombre-de-usuario/.ssh/config`` (de un usuario específico del sistema)
  3. ``/etc/ssh/ssh_config`` (menor prioridad para sobreescribir opciones, para todos los usuarios del sistema, /etc requiere permisos de superusuario)

