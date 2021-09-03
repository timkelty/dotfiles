# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it does not exist or it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

# https://github.com/rupa/z/
. /opt/homebrew/etc/profile.d/z.sh

# https://github.com/tj/git-extras
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

# exa/ls
alias ls="exa --header --group-directories-first -l"
alias lso="gstat -c '%A %a %U %G %n' *"

alias cat="bat"

# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias hosts="sudo $EDITOR /etc/hosts"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
alias dnsflush="sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"

# git
alias gitc="vim .git/config"
alias giti="vim .gitignore"
alias gitm="vim .gitmodules"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Docker
alias docker-stop-all='docker stop $(docker ps -aq)'
alias docker-remove-all='docker-stop-all && docker rm $(docker ps -aq)'
alias docker-remove-hashed-images="docker rmi $(docker images | egrep '{{ item }}-[[:digit:]]{14}' | tail -n +4 | awk '{ print $3 }')"
alias docker-remove-hashed-volumes="docker volume rm $(docker volume ls | egrep '[[:alnum:]]{64}')"
alias dps="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# Docker Compose
alias dc='docker compose'
alias dcb='dc build'
alias dce='dc exec'
alias dcps="dc ps"
alias dcu='dc up -d'
alias dcd='dc down'
alias dcl='dc logs -f'

# https://github.com/johnnyopao/awsp
alias awsp="source _awsp"

alias tf="terraform"
alias ghw="gh repo view --web"

# With no arguments opens the current directory in `cmd`,
# otherwise opens the given location
function _open() {
	local cmd="$1"
	if [ $# -eq 1 ]; then
		$cmd .
	else
		$cmd "${@:2}"
	fi
}

function e() {
	_open $CODE_EDITOR "$@"
}

function gg() {
	_open gittower "$@"
}

function phps() {
	_open phpstorm "$@"
}

function o() {
	_open open "$@"
}

# Remove current directory
function rm.() {
	local TMP=$(pwd -P)
	echo "\nDelete \"$TMP\"? [y/N]"
	read CONFIRM

	if [ "$CONFIRM" = "y" ]; then
		cd "$(dirname $TMP)" && rm -rf "./$(basename $TMP)"
	fi
}

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

# https://fetzi.dev/add-composer-link-command/
composer-link() {
  repositoryName=${3:-local}

  composer config repositories.$repositoryName '{"type": "path", "url": "'$1'", "options": {"symlink": true}}' --file composer.json
  composer require $2 @dev
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null >/dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg .[^.]* ./*
	fi
}
