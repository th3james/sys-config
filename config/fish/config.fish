set -x EDITOR 'nvim'
set -x VISUAL 'nvim'
set -x MANPAGER 'nvim +Man!'

# Add custom paths (in reverse priority order)
set -gx fish_user_paths \
    "$HOME/src/FVPs-on-Mac/bin" \
    "$HOME/src/sys-config/zig-scripts/zig-out/bin" \
    "$HOME/.local/bin" \
    /opt/homebrew/sbin \
    (get_homebrew_path) \
    $fish_user_paths

set -gx GPG_TTY (tty)

# Use ripgrep with fzf
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden -g \"!.git/\""

mise activate fish | source
