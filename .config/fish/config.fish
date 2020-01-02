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
alias atc="cd ~/programs/python &&vi -c AtcoderX"
alias edex="open /Applications/eDEX-UI.app"

alias rm="sl"
function srm
    mv $argv ~/.Trash/
end

function lsftp
    lftp sftp://$argv
end


function shougi
    open /Applications/SbrowserQ.app
    shougi_cpulim
end

function shougi_cpulim
    set cpu_lim_per 200
    if test $argv[1]
        set cpu_lim_per $argv[1]
    end
    ps -e | grep /Applications/SbrowserQ.app/Contents/MacOS/JavaAppLauncher | grep -v grep | head -n 1 | awk '{print $1}' | read pid
    if ! test $pid
        echo "SbrowserQ.app process not found"
        return 1
    end
    echo "trying to limit SbrowserQ.app CPU persantage to $cpu_lim_per%"
    cpulimit -i -p $pid -l $cpu_lim_per
end


export LSCOLORS=gxfxcxdxbxegedabagacad


set -g fish_user_paths "/usr/local/opt/mysql@5.6/bin" $fish_user_paths
set -g fish_user_paths "/Users/ayato/go/bin/" $fish_user_paths


