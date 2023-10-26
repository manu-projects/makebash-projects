# opciones
# -l (listen)
# -v (verbose)
# -p (port)
# -k (password, passphrase)
#
# TODO: utilizar `pass` para utilizar claves guardadas de forma segura
cryptcat-start-server:
	cryptcat \
	-k $(CRYPTCAT_PASSWORD) \
	-lvp $(CRYPTCAT_IP) $(CRYPTCAT_PORT)
#	cryptcat -l -p $(CRYPTCAT_PORT)

cryptcat-connect-server:
	cryptcat \
	-v -k $(CRYPTCAT_PASSWORD) \
	$(CRYPTCAT_IP) $(CRYPTCAT_PORT)
