# Kiba Amor<KibaAmor@gmail.com>
# https://github.com/KibaAmor/linuxconfig
# 20150306


#Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


# User specific environment and startup programs
ulimit -c unlimited


export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/games:/usr/local/games:$HOME/bin:$HOME/sbin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib:/lib64:/usr/lib:/usr/lib64:/usr/local/lib:/usr/local/lib64:$HOME/lib:$HOME/lib64

export HISTSIZE=128
export HISTFILESIZE=1024

export SVN_EDITOR=vim

export LANG="en_US.UTF-8"

alias ls='ls --color=auto'
alias l='ls -CF'
alias l.='ls -d .*'
alias la='ls -al'
alias ll='ls -l'
alias lt='ls -Alt'
alias lc='ls -Altc'
alias lx='ls -Altu'
alias lX='ls -AlX'
alias lb='ls -AlS'
alias lm='ls -al | more'
alias lr='ls -AlR'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias findh='find . -regextype "egrep" -regex ".*\.(h|hh|inc)$" -print0 | xargs -0 grep'
alias findcpp='find . -regextype "egrep" -regex ".*\.(c|cc|cxx|cpp)$" -print0 | xargs -0 grep'
alias findhcpp='find . -regextype "egrep" -regex ".*\.(h|hh|inc|c|cc|cxx|cpp)$" -print0 | xargs -0 grep'
alias findpkg='find . -regextype "egrep" -regex ".*\.pkg$" -print0 | xargs -0 grep'
alias findlua='find . -regextype "egrep" -regex ".*\.lua$" -print0 | xargs -0 grep'
alias findpy='find . -regextype "egrep" -regex ".*\.py$" -print0 | xargs -0 grep'
alias tmux='tmux -2'
alias t='tailf'
alias mt='multitailf'
alias ..='cd ..'
alias ~='cd ~'
alias c='clear'
alias v='vim'
alias vr='vim -R'
alias m='make -j4'
alias j='jobs'
alias f='fg'
alias k='kill'
alias x='ps x'
alias screen='screen -U'
alias sls='screen -ls'
alias dstat='dstat -cdlmnpsy'
alias dd='dd status=progress'
