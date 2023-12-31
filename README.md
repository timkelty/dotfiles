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
git clone --bare git@github.com:timkelty/dotfiles.git
cd ~/dotfiles.git
git config status.showUntrackedFiles no
git config core.bare false
git config core.worktree $HOME
git restore --staged ..
ln -s $PWD $HOME/.git
```
