# https://www.zerotohero.dev/zshell-startup-files/
# - .zshenv
# - .zprofile (if login shell)
# - .zshrc (if interactive)
# - .zlogin (if login shell)
# - .zlogout (when a login shell exits)

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init --path)"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
