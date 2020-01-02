alias ls="ls -FG"
alias ll="ls -l"
alias la="ls -al"
alias l.="ls -d .*"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias grep="grep --color"
alias mv="mv -i"
alias cp="cp -i"
alias less='less -R'
alias inet="ifconfig | grep -E '$|inet'"

alias emacs="vi"
alias visj='vim -c ":e ++enc=shift-jis"'

alias py="python3"
alias py2="python"

set rmstar

function lsftp () {
    lftp sftp://$1;
}

export LSCOLORS=gxfxcxdxbxegedabagacad
if [[ $HOSTNAME =~ ^ayatono ]]; then
    if [ $UID -eq 0 ]; then
        PS1='\[\e[30;47m\] \t \[\e[37;41m\]\[\e[30m\] \w \[\e[31;49m\]\[\e[0m\] '
    else
        PS1='\[\e[30;47m\] \t \[\e[37;42m\]\[\e[30m\] \w \[\e[32;49m\]\[\e[0m\] '
    fi
else
    if [ $UID -eq 0 ]; then
        PS1="\[\033[31m\][\t \u@\h \w]\n# \[\033[0m\]"
    else
        PS1="\[\033[32m\][\t \u@\h \w]\n\$ \[\033[0m\]"
    fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
