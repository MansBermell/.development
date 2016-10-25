root := "${HOME}/.develop"

all:
	@ln -Fis "${root}/gemrc" "${HOME}/.gemrc"
	@ln -Fis "${root}/gitconfig" "${HOME}/.gitconfig"
	@ln -Fis "${root}/inputrc" "${HOME}/.inputrc"
	@ln -Fis "${root}/tmux.conf" "${HOME}/.tmux.conf"
	@grep -q '\.develop/bashrc' "${HOME}/.bash_profile" 2> /dev/null || \
		echo 'source "$${HOME}/.develop/bashrc"' >> "${HOME}/.bash_profile"

.PHONY: all
