# Load aliases
. "$HOME/.config/fish/functions/aliases.fish"

set -g EDITOR "nvim"
git config --global core.editor nvim

# direnv hook fish | source

# Homebrew path
set -g fish_user_paths (get_homebrew_path) $fish_user_paths

# set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
# set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" $fish_user_paths

# rbenv
# status --is-interactive; and source (rbenv init -|psub)

# pyenv
set -g PYENV_ROOT $HOME/.pyenv
set -g fish_user_paths $PYENV_ROOT/bin $fish_user_paths
status --is-interactive; and source (pyenv init -|psub)

# Use Docker Buildkit
set -g DOCKER_BUILDKIT 1
set -g COMPOSE_DOCKER_CLI_BUILD 1
