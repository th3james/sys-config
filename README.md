System config
==========

My config setup for my developer tools. Each dir contains
contains config for a tool, which you must symlink to the correct
dir using the ./symlink command



# Setup
```shell
mkdir -p ~/src
cd ~/src
git clone git@github.com:th3james/sys-config.git
cd sys-config

# Install dependencies
./install.sh

# Or preview changes first
./symlink.sh --dry-run

# Symlink configs (safe to run multiple times)
./symlink.sh
```
