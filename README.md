## New machine setup…

- brew
- clone dotfiles
- zim
- vundle

## Not sourced, copy these to a new machine!

- `.aws`
- `.ssh`
- `.nitro`
- `.zsh_history`
- `.z`

## Settings synced via cloud

- iterm
- alfred
- vscode
- phpstorm

```
git clone --no-checkout git@github.com:timkelty/dotfiles.git ~/dotfiles
cd ~/dotfiles
git config --local status.showUntrackedFiles no
git config --local core.work-tree ../..
git restore --staged ..
ln -s $HOME/dotfiles/.git $HOME/.git
```
