dnf update -y
dnf makecache

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf config-manager --enable fedora-cisco-openh264

dnf install --skip-broken -y vim i3 i3status dmenu i3lock feh fontawesome-fonts \
		tilix xinput powertop xev zsh git \
		openssl alsa-firmware openvpn make snapd ffmpeg \
		ffmpeg-libs alacritty neomutt zathura gnome-screenshot blueman ranger \
		fzf libreoffice cataclysm-dda dwarffortress git-lfs

