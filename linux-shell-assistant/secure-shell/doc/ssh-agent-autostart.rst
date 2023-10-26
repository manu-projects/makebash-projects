Métodos para iniciar el Agente SSH
==================================

Ejecutar en 2º plano (background) en una Unica Shell
-----------------------------------------------------

Cuando sería útil
*****************
- Es útil si tuvieramos sólo una Shell
- NO es el caso en un **Sistema de Ventanas X** dónde solemos utilizar varias Shell

Si iniciamos el Agente SSH mediante un Shell script
***************************************************
1. lo iniciamos con ``eval $(ssh-agent -s)``, ejecutandose en segundo plano (background)
2. la opción ``-s`` es necesaria, para que devuelva los **comandos con un estilo Bourne-shell (sh)**

Si iniciamos el Agente SSH mediante una terminal (linea de comandos)
********************************************************************
1. lo iniciamos con ``eval $(ssh-agent)``, ejecutandose en segundo plano (background)
2. la opción ``-s`` NO es necesaria, porque el agente SSH detecta el tipo de Login Shell

Variables de Entorno
********************
- los comandos devueltos al iniciar el Agente SSH, creará variables de entorno sólo para esa Shell
- Ej. si creamos desde un Emulador de Terminal otra PTY Slave, ésta tendrá asociada otra Shell pero sin las variables de entorno del Agente SSH)

Ejecutar en 1º plano (foreground) en una Subshell
-------------------------------------------------

Dónde lo iniciariamos
*********************
- Con un Script Shell en un archivo de configuración que se ejecute al iniciar el Sistema (Ej. ``~/.bash_profile``)
- agregar al final del archivo porque supongamos el siguiente escenario

  1. si suspendimos otro proceso (Ej. vim)
  2. al iniciar el agente SSH éste crea una subshell en **primer plano (foreground)**
  3. no podemos reanudar el proceso suspendido hasta finalizar la nueva subshell del Agente SSH

Desventajas
***********
- Si falla el Agente SSH, "podría" provocar que **Login Shell** con la que iniciamos el sistema finalice
- Algunos NO lo recomiendan, porque el sistema podría estar comprometido desde el inicio

Shell script para auto-iniciar el Agente SSH
============================================

en el archivo ~/.bash_profile
-----------------------------
- el script se ejecutará en una **Interactive Login Shell**, es decir una *Shell Interactiva de Inicio de Sesión*
- el **Agente SSH** se ejecutará una sola vez (cuando iniciamos sesión en el sistema)

en el archivo ~/.bashrc
-----------------------
- el script se ejecutará al iniciar una "Interactive Non-Login Shell", es decir una "Shell interactiva sin inicio de sesión"
- una nueva instancia del **Agente SSH** se crearía con cada nueva "terminal" del "emulador de terminal" que utilicemos (Ej. xterm, konsole, ..)

Desventajas entre ~/.bash_profile y ~/.bashrc
---------------------------------------------
- en el ``~/.bashrc``, el script debería controlar que se cree una única instancia del **Agente SSH** (Ej. con condicionales)
- en el ``~/.bash_profile``, si fallara el inicio del **Agente SSH**, también fallaría el inicio de la sesión del Sistema

Ejemplos Tipos de Shell
=======================

Ejemplos de una "interactive login shell"
-----------------------------------------
1. cuando nos conectamos por SSH a un servidor remoto
2. cuando nos logeamos en nuestra maquina local

Ejemplos de una "interactive non-login shell"
---------------------------------------------
1. cuando creamos terminales desde un Emulador de terminal, éstas no requieren iniciar sesión
porque ya lo hicimos al principio al logearnos en nuestra maquina local

Ejemplos de una "non-interactive non-login shell"
-------------------------------------------------
1. cuando ejecutamos un script de bash ó sh (se ejecuta una subshell de éste tipo)
