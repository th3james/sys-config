abbr -a -g dc docker-compose
abbr -a -g dce docker-compose exec
abbr -a -g vi nvim
abbr -a -g tmux env TERM=screen-256color tmux

# Git #
abbr -a -g ga git add
abbr -a -g gst git status
abbr -a -g gcm 'git checkout (gmom)'
abbr -a -g gco git checkout
abbr -a -g gd git diff
abbr -a -g gc git commit -v
abbr -a -g gfm 'git fetch; git merge --ff-only'
abbr -a -g gfr 'git fetch; git rebase'
abbr -a -g gpo 'git push origin'
abbr -a -g gph 'git push origin HEAD'
abbr -a -g glp 'git log --graph --pretty=oneline --abbrev-commit'

# Kubectl #
abbr -a -g kcnls 'kubectl get namespaces'
abbr -a -g kcuc 'kubectl config use-context'
