. ~/.zsh/git-prompt/zshrc.sh

. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion
. ~/.zsh/widgets

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# rvm-integration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
