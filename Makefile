all:
	@ln -Fis "${PWD}/gemrc" "${HOME}/.gemrc"
	@ln -Fis "${PWD}/gitconfig" "${HOME}/.gitconfig"
	@ln -Fis "${PWD}/inputrc" "${HOME}/.inputrc"
	@ln -Fis "${PWD}/tmux.conf" "${HOME}/.tmux.conf"
	@grep -q '/bashrc' "${HOME}/.bash_profile" 2> /dev/null || \
		echo 'source "${PWD}/bashrc"' >> "${HOME}/.bash_profile"
