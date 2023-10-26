# Sistemas de Ventanas
## Protocolos de Servidor de Pantalla
- X, X11 (desarrollado en el año 1984)
- MIR (desarrollado por Canonical)
- Wayland (desarrollador en el año 2008)
## X, X11, Sistema de Ventanas X (X Window System)
- protocolo de comunicación entre *aplicaciones cliente* con (GUI) y el *Servidor de Pantalla* X.Org
- utiliza la *arquitectura Cliente-Servidor*
- Sistema Legacy ó heredado (es antiguo y desactualizado pero aún vigente)
- ineficiente en términos de Seguridad (cualquier aplicación ejecutando en segundo plano, puede capturar la actividad de otras ventanas en X11)
## Servidor X.Org (Server Display)
- implementación del *Servidor de Pantalla* del *Sistema de Ventanas X*
- dibuja las ventanas de programas con (GUI) Interfáz de Usuario Gráfica (tamaño, ubicación, ..)
- considerado un Servidor porque
  - *recibe peticiones* para visualizar ventanas de aplicaciones gráficas en la pantalla
  - *recibe eventos* de entrada (Ej. movimientos del mouse, clicks, pulsaciones del teclado)
### Servidor X.Org local
- ejecuta en el mismo ordenador dónde se ejecutan las *aplicaciones Cliente*
### Servidor X.Org remoto
- ejecuta en otro ordenador (físico o virtual) separado de dónde ejecutan las *aplicaciones Cliente*
- conexión remota sugerida a través de un *prótocolo de comunicación segura/cifrada* (Ej. ssh)
## Cliente X
- aplicaciones con (GUI) interfáz de usuario gráfica (emacs, vscode, emulador de terminal, ..)
- se conecta al *Servidor X.Org* a través del *prótocolo de comunicación X11*
  - envía ordenes de visualización
  - envía peticiones de entrada (pulsaciones del teclado, eventos de click del mouse, ..)
### Clientes X especiales TODO
- Window Manager, Desktop Environment, Display Manager (ó login manager)
### Ejecutar aplicaciones (GUI) desde Terminal del Servidor Gráfico X (local)
- *las aplicaciones redireccionan su salida* hacia el *Servidor gráfico X* (local) cuya ip es 127.0.0.1
### Ejecutar aplicaciones (GUI) desde Terminal por SSH
- *las aplicaciones redireccionan su salida* por SSH *hacia el IP de nuestra terminal*
## Gestor de Ventanas (Window Manager)
- *(TWM) Tab Window Manager* es un Window Manager minimalista que consume pocos recursos que provee X.org
- Cliente X especial, suele ser invocado por el *Display Manager* (ó Login Manager)
- le dice al Servidor X en que posición colocar las ventanas
- es un punto intermedio entre el Usuario y el Cliente
## Display Manager (Login Manager)
- *(XDM) X Display Manager* es el Display Manager estándar del Servidor X.Org
- Cliente X especial??? , se ejecuta en el momento de arranque (boot) del sistema
- Autentica a los usuarios y abre una sesión
# Tunel X11 (Redirección de X11)
- *redirige la salida gráfica* del *Sistema de Ventanas X* de un Servidor SSH a un Cliente SSH
## Cliente SSH
- envía los eventos de X11 a
- ejecuta aplicaciones (GUI) con interfáz gráfica en un Servidor SSH (remoto)
- recibe datos (cifrados) del *Servidor Gráfico X* del Servidor SSH (remoto)
### Programas Requeridos TODO <-----------
- instalar/configurar un *Cliente SSH*
- instalar el *Sistema de Ventanas X* para visualizar los datos enviados por el *Servidor Gráfico X* del Servidor SSH (remoto) por SSH
### Configuración
- habilitar en el archivo `/etc/ssh/ssh_config` las opciones
  - ForwardX11 yes
  - ForwardAgent yes
## Servidor SSH
- *redirecciona la salida gráfica de las aplicaciones* hacia el *IP del terminal del Cliente SSH*
  1. ejecuta las aplicaciones que solicita el Cliente SSH
  2. su *Servidor Gráfico X* dibuja las ventanas de las aplicaciones (en vez de nuestro Servidor Gráfico X de nuestra maquina local)
  3. envía los datos de su *Sistema de Ventanas X* al Cliente SSH
### Programas Requeridos
- instalar/configurar un *Servidor SSH*
- instalar el *Sistema de Ventanas X* para utilizar el *Servidor Gráfico X* que *dibuja las ventanas de las aplicaciones gráficas* que se ejecuten
### Configuración
- habilitar en el archivo `/etc/ssh/sshd_config` las opciones
  - X11Forwarding yes
