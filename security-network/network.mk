NETWORK_ASK_INTERFACE=read -p "ingrese el nombre de la interfáz de red: "

install-network-dependencies:
	sudo aptitude install nmtui bmon speedtest-cli

# TODO: menu de selección: network-monitoring-tools.lst
network-monitor-all:
	bmon

# TODO: menu de selección: network-monitoring-tools.lst
network-monitor-interface:
	$(NETWORK_ASK_INTERFACE) INTERFACE_NAME \
	&& bmon --policy=$${INTERFACE_NAME}

network-connections-active:
	nmcli con show --active

network-interfaces-list:
	ip -c address

network-manager-tui:
	nmtui

network-speedtest:
	speedtest-cli
