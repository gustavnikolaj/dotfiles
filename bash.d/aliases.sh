# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

alias npm-official="npm --userconfig ~/.npm-official "

# pbcopy / pbpaste for linux
####
if ! command -v pbcopy > /dev/null 2>&1; then # has pbcopy
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
fi

# Shortcuts
#alias p="cd ~/Projects"
#alias g="git"
#alias s="subl"
#alias oo="nautilus ."
alias reload_bash='source ~/.bashrc'

# Git aliases
#alias ga="git add"
#alias gc="git commit -m "
#alias gs="git s"
#alias gh="git hist"
#alias gd="git diff"

# Notification aliases
alias notify-green="notify-send -h string:bgcolor:#11ad00 "
alias notify-blue="notify-send -h string:bgcolor:#336699 "
alias notify-red="notify-send -h string:bgcolor:#aa3333 "
alias notify-orange="notify-send -h string:bgcolor:#ffa700 "

# git insults
alias lazybumbum="echo && figlet 'IM  A  LAZY  BUM!' && echo"
alias g=lazybumbum
alias ga=lazybumbum
alias gc=lazybumbum
alias gs=lazybumbum
alias gh=lazybumbum
alias gd=lazybumbum

# pretty print json
alias pjson="python -mjson.tool"

# Detect which `ls` flavor is in use
####
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -l ${colorflag}"

# List like list but only one row
alias ll="ls -1 ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# File size
if stat -c '' . > /dev/null 2>&1; then
    # GNU `stat`
    alias fs="stat -c \"%s bytes\""
else
    # OS X `stat`
    alias fs="stat -f \"%z bytes\""
fi

# Enable aliases to be sudo’ed
#alias sudo='sudo '

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias fs="stat -c \"%s bytes\""

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# convenience aliases for shutdown, reboot and such

alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"
