################
# Simple Aliases
################

# Navigation
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

# Apt
alias agi='sudo apt-get install'
alias agrm='sudo apt-get remove'
alias agu='sudo apt-get update && sudo apt-get upgrade'

# Misc
alias :q='exit'
alias mkdir="mkdir -pv"
alias reboot='sudo /sbin/reboot'
alias wget='wget -c'
alias vim='gvim'
alias vi='vim'
alias chrome='google-chrome'
alias update-cron='crontab -u james /home/james/.crontab'
alias refresh='source /home/james/.bashrc'

#######################
# Tools and Long Things
#######################

## Disable volume
alias shutup='amixer -q -D pulse set Master toggle'

## Dotfiles bare git repo at ~/.cfg
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

## Display things
alias displayfix='/usr/bin/xrandr --output DVI-I-1 --off && sleep 2 && /usr/bin/xrandr --output DVI-I-1 --left-of eDP1 --auto'

## Alert boxes
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Process grep
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

## MRU Commands
mru () {
  echo "Most used commands:"
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

## Make dir and jump into it
mcd () {
  mkdir -p $1
  cd $1
}

## Super Extract Yay
extract () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ] ; then
      NAME=${1%.*}
      mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ../$1    ;;
        *.tar.gz)    tar xvzf ../$1    ;;
        *.tar.xz)    tar xvJf ../$1    ;;
        *.lzma)      unlzma ../$1      ;;
        *.bz2)       bunzip2 ../$1     ;;
        *.rar)       unrar x -ad ../$1 ;;
        *.gz)        gunzip ../$1      ;;
        *.tar)       tar xvf ../$1     ;;
        *.tbz2)      tar xvjf ../$1    ;;
        *.tgz)       tar xvzf ../$1    ;;
        *.zip)       unzip ../$1       ;;
        *.Z)         uncompress ../$1  ;;
        *.7z)        7z x ../$1        ;;
        *.xz)        unxz ../$1        ;;
        *.exe)       cabextract ../$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

