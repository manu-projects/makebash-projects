# TODO: documentar solución alternativa
#	printf "expire\n$${GPG_EXPIRATION}\nsave\n" | gpg --batch --pinentry-mode=loopback --command-fd=0 --status-fd=2 --edit-key $${GPG_KEY_ID}
gpg-extend-primary-key-expiration:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_GPG_EXPIRATION_DATE) \
	&& gpg --quick-set-expire $${GPG_PRIVATE_KEY_ID} $${GPG_EXPIRATION_DATE}

gpg-extend-secondary-keys-expiration:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(ASK_GPG_EXPIRATION_DATE) \
	&& gpg --quick-set-expire $${GPG_PRIVATE_KEY_ID} $${GPG_EXPIRATION} \*

gpg-list-public-keys:
	gpg --list-keys --keyid-format 0xLONG --with-keygrip \
	| $(GPG_KEYLIST_SEPARATOR) \
	| $(COLORED_OUTPUT)

# TODO: boxes educativo, comentando que KEYGRIP muestra el nombre del archivo de la Clave privada (maestra y secundaria)
# y estas aparecen en~/.gnupg/private-keys-v1.d
gpg-list-private-keys:
	gpg --list-secret-keys --keyid-format LONG --with-keygrip \
	| $(GPG_KEYLIST_SEPARATOR) \
	| $(COLORED_OUTPUT)

gpg-search-public-key-from-keyserver:
	$(ASK_GPG_UID_EMAIL) \
	&& gpg --batch --search-keys $${GPG_UID_EMAIL} \
	| $(COLORED_OUTPUT)

gpg-show-fingerprint:
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& gpg --fingerprint $${GPG_PUBLIC_KEY_ID}

# TODO: está copiando más de una vez en el clipboard
# TODO: documentar AWK
# https://unix.stackexchange.com/questions/673230/gpg2-get-fingerprint-using-script
# gpg-copy-fingerprint-to-clipboard:
# 	$(ASK_GPG_KEY_ID) GPG_KEY_ID \
# 	&& gpg --with-colons --fingerprint $${ASK_GPG_KEY_ID} \
# 	| awk --field-separator=":" '/^pub:.*/ {getline; print $$10}' \
# 	| $(COPY_CLIPBOARD)

gpg-delete-private-key:
	$(NOTES_GPG_SUGGESTIONS_REVOCATION) \
	&& $(NOTES_GPG_KEY_SUBKEYS_CAPABILITIES) \
	&& $(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& gpg --delete-secret-keys $${GPG_PRIVATE_KEY_ID}

gpg-delete-public-key:
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& gpg --delete-keys $${GPG_PUBLIC_KEY_ID}

gpg-delete-pair-key: gpg-delete-private-key gpg-delete-public-key

gpg-import-public-key:
	$(PRINT_EXAMPLE_KEY_FILES) && $(ASK_GPG_IMPORT_KEY_FILE) \
	&& gpg --import $${GPG_IMPORT_KEY_FILE}

gpg-export-private-key-with-paperkey:
	$(NOTES_GPG_SUGGESTIONS_PRIVATE_KEY) \
	&& $(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(PRINT_EXAMPLE_KEY_FILES) && $(ASK_GPG_EXPORT_KEY_FILE) \
	&& gpg --export-secret-keys $${GPG_PRIVATE_KEY_ID} \
	| paperkey --output=$${GPG_EXPORT_KEY_FILE}

gpg-import-private-key-with-paperkey:
	$(PRINT_EXAMPLE_KEY_FILES) && $(ASK_GPG_IMPORT_PUBLIC_KEY_FILE) && $(ASK_GPG_IMPORT_PRIVATE_KEY_FILE) \
	&& paperkey \
		--pubring $${GPG_IMPORT_PUBLIC_KEY_FILE} \
		--secrets $${GPG_IMPORT_PRIVATE_KEY_FILE} \
	| gpg --import

gpg-export-private-key:
	$(NOTES_GPG_SUGGESTIONS_PRIVATE_KEY) \
	&& $(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(PRINT_EXAMPLE_KEY_FILES) && $(ASK_GPG_EXPORT_KEY_FILE) \
	&& gpg --export-secret-keys $${GPG_PRIVATE_KEY_ID} > $${GPG_EXPORT_KEY_FILE}

gpg-export-private-key-with-ascii-format:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& $(PRINT_EXAMPLE_ASCII_KEY_FILES) && $(ASK_GPG_EXPORT_KEY_FILE) \
	&& gpg \
		--armor \
		--export-secret-keys $${GPG_PRIVATE_KEY_ID} > $${GPG_EXPORT_KEY_FILE}

# TODO: boxes, sugiriendo leer la doc. oficial https://www.gnupg.org/gph/es/manual/x481.html
gpg-upload-public-key-to-keyserver:
	$(NOTES_GPG_SUGGESTION_KEYSERVERS) \
	&& $(ASK_AND_CHECK_GPG_PUBKEY_SERVER) \
	&& $(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& gpg \
		--keyserver $${GPG_PUBKEY_SERVER_URL} \
		--send-keys $${GPG_PUBLIC_KEY_ID}\

gpg-change-passphrase:
	$(ASK_AND_CHECK_GPG_PRIVATE_KEY_ID) \
	&& gpg --change-passphrase $${GPG_PRIVATE_KEY_ID}

gpg-generate-primary-key:
	$(NOTES_GPG_KEY_SUBKEYS_CAPABILITIES) \
	&& $(ASK_AND_CHECK_GPG_ASYMMETRIC_ALGORITHM) \
	&& $(ASK_GPG_UID_NAME) && $(ASK_GPG_UID_EMAIL) && $(ASK_GPG_PASSPHRASE) \
	&& $(ASK_AND_CHECK_GPG_KEY_CAPABILITIES) \
	&& $(ASK_GPG_EXPIRATION_DATE) \
	&& gpg --batch \
	--passphrase $${GPG_PASSPHRASE} \
	--quick-generate-key \
		$(GPG_UID) \
		$${GPG_ASYMMETRIC_ALGORITHM} $${GPG_KEY_CAPABILITIES} $${GPG_EXPIRATION_DATE}

gpg-generate-subkey:
	$(NOTES_GPG_KEY_SUBKEYS_CAPABILITIES) \
	&& $(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(ASK_AND_CHECK_GPG_ASYMMETRIC_ALGORITHM) \
	&& $(ASK_AND_CHECK_GPG_SUBKEY_CAPABILITIES) \
	&& $(ASK_GPG_EXPIRATION_DATE) \
	&& gpg --quick-add-key \
		$${GPG_PUBLIC_KEY_ID} $${GPG_ASYMMETRIC_ALGORITHM} $${GPG_SUBKEY_CAPABILITIES} $${GPG_EXPIRATION_DATE}

gpg-export-public-key-with-binary-format:
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(PRINT_EXAMPLE_KEY_FILES) && $(ASK_GPG_EXPORT_KEY_FILE) \
	&& gpg --export $${GPG_PUBLIC_KEY_ID} > $${GPG_EXPORT_KEY_FILE}

gpg-export-public-key-with-ascii-format:
	$(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(PRINT_EXAMPLE_ASCII_KEY_FILES) && $(ASK_GPG_EXPORT_KEY_FILE) \
	&& gpg \
		--armor \
		--export $${GPG_PUBLIC_KEY_ID} > $${GPG_EXPORT_KEY_FILE}

# TODO: boxes, sugiriendo leer la doc. oficial https://www.gnupg.org/gph/es/manual/x481.html
gpg-import-public-key-from-keyserver:
	$(NOTES_GPG_SUGGESTIONS_IMPORT_PUBKEY) \
	&& $(ASK_GPG_PUBLIC_KEY_ID) \
	&& $(ASK_GPG_SERVER_PUBLIC_KEY) \
	&& gpg \
		--keyserver $${GPG_SERVER_PUBLIC_KEY} \
		--recv-keys $${GPG_PUBLIC_KEY_ID}

gpg-generate-revocation-certificate:
	$(NOTES_GPG_SUGGESTIONS_REVOCATION) \
	&& $(ASK_AND_CHECK_GPG_PUBLIC_KEY_ID) \
	&& $(PRINT_EXAMPLE_REVOCATION_CERTIFICATE_FILES)&& $(ASK_GPG_REVOCATION_CERTIFICATE_FILE) \
	&& gpg \
		--output $${GPG_REVOCATION_CERTIFICATE_FILE} \
		--gen-revoke $${GPG_PUBLIC_KEY_ID}

gpg-import-revocation-certificate:
	$(ASK_GPG_REVOCATION_CERTIFICATE_FILE) \
	&& gpg --import $${GPG_REVOCATION_CERTIFICATE_FILE}

# TODO: solicitar confirmación para proceder
gpg-apply-revocation-certificate: gpg-import-revocation-certificate gpg-upload-public-key-to-keyserver

# TODO: probar en otra maquina
# TODO: boxes de whiptail para confirmar antes de proceder..
gpg-delete-primary-private-key-file:
	$(ASK_GPG_UID_EMAIL) \
	&& gpg --with-keygrip -k $${GPG_UID_EMAIL} \
	| awk '/Keygrip/' | sed --quiet 1p | tr -d ' ' | sed -E 's/Keygrip=(.*)/\1/'
	| xargs -I % \
		find $${HOME}/.gnupg/private-keys-v1.d/% \
		-type f \
		-name '%.key' \
		-exec bash -c 'shred --iterations=7 --verbose --zero {}; rm --verbose --force {}' \;
