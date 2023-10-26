(fpr) Fingerprint - Huella digital
==================================

Que es para el Servidor SSH
---------------------------
- identifica al Servidor (hostkey), y la proporciona cada vez que nos conectemos a él
- representa la **huella digital** de su (host public key) **Clave PÚBLICA** generada mediante una **función de hash**
- si llegara a cambiar, entonces nuestro Cliente SSH nos avisaría que podría ser un RIESGO conectarnos a él

Que es para el Cliente SSH
--------------------------
- lo persiste en ``~/.ssh/known_hosts`` luego que acepte la conexión por primera vez
- permanece en la **base de datos** de **hosts conocidos** en el archivo ``~/.ssh/known_hosts``

Como obtenerlo de una Clave Pública existente
---------------------------------------------
- si queremos validar en el cliente ssh, ejecutamos ``ssh-keygen -l -f ~/.ssh/nombredelaclave.pub``
- si queremos validar en el servidor ssh, ejecutamos ``ssh-keygen -l -f /etc/ssh/ssh_host_nombreDelAlgoritmo.pub``

Advertencias sobre el (fpr) fingerprint
=======================================

Cuando el Cliente SSH lanza advertencias
----------------------------------------
- Nos conectamos por primera vez
- Si ya nos habíamos conectado, y luego el Servidor SSH generó otro un Par de Claves
- Si ya nos habíamos conectado, y es un posible Servidor SSH malicioso

Prevenir el ataque man-in-the-middle
------------------------------------
1. nos conectamos a un Servidor SSH (no siendo la primera vez)
2. el **Cliente SSH** imprime por pantalla una ADVERTENCIA de que cambió el (fpr) fingerprint
3. el **Cliente SSH** nos pregunta con si/no, si estamos seguros de establecer la conexión
   4. si es un **servicio en la nube**, contactar con el administrador de sistema
   5. si es un *Servidor SSH de nuestra red**
      1. comparar el (fpr) fingerprint del Servidor SSH, **ejecutamos en él Servidor** ``ssh-keygen -l -f ~/etc/ssh/ssh_host_nombreDelAlgoritmo.pub``
      2. si el (fpr) NO concuerda, borramos todas las Claves de ese host **ejecutando en el Cliente** ``ssh-keygen -f ~/.ssh/known_hosts -R numero-ip-maliciosa``
