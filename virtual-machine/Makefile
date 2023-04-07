install-qemu-manjaro:
	sudo pacman -Syy \
	&& sudo pacman -S archlinux-keyring \
	&& sudo pacman -S qemu

install-vm-dependencies: install-vm-emulator-qemu install-hypervisor-kvm install-virtualization-api-libvirt

OS_NAME=$(shell cat /etc/os-release | awk '/^ID=/' | sed 's/ID\=//')

install-vm-manager:
# linux mint (ubuntu)
	sudo aptitude install virt-manager \
	&& sudo systemctl enable --now libvirtd
# manjaro (arch)
	sudo pacman -S virt-manager

install-vm-emulator-qemu:
# linux mint (ubuntu)
	sudo aptitude install qemu
# manjaro (arch)
	sudo pacman -S qemu

install-hypervisor-kvm:
	sudo aptitude install qemu-kvm

install-virtualization-api-libvirt:
	sudo aptitude install libvirt
