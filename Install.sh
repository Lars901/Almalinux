#!/usr/bin/env bash
sudo dnf -y install pciutils
sudo dnf install -y wget
sudo dnf install -y nano
sudo dnf install gzip2 tar
#sudo nano/etc/dnf/dnf.conf
#Requirements for fonts
#dnf install -y rpm-build
sudo dnf install -y ttmkfdir
sudo dnf install -y cabextract
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig
#Actual fonts
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
wget http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/google-noto-emoji-fonts-20200916-4.el9.noarch.rpm
sudo dnf install -y google-noto-emoji-fonts
sudo mkdir ~/.config/fontsconfig
sudo cp 01-emoji.conf ~/.config/fontconfig/conf.d/01-emoji.conf

#Drivers
wget https://repo.radeon.com/amdgpu-install/22.40.3/rhel/9.1/amdgpu-install-5.4.50403-1.el9.noarch.rpm
sudo dnf install -y --accept-eula ./amdgpu-install-5.4.50403-1.el9.noarch.rpm --opencl=rocr,legacy --vulkan=amdvlk,pro
#Install Kde Plasma
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf update -y
sudo dnf config-manager --set-enabled crb
sudo dnf -y groupinstall "KDE Plasma Workspaces" "base-x"
sudo systemctl set-default graphical
#Qemu
sudo dnf makecache --refresh
sudo dnf -y install edk2-ovmf
 sudo dnf install qemu-kvm qemu-img libvirt virt-manager virt-install virt-viewer libvirt-client
 sudo systemctl start libvirtd*
 sudo systemctl enable libvirtd

 #Beautiful Bash
 sudo mkdir ~/GitHub/
 cd ~/GitHub/
 sudo chmod +x ./setup.sh
 ./setup.sh
 #BraveBrowser
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser

#VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install -y codium

 #Requirements virtualbox guest additions
 dnf install tar bzip2 kernel-devel-$(uname -r) kernel-headers perl gcc make elfutils-libelf-devel 
sudo reboot