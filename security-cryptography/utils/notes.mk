NOTES_GPG_KEY_ID=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-identify-key-id.txt\
	$(MODULE_CRYPTO_NOTES)/gpg-filename-extensions.txt \
)

NOTES_GPG_SIGNATURES=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-signatures.txt \
)

NOTES_GPG_KEY_SUBKEYS_CAPABILITIES=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-key-subkeys-capabilities.txt \
)

NOTES_GPG_SUGGESTIONS_REVOCATION=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-suggestions-revocation.txt \
)

NOTES_GPG_SUGGESTIONS_PRIVATE_KEY=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-suggestions-private-key.txt \
)

NOTES_GPG_SUGGESTIONS_KEYSERVERS=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-suggestions-keyservers.txt \
)

NOTES_GPG_SUGGESTIONS_IMPORT_PUBKEY=$(call color_box_notes, \
	$(MODULE_CRYPTO_NOTES)/gpg-suggestions-import-pubkey.txt \
)
