# Load aliases
. "$HOME/.config/fish/functions/aliases.fish"

set -x EDITOR 'nvim'
set -x VISUAL 'nvim'
set -x MANPAGER 'nvim +Man!'

# Add custom paths (in reverse priority order)
set -gx fish_user_paths \
    "$HOME/src/FVPs-on-Mac/bin" \
    "$HOME/.config/bun-scripts/" \
    "$HOME/src/sys-config/zig-scripts/zig-out/bin" \
    "$HOME/.local/bin" \
    /opt/homebrew/sbin \
    (get_homebrew_path) \
    $fish_user_paths

set -gx GPG_TTY (tty)

# Use ripgrep with fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden -g \"!.git/\""

# Use Docker Buildkit
set -g DOCKER_BUILDKIT 1
set -g COMPOSE_DOCKER_CLI_BUILD 1

mise activate fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
