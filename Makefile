all:
	git submodule update --init --recursive

test: common

common:
	time sudo ./vmbuilder/kvm/rhel/6/vmbuilder.sh \
	--config-path ./vmbuilder.conf \
	--distro-arch `arch`
