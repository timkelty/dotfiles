# https://www.zerotohero.dev/zshell-startup-files/
# - .zshenv
# - .zprofile (if login shell)
# - .zshrc (if interactive)
# - .zlogin (if login shell)
# - .zlogout (when a login shell exits)

source "$HOME/.zshenv.secrets"

export CODE_EDITOR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
export EDITOR="vim"
export GIT_EDITOR="vim +startinsert"

# Add go bin
export PATH="$PATH:$HOME/go/bin"

# Add Composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# Add Yarn
export PATH="$PATH:$HOME/.config/node_modules/.bin"

# Add ~/bin
export PATH="$HOME/bin:$PATH"

# Add cwd bins
export PATH="$PATH:node_modules/.bin:vendor/bin"

# Serverless needs this to load from ~/.aws/config
export AWS_SDK_LOAD_CONFIG=1

# Created by `pipx` on 2021-09-14 13:18:21
export PATH="$PATH:/Users/timkelty/.local/bin"

export DEV_EMAIL=tim@craftcms.com
export DEV_USERNAME=admin
export DEV_PASSWORD=password

export FD_DEFAULT_OPTS="--unrestricted"
export EXA_DEFAULT_OPTS="--header --group-directories-first --icons --color=always --octal-permissions"
export EXA_FZF_PREVIEW_OPTS="$EXA_FZF_PREVIEW_OPTS -1"
export FZF_FD_DEFAULT_COMMAND='command cat <(fd . . $FD_DEFAULT_OPTS) <(fd . ~ $FD_DEFAULT_OPTS)'
export FZF_FD_FILES_COMMAND='command cat <(fd -t f . . $FD_DEFAULT_OPTS) <(fd -t f . ~ $FD_DEFAULT_OPTS)'
export FZF_FD_DIRS_COMMAND='command cat <(fd -t d . . $FD_DEFAULT_OPTS) <(fd -t d . ~ $FD_DEFAULT_OPTS)'
export FZF_DEFAULT_OPTS="--layout=reverse --border --cycle --height=50% --info=inline-right"
export FZF_CTRL_T_COMMAND='eval $FZF_FD_DEFAULT_COMMAND'
export FZF_CTRL_T_OPTS="--prompt 'All> '
--header 'CTRL-T: All / CTRL-D: Directories / CTRL-F: Files / ALT-ENTER: Copy'
--bind 'ctrl-t:change-prompt(All> )+reload($FZF_CTRL_T_COMMAND)'
--bind 'ctrl-d:change-prompt(Directories> )+reload($FZF_FD_DIRS_COMMAND)'
--bind 'ctrl-f:change-prompt(Files> )+reload($FZF_FD_FILES_COMMAND)'
--bind 'alt-enter:execute-silent(echo {} | tr -d \"\n\" | pbcopy)+abort'
--preview '[ -d {} ] && echo $EXA_FZF_PREVIEW_OPTS | xargs exa {} || bat {}'"
export FZF_ALT_C_COMMAND="command cat <(fre --sorted) <(fd -t d . ~ $FD_DEFAULT_OPTS --max-depth=1) <(fd -t d . ~ $FD_DEFAULT_OPTS --max-depth=1)"
export FZF_ALT_C_OPTS="--tiebreak=index
--preview 'echo $EXA_FZF_PREVIEW_OPTS | xargs exa {}'"

export MAGIC_ENTER_OTHER_COMMAND="ls ."
export MAGIC_ENTER_GIT_COMMAND="$MAGIC_ENTER_OTHER_COMMAND ; git status -u ."


# Added by Granted https://www.granted.dev/
alias assume="source assume"
