# Eric's .bashrc
# This is sourced when bash is loaded *except* when it's a login shell.

##############################################################################
# Functions for this bash script.

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]
    then
        PATH="$1:$PATH"
        # Appends to end:
        #PATH="${PATH:+"$PATH:"}$1"
        # To put at beginning: PATH="$1:$PATH
    fi
}

pathaddall() {
    # Split on colon.
    VALS=(${1//:/ })
    # Iterate in reverse order, since they will be added to front.
    for ((i=${#VALS[@]}-1; i>=0; i--)); do
        pathadd ${VALS[$i]}
    done
}

one_of() {
    # Goes through arguments and finds the first one that exists as a file.
    local F
    for F in "$@"
    do
        if [ -e $F ]
        then
            echo $F
            return
        fi
    done
}

set_if_found() {
    # $1 = variable name to set
    # $2 = program looking for
    # $3 (optional) = pattern to set to.  Use {} to substitute the binary path.
    # GNU which is annoying, prints to stderr when not found.
    local WHAT="`which $2 2>/dev/null`"
    if [ $WHAT ]
    then
        if [ "$3" ]
        then
            export $1="`echo "$3" | sed "s:{}:$WHAT:"`"
        else
            export $1=$WHAT
        fi
    fi
}

##############################################################################
# General shell things.

# A righteous umask
umask 22

#export MANPATH=/opt/local/share/man:$MANPATH

# & prevents duplicate lines in bash history.
export HISTIGNORE="&"
export HISTFILESIZE=2000
export HISTSIZE=2000

# Automatically updated window size after every command (LINES/COLUMNS env
# vars).
shopt -s checkwinsize
# When redirecting output, don't overwrite existing files.
set -o noclobber
# ** is a recursive expansion.
# (For some reason, not available on os x's bash.)
[[ $(shopt) =~ "globstar" ]] && shopt -s globstar

bind 'set completion-ignore-case on'

pathaddall /opt/local/bin:/opt/local/sbin:$HOME/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin


##############################################################################
# Settings for various programs.
export PAGER="less -siXMn"
export BUILDTOP=$HOME/work
export BLOCKSIZE K
export RSYNC_RSH=ssh
export CVS_RSH=ssh
#export PACKAGESITE=ftp://ftp4.us.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/

set_if_found LESSOPEN lesspipe.sh "|{} %s"
set_if_found EDITOR vim
set_if_found GIT_EXTERNAL_DIFF ~/bin/my_diff.sh

export HTML_TIDY=$HOME/.tidy_config.txt

##############################################################################
# Aliases for convenience.
alias pydebug="python /usr/local/lib/pydebug.py"
alias CPAN="perl -MCPAN -e shell"
# -E will preserve the environment.
alias sur="sudo -E `which bash`"

rfind() {
    grep --devices=skip -r "$@" *
}
pyfind() {
    grep -r --include="*.py" --include "*.pxi" --include "*.pxd" --include "*.pyx" "$@" *
}
cfind() {
    grep -r --include="*.[CHchm]" --include="*.cc" --include="*.cpp" \
        --include="*.[cC]++" --include="*.cxx" --include="*.hpp" \
        --include="*.hxx" --include="*.[hH]++" --include="*.hh" "$@" *
}
tmplfind() {
    grep -r --include="*.tmpl" "$@" *
}
alias ps="ps -jaxwww"
alias dir="ls -lFG"
alias pico="pico -w"
alias less="less -iXM"
alias grep="grep -i"
alias screenx="screen -x"
_VIM=`which vim 2>/dev/null`
if [ $_VIM ]
then
    alias vi="$_VIM"
fi
unset _VIM

#export PYTHONSTARTUP=/home/ehuss/.python_start.py

if [ $UID == "0" ]
then
    export PS1="ROOT \h \# \w> "
else
    export PS1="\h \# \w> "
fi

BC=`one_of /usr/local/etc/bash_completion /opt/local/etc/bash_completion`
if [ $BC ]
then
    . $BC
fi
unset BC

if [ -f ~/.profile.local ]
then
    . ~/.profile.local
fi
