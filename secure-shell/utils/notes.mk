NOTES_SSH_KEYS=$(call color_box_notes, \
	$(MODULE_SECURE_SHELL_NOTES)/ssh-keys.txt \
)

NOTES_SSH_PRIVATE_KEYS=$(call color_box_notes, \
	$(MODULE_SECURE_SHELL_NOTES)/ssh-private-keys.txt \
)

NOTES_SSH_KNOWN_HOSTS=$(call color_box_notes, \
	$(MODULE_SECURE_SHELL_NOTES)/known-hosts.txt \
)

NOTES_SSH_UNKNOWN_HOSTS=$(call color_box_notes, \
	$(MODULE_SECURE_SHELL_NOTES)/unknown-hosts.txt \
)
