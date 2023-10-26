# TODO: doc + extender features a targets
install-markdownviewer-glow:
	sudo mkdir -p /etc/apt/keyrings \
	&& curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg \
	&& echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list \
	&& sudo aptitude update && sudo aptitude install glow
