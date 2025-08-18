#!/usr/bin/env fish

set config_dir (realpath ~/src/sys-config/config)
set target_dir ~/.config

function backup_existing
    if test -e $target_dir -a ! -L $target_dir
        set backup_dir ~/.config.backup.(date +%Y%m%d_%H%M%S)
        echo "Backing up existing ~/.config to $backup_dir"
        mv $target_dir $backup_dir
    end
end

function create_symlink
    if test -L $target_dir
        set current_target (readlink $target_dir)
        if test "$current_target" = "$config_dir"
            echo "Symlink already points to correct location: $config_dir"
            return 0
        else
            echo "Removing existing symlink (points to: $current_target)"
            rm $target_dir
        end
    end
    
    backup_existing
    
    echo "Creating symlink: $target_dir -> $config_dir"
    ln -s $config_dir $target_dir
end

if test "$argv[1]" = "--dry-run"
    echo "DRY RUN MODE"
    if test -L $target_dir
        set current_target (readlink $target_dir)
        if test "$current_target" = "$config_dir"
            echo "Would do nothing - symlink already correct"
        else
            echo "Would replace symlink: $current_target -> $config_dir"
        end
    else if test -e $target_dir
        echo "Would backup existing ~/.config and create symlink"
    else
        echo "Would create new symlink: $target_dir -> $config_dir"
    end
else
    create_symlink
end
