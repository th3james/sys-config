# Load aliases
. "$HOME/.config/fish/functions/aliases.fish"

set -gx EDITOR "nvim"
git config --global core.editor nvim

# Homebrew path
set -gx fish_user_paths (get_homebrew_path) $fish_user_paths

# set -g fish_user_paths "$HOME/.cargo/bin" $fish_user_paths
# set -g fish_user_paths "$HOME/.gem/ruby/2.6.0/bin" $fish_user_paths

# asdf

if is_installed asdf
  source (brew --prefix asdf)/libexec/asdf.fish
else
  echo "No asdf installed"
end

# Use ripgrep with fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden -g \"!.git/\""


if is_installed direnv
  direnv hook fish | source
end

if is_installed zoxide
  zoxide init fish | source
end

# Use Docker Buildkit
set -g DOCKER_BUILDKIT 1
set -g COMPOSE_DOCKER_CLI_BUILD 1
