all:
	@ln -Fis "${PWD}/gitconfig" "${HOME}/.gitconfig"
	@ln -Fis "${PWD}/inputrc" "${HOME}/.inputrc"
	@grep -q '/bashrc' "${HOME}/.bash_profile" 2> /dev/null || \
		echo 'source "${PWD}/bashrc"' >> "${HOME}/.bash_profile"
