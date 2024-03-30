dnf update -y
dnf makecache

dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm 
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-nonfree-release-`rpm -E %fedora`.noarch.rpm 

dnf install -y vim i3 i3status dmenu i3lock feh fontawesome-fonts \
		tilix xinput powertop xev zsh git \
		openssl alsa-firmware openvpn3-client make snapd ffmpeg \
		ffmpeg-libs alacritty neomutt zathura gnome-screenshot blueman ranger \
		zfz libreoffice cataclysm-dda dwarffortress

snap install spotify

