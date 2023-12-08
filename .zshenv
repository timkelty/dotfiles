source "$HOME/.zshenv.secrets"

export CODE_EDITOR="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
export EDITOR="vim"
export GIT_EDITOR="vim +startinsert"

export FZF_DEFAULT_COMMAND="fd . $HOME"

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

alias assume="source assume"
