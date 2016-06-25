ROOT = $(HOME)/.develop

all:
	@ln -Fis $(ROOT)/gemrc $(HOME)/.gemrc
	@ln -Fis $(ROOT)/gitconfig $(HOME)/.gitconfig
	@ln -Fis $(ROOT)/inputrc $(HOME)/.inputrc
	@ln -Fis $(ROOT)/tmux.conf $(HOME)/.tmux.conf
	@grep -q '\.develop/bashrc' $(HOME)/.bash_profile || \
		echo 'source "${HOME}/.develop/bashrc"' >> $(HOME)/.bash_profile

.PHONY: all
