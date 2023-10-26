install-qemu-manjaro:
	sudo pacman -Syy \
	&& sudo pacman -S archlinux-keyring \
	&& sudo pacman -S qemu

install-vm-dependencies: install-vm-emulator-qemu install-hypervisor-kvm install-virtualization-api-libvirt

OS_NAME=$(shell cat /etc/os-release | awk '/^ID=/' | sed 's/ID\=//')

# TODO: definir un modelo fácil de manejar para los distintos package manager de las distro
install-vm-manager:
# linux mint (ubuntu)
	sudo aptitude install virt-manager \
	&& sudo systemctl enable --now libvirtd
# manjaro (arch)
	sudo pacman -S virt-manager

# TODO: definir un modelo fácil de manejar para los distintos package manager de las distro
install-vm-emulator-qemu:
# linux mint (ubuntu)
	sudo aptitude install qemu
# manjaro (arch)
	sudo pacman -S qemu

install-hypervisor-kvm:
	sudo aptitude install qemu-kvm

install-virtualization-api-libvirt:
	sudo aptitude install libvirt

#install-qemu:
# sudo aptitude install qemu qemu-kvm virt-manager

# ubuntu
# sudo aptitude install qemu qemu-system-x86-64
