.DEFAULT_GOAL := all

SLINKS := $(HOME)/.config/mutt $(HOME)/.vim $(HOME)/.zshrc $(HOME)/.config/i3

.PHONY: all packages tilix mutt clean links gpg vim zsh i3 urist $(SLINKS)

all: packages tilix ohmyzsh links i3

links: vim zsh mutt i3

packages:
	sudo ./common/packages.sh

i3:
	@-mv $(HOME)/.config/i3 $(HOME)/.config/i3.bkp
	ln -s -f $(CURDIR)/common/i3 $(HOME)/.config/i3

urist:
	@echo "TODO: Patch i3 to a particular configuration (WIP)"

ohmyzsh:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

vim:
	@-mv $(HOME)/.vim $(HOME)/.vim.bkp
	ln -s -f $(CURDIR)/common/.vim $(HOME)/.vim

zsh:
	@-mv $(HOME)/.zshrc $(HOME)/.zshrc.bkp
	ln -s -f $(CURDIR)/common/.zshrc $(HOME)/.zshrc

tilix:
	@echo "TODO"

mutt:
	@-mv $(HOME)/.config/mutt $(HOME)/.config/mutt.bkp
	ln -s -f $(CURDIR)/common/mutt $(HOME)/.config/mutt
	@echo "#############################################"
	@echo "Don't forget to set up mutt login via GPG!"
	@echo "Generate a new key: gpg --full-generate-key"
	@echo "Generate the armored file: gpg -r lucas@mayr.sh -e -a > $(CURDIR)/common/mutt/muttpass.gpg"
	@echo "#############################################"

gpg:
	@-mv $(HOME)/.gnupg/gpg.conf  $(HOME)/.gnupg/gpg.conf.bkp
	ln -s -f $(CURDIR)/common/gpg/gpg.conf $(HOME)/.gnupg/gpg.conf

clean: $(SLINKS)
	@-cp -a $(HOME)/.gnupg/gpg.conf.bkp  $(HOME)/.gnupg/gpg.conf
	@-cp -a $(HOME)/.config/mutt.bkp $(HOME)/.config/mutt
	@-cp -a $(HOME)/.zshrc.bkp $(HOME)/.zshrc
	@-cp -a $(HOME)/.config/i3.bkp $(HOME)/.config/i3

$(SLINKS):
	-unlink $@
