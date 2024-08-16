# Load aliases
. "$HOME/.config/fish/functions/aliases.fish"

set -gx TERM "xterm-kitty"

set -gx EDITOR "nvim"
git config --global core.editor nvim

# Homebrew path
set -gx fish_user_paths (get_homebrew_path) $fish_user_paths
set -gx fish_user_paths /opt/homebrew/sbin $fish_user_paths

# set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
# set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" $fish_user_paths
set -gx fish_user_paths "$HOME/.config/bb/" $fish_user_paths

# Use ripgrep with fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden -g \"!.git/\""

if is_installed zoxide
  zoxide init fish | source
end

# Use Docker Buildkit
set -g DOCKER_BUILDKIT 1
set -g COMPOSE_DOCKER_CLI_BUILD 1

mise activate fish | source
