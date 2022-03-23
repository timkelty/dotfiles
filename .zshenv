#
# User configuration sourced by all invocations of the shell
#

# Define Zim location
: ${ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim}

export CODE_EDITOR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
export EDITOR="vim"
export GIT_EDITOR="vim +startinsert"

# Tell nitro to use local images
export NITRO_DEVELOPMENT=true

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

export NITRO_DEFAULT_TLD="test"

source "$HOME/.zshenv.secrets"
