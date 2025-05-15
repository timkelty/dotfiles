# https://www.zerotohero.dev/zshell-startup-files/
# - .zshenv
# - .zprofile (if login shell)
# - .zshrc (if interactive)
# - .zlogin (if login shell)
# - .zlogout (when a login shell exits)

if [[ "$(arch)" = "i386" ]]; then
    echo "x86 detected, loading Homebrew from /usr/local/Homebrew"…
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
else
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

eval "$(pyenv init --path)"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
