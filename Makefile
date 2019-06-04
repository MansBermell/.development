all:
	@ln -Fis "${CURDIR}/gitconfig" "${HOME}/.gitconfig"
	@ln -Fis "${CURDIR}/tmux.conf" "${HOME}/.tmux.conf"
	@grep -q '/zshrc' "${HOME}/.zshrc" 2> /dev/null || \
		echo "source '${CURDIR}/zshrc'" >> "${HOME}/.zshrc"
