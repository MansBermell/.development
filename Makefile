all:
	@ln -Fis "${CURDIR}/gitconfig" "${HOME}/.gitconfig"
	@ln -Fis "${CURDIR}/inputrc" "${HOME}/.inputrc"
	@grep -q '/bashrc' "${HOME}/.bash_profile" 2> /dev/null || \
		echo 'source "${CURDIR}/bashrc"' >> "${HOME}/.bash_profile"
