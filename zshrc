################################################################################
# zsh-Config-File
#
# Author: Philipp Böhm
################################################################################

# key bindings (vi)
bindkey -v
bindkey '^H' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^r" history-incremental-search-backward
bindkey "^a" vi-beginning-of-line
bindkey "^e" vi-end-of-line

autoload -U compinit
compinit
autoload colors
colors

# prompt
export PROMPT='[%B%n%b@%m %2~]%# '

# variables
HISTFILE=~/.zhistory
HISTSIZE=100000
SAVEHIST=100000
export EDITOR=vim
export PATH=$PATH:/home/philipp/projects/Scripts

# options
setopt autocd
setopt share_history
setopt nobeep
setopt histignoredups
setopt histnostore
setopt histreduceblanks
setopt autopushd
setopt extendedglob
setopt interactivecomments
setopt automenu
setopt completeinword
setopt menucomplete

# error tolerance
zstyle ':completion:*' completer _complete _correct _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( 0 numeric )'

# menu completion
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%S%d%s'

zstyle ':completion::complete:*' rehash true

# ssh
hosts=(n130 toshi lisa server toch )
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $hosts

# named directories
hash -d proj=/home/philipp/projects
hash -d noch=/home/philipp/Downloads/.nochzuschauen
hash -d down=/home/philipp/Downloads

# aliases
alias upd=" sudo yum update"
alias smbconf=" sudo vi /etc/samba/smb.conf"
alias isoumount=" sudo umount /mnt"
alias tailmess=" sudo tail -f /var/log/messages"
alias disoff=" xset -display :0 dpms force off"
alias s="sudo -s"
alias s-="su -"
alias zsc="$EDITOR ~/.zshrc"
alias lsd="ls ~/Downloads"
alias p="pdown"
alias g="gsl"
alias um="umount.sh"
alias sm="sudo projects/Scripts/setup_mediatomb.sh"
alias sctl="systemctl"
alias vi="vim"
alias backupebooks='rsync -a -L --delete --progress server:/var/ebooks/ ~/eBooks/i77i/'
alias spindown="sudo hdparm -S6 /dev/sdb; sudo hdparm -y /dev/sdb"
alias rt="rake test 2> /dev/null"
alias srn="serienrenamer"
alias smv="serienmover"

# functions
function ins { sudo yum install "$@"; }
function rem { sudo yum erase "$@"; }
function mkc { sudo yum makecache "$@"; }
function samba {
    sudo systemctl "$1" smb.service;
    sudo systemctl "$1" nmb.service;
}
function isomount { sudo mount -o loop -t iso9660 "$1" /mnt;  }
function tidy {
	perltidy -b "$1";
	rm "$1".bak 2>/dev/null;
}
function downscale {
	mencoder "$1" -o "S2" -oac mp3lame -ovc xvid -xvidencopts pass=1 -vf scale=720:400
}
function lsl { ls -lisa "$@" }
function speak {
    espeak -vde "$@"
}

# git-shortcuts
function gam { git commit -a -m "$1"; }
function gp {
    git status 2> /dev/null | grep 'On branch master' > /dev/null && git push --all
}
alias gpl="git pull"
alias gd="git diff"
alias gs="git status"
alias gl="git log --pretty=oneline"

# widgets
run-with-sudo() { LBUFFER="sudo $LBUFFER" }
zle -N run-with-sudo
bindkey '^[s' run-with-sudo

show-throug-less() { LBUFFER="$LBUFFER| less" }
zle -N show-throug-less
bindkey '^[l' show-throug-less

word-count() { LBUFFER="$LBUFFER| wc -l" }
zle -N word-count
bindkey '^[w' word-count

add-help() { LBUFFER="$LBUFFER --help" }
zle -N add-help
bindkey '^[-' add-help

# show vi mode in right prompt
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/[%BN%b]}/(main|viins)/[%BI%b]}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# custom completions
_pdown() {
 	_arguments \
		'--help[Hilfeseite]' \
		'--version[Versionshinweis]' \
		'--stdin[Links von STDIN lesen]' \
		'--dumpfile=:Linkdatei:_files' \
		'--historyfile=:History-Datei:_files' \
		'--accountfile=:Datei mit Accountdaten:_files' \
		'--ignorehistory[History beim Hinzufügen ignorieren]' \
		'--onlyaddlinks[Links nur hinzufügen]' \
		'--stdin[Links von STDIN lesen]' \
		'--priority=:Priorität:(0 10 20 30 40 50 60 70 80 90 100)' \
		'--downloaddir=:Download-Verzeichnis:_files -/' \
		'--bandwidth=:Nutzbare Bandbreite (INT [k|m]):' \
		'--noclearqueue[Warteschlange am Ende nicht leeren]' \
		'--queuefile=:Warteschlangen-Datei:_files' \
		'--waitseconds=:Sekunden warten vor Start des Downloads (INT):' \
		'--nodeleteparts[Dateien nach dem Entpacken nicht löschen]';
}
compdef _pdown pdown
compdef _pdown pDownloader

_gsl() {
 	_arguments \
		'--help[Hilfeseite]' \
		'--version[Versionshinweis]' \
		'--nogerman[Nur englische Episoden]' \
		'--indexdir=:Verzeichnis mit den Serien-Indizes:_files -/' \
		'--dumpfile=:Linkdatei:_files' \
		'--ignorehistory[History beim Generieren ignorieren]' \
		'--series=:Serienname:' \
		'--from=:Erste Episode [Bsp. S02E05]:' \
		'--to=:Letzte Episode [Bsp. S05E04]:' \
		'--nodecrypt[Kein Auflösen der SJ-Links zu richtigen Links]' \
		'--disablect[Automatisiertes Captcha-Lösen deaktivieren]' \
   		'--maxsize=:Maximle Downloadgröße (MB): ' \
		'--nosizecheck[Anwendung des Größenchecks deaktivieren]';
}
compdef _gsl gsl
compdef _gsl getserieslinks

# rvm-integration
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
