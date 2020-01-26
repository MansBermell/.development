# .development

The repository contains various development-related files. Best enjoyed
responsibly.

## Installation

```sh
git clone https://github.com/IvanUkhov/.development.git ~/.development && make -C ~/.development
```

### Git: Signing commits

Generate a key and upload to GitHub:

```sh
brew install gpg2 gnupg

gpg --full-generate-key
gpg --list-secret-keys
gpg --armor --export KEY
```

Configure Git:

```sh
brew install pinentry-mac

echo "pinentry-program `which pinentry-mac`" >> ~/.gnupg/gpg-agent.conf
echo "use-agent\nbatch" >> ~/.gnupg/gpg.conf
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
killall gpg-agent

git config --global gpgsign true
git config --global user.signingkey KEY
```

### Jupyter: Cleaning notebooks

```sh
echo '*.ipynb filter=ipynb' >> ~/.development/gitattributes
```
