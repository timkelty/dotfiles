#
# User configuration sourced by interactive shells
#

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# https://github.com/nvm-sh/nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# https://github.com/Aloxaf/fzf-tab?
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'echo $EXA_FZF_PREVIEW_OPTS | xargs exa $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# because of fzf border
zstyle ':fzf-tab:*' fzf-pad 4

zstyle ':fzf-tab:complete:exa:*' fzf-preview '[ -d $realpath ] && echo $EXA_FZF_PREVIEW_OPTS | xargs exa $realpath || bat $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview '[ -f $realpath ] && bat $realpath'

# spacebar, so git branches don't match
zstyle ':fzf-tab:*' continuous-trigger " "

# fzf-preview 'exa -1 --color=always $realpath'
# use input as query string when completing zlua
# zstyle ':fzf-tab:complete:_zlua:*' query-string input

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

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

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

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
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

typeset -gaU chpwd_functions
chpwd_functions+=fre_chpwd

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# https://github.com/tj/git-extras
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh

alias fd="fd ${FD_DEFAULT_OPTS}"
alias lzd='lazydocker'
alias lg='lazygit'

# exa/eza/ls
alias ls="eza --group-directories-first"
alias ll="eza --group-directories-first -al"

# https://github.com/sharkdp/bat
alias cat="bat"

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
alias dps="docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'"

# Docker Compose
alias dc='docker compose'
alias dcb='dc build'
alias dce='dc exec'
alias dcps="dc ps"
alias dcu='dc up -d'
alias dcd='dc down'
alias dcl='dc logs -f'

alias tf="terraform"
alias ghw="gh repo view --web"
alias ddd="ddev describe"
alias ddw="ddev launch"
alias ddx="ddev xdebug on"
alias ddt="ddev tableplus"

# https://github.com/camdencheek/fre
fre_purge() {
	fre --sorted | while read dir ; do if [ ! -d "$dir" ] ; then fre --delete "$dir";  fi ; done
}

fre_chpwd() {
  fre --add "$(pwd)"
}

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
	_open fork "$@"
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

function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
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
