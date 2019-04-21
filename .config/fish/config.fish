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
alias inet='ifconfig | grep -E \'$|inet'\'
alias visj='vim -c \':e ++enc=shift-jis\''
alias py2="python"
alias py="python3"

function lsftp
    lftp sftp://$argv
end

export LSCOLORS=gxfxcxdxbxegedabagacad

function rm
    mv $argv ~/.Trash/
end

