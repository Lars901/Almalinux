#!/usr/bin/env bash
#Ensure user is part of sudo group
sudo usermod -aG sudo wheel $USER
sudo dnf -y install pciutils
sudo dnf install -y wget
sudo dnf install -y nano
sudo dnf install gzip2 tar
sudo echo 'defaultyes=True' >> /etc/dnf/dnf.conf

#Requirements for fonts
#dnf install -y rpm-build
sudo dnf install -y ttmkfdir
sudo dnf install -y curl
#Actual fonts
sudo mkdir ~/.local/share/fonts
sudo mkdir /usr/local/share/fonts/
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2pms/msttcore-fonts-installer-2.6-1.noarch.rpm
wget http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages/google-noto-emoji-fonts-20200916-4.el9.noarch.rpm
sudo dnf install -y google-noto-emoji-fonts
sudo mkdir ~/.config/fontsconfig
sudo cp 01-emoji.conf ~/.config/fontconfig/conf.d/01-emoji.conf
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Meslo.zip
tar -xvf Meslo.zip
cd Meslo
mv *.ttf /usr/local/share/fonts/
fc-cache /usr/local/share/fonts/
#Beautiful Bash
sudo mkdir -p ~/.config
touch ~/.config/starship.toml
curl -sS https://starship.rs/install.sh | sh
sudo echo 'eval "$(starship init bash)"' >> ~/.bashrc
#starship preset pastel-powerline > ~/.config/starship.toml
starship preset tokyo-night > ~/.config/starship.toml

#LibreOffice
sudo dnf install -y libreoffice-writer libreoffice-calc libreoffice-impress

#Install Kde Plasma
sudo dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf update -y
sudo dnf config-manager --set-enabled crb
sudo dnf -y groupinstall "KDE Plasma Workspaces" "base-x"
sudo systemctlset-default graphical

#Drivers
wget https://repo.radeon.com/amdgpu-install/22.40.3/rhel/9.1/amdgpu-install-5.4.50403-1.el9.noarch.rpm
#sudo dnf install -y --accept-eula ./amdgpu-install-5.4.50403-1.el9.noarch.rpm --opencl=rocr,legacy --vulkan=amdvlk,pro

#Qemu
sudo dnf makecache --refresh
sudo dnf install -y edk2-ovmf
 sudo dnf install -y qemu-kvm qemu-img libvirt virt-manager virt-install virt-viewer libvirt-client
 sudo systemctl start libvirtd*
 sudo systemctl enable libvirtd
#BraveBrowser
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

#VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install -y codium

#Flatpak
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.spotify.Client
flatpak install -y flathub org.inkscape.Inkscape
 
#Requirements virtualbox guest additions
sudo dnf install -y tar bzip2 kernel-devel-$(uname -r) kernel-headers perl gcc make elfutils-libelf-devel 
sudo reboot