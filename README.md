
Clone the repo

```
git clone https://github.com/troyschneringer/dotfiles $HOME/.dotfiles
```

For most files, just create a symbolic link to the corresponding file in `$HOME/.dotfiles`

```
ln -s $HOME/.dotfiles/.inputrc $HOME/.inputrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
```

The `.gitconfig` is a special case, because there are some machine / os specific settings (like the credential helper, etc). Just add the following to `$HOME/.gitconfig`

```
[include]
    path = .dotfiles/.gitconfig
```