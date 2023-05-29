# .development

The repository contains various development-related files. Best enjoyed
responsibly.

## Installation

```sh
git clone https://github.com/mansBeremll/.development.git ~/.development && make -C ~/.development
```

### Git: Signing commits

Generate a key and upload to GitHub:

```sh
brew install gpg2 gnupg

gpg --full-generate-key # RSA, at least 4096 bits long
gpg --list-secret-keys
gpg --armor --export KEY
```

If the first `gpg` command hangs, use the following instead:

```
cat >key.conf <<EOF
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Måns Bermell
Name-Email: mans.bermell@gmail.com
Expire-Date: 0
%commit
EOF
gpg --batch --generate-key key.conf
```

Configure Git:

```sh
brew install pinentry-mac

echo "pinentry-program `which pinentry-mac`" >> ~/.gnupg/gpg-agent.conf
echo "use-agent\nbatch" >> ~/.gnupg/gpg.conf
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
killall gpg-agent

gpg --list-keys --keyid-format LONG
git config --global commit.gpgsign true
git config --global user.signingkey KEY
```
