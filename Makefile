.DEFAULT_GOAL := all

SLINKS := $(HOME)/.config/mutt $(HOME)/.vim $(HOME)/.zshrc $(HOME)/.config/i3 $(HOME)/.cataclysm-dda

.PHONY: all packages reminders tilix mutt cdda fortress clean links gpg vim zsh i3 w3m urist $(SLINKS)

all: packages tilix ohmyzsh links i3 reminders

links: vim zsh mutt i3 cdda fortress w3m

packages:
	sudo ./common/packages.sh

i3:
	@-unlink $(HOME)/.config/i3
	@-rm -rf $(HOME)/.config/i3.bkp
	@-mv $(HOME)/.config/i3 $(HOME)/.config/i3.bkp
	ln -s -f $(CURDIR)/common/i3 $(HOME)/.config/i3

cdda:
	@-unlink $(HOME)/.cataclysm-dda
	@-rm -rf $(HOME)/.cataclysm-dda.bkp
	@-mv $(HOME)/.cataclysm-dda $(HOME)/.cataclysm-dda.bkp
	ln -s -f $(CURDIR)/common/.cataclysm-dda $(HOME)/.cataclysm-dda
	curl -L https://github.com/Fris0uman/CDDA-Soundpacks/releases/download/2024-01-17/CC-Sounds.zip > /tmp/CC-Sounds.zip
	unzip /tmp/CC-Sounds.zip -d $(CURDIR)/common/.cataclysm-dda/
	curl -L "https://github.com/Theawesomeboophis/UndeadPeopleTileset/releases/download/3%2F4%2F24/Vanilla.zip" > /tmp/vanilla.zip
	unzip /tmp/vanilla.zip -d $(CURDIR)/common/.cataclysm-dda/

fortress:
	@-unlink $(HOME)/.dwarffortress
	@-rm -rf $(HOME)/.dwarffortress.bkp
	@-mv $(HOME)/.dwarffortress $(HOME)/.dwarffortress.bkp
	ln -s -f $(CURDIR)/common/.dwarffortress $(HOME)/.dwarffortress

w3m:
	@-unlink $(HOME)/.w3m
	@-rm -rf $(HOME)/.w3m.bkp
	@-mv $(HOME)/.w3m $(HOME)/.w3m.bkp
	ln -s -f $(CURDIR)/common/.w3m $(HOME)/.w3m

urist:
	@echo "TODO: Patch i3 to a particular configuration (WIP)"

ohmyzsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

vim:
	@-unlink $(HOME)/.vim
	@rm -rf $(HOME)/.vim.bkp
	@-mv $(HOME)/.vim $(HOME)/.vim.bkp
	ln -s -f $(CURDIR)/common/.vim $(HOME)/.vim

zsh:
	@-unlink $(HOME)/.zshrc
	@rm -rf $(HOME)/.zshrc.bkp
	@-mv $(HOME)/.zshrc $(HOME)/.zshrc.bkp
	ln -s -f $(CURDIR)/common/.zshrc $(HOME)/.zshrc

tilix:
	@echo "TODO"

mutt:
	@-unlink $(HOME)/.config/mutt
	@-rm -rf $(HOME)/.config/mutt.bkp
	@-mv $(HOME)/.config/mutt $(HOME)/.config/mutt.bkp
	ln -s -f $(CURDIR)/common/mutt $(HOME)/.config/mutt

reminders:
	@echo "#############################################"
	@echo "Setup your DNS/VPN!"
	@echo "#############################################"
	@echo "Don't forget to set up mutt login via GPG!"
	@echo "Generate a new key: gpg --full-generate-key"
	@echo "Generate the armored file: gpg -r lucas@mayr.sh -e -a > $(CURDIR)/common/mutt/muttpass.gpg"
	@echo "#############################################"
	@echo "Setup eduroam"
	@echo "#############################################"
	@echo "nmcli con add type wifi ifname <WIFI_DEVICE> con-name eduroam ssid eduroam ipv4.method auto 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity <USER> 802-1x.password <PASSWD> wifi-sec.key-mgmt wpa-eap"
	@echo "#############################################"

gpg:
	@-unlink $(HOME)/.gnupg/gpg.conf
	ln -b -s -f $(CURDIR)/common/gpg/gpg.conf $(HOME)/.gnupg/gpg.conf

clean: $(SLINKS)
	@-cp -a $(HOME)/.gnupg/gpg.conf.bkp  $(HOME)/.gnupg/gpg.conf
	@-cp -a $(HOME)/.config/mutt.bkp $(HOME)/.config/mutt
	@-cp -a $(HOME)/.w3m.bkp $(HOME)/.w3m
	@-cp -a $(HOME)/.zshrc.bkp $(HOME)/.zshrc
	@-cp -a $(HOME)/.config/i3.bkp $(HOME)/.config/i3

$(SLINKS):
	-unlink $@
