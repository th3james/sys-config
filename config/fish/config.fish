# Load aliases
. "$HOME/.config/fish/functions/aliases.fish"

set -g EDITOR "nvim"
git config --global core.editor nvim

# direnv hook fish | source

# Homebrew path
set -g fish_user_paths (get_homebrew_path) $fish_user_paths

# set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
# set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" $fish_user_paths

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.fish

# Use Docker Buildkit
set -g DOCKER_BUILDKIT 1
set -g COMPOSE_DOCKER_CLI_BUILD 1
