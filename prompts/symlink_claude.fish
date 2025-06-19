#!/usr/bin/env fish

# Script to symlink Claude Code instructions

# Define the target file
set target_file "$HOME/src/sys-config/prompts/conventions.md"

# Define the symlink name
set symlink_name "$HOME/.claude/CLAUDE.md"

# Define the directory for the symlink
set symlink_dir (dirname "$symlink_name")

# Create the directory for the symlink if it doesn't exist
if not test -d "$symlink_dir"
    mkdir -p "$symlink_dir"
    echo "Created directory: $symlink_dir"
end

# Check if the target file exists
if not test -e "$target_file"
    echo "Error: Target file does not exist at $target_file"
    exit 1
end

# Create or update the symlink
# The -f option will remove the existing symlink if it exists
# The -s option creates a symbolic link
if ln -sf "$target_file" "$symlink_name"
    echo "Symlink created/updated:"
    echo "  '$symlink_name' -> '$target_file'"
else
    echo "Error: Failed to create symlink."
    exit 1
end