# Eric's .bashrc
# This is sourced when bash is loaded *except* when it's a login shell.

##############################################################################
# General shell things.

# A righteous umask
umask 22

export PATH=/opt/local/bin:/opt/local/sbin:$HOME/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin

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
shopt -s globstar

##############################################################################
# Functions for this bash script.
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
# Settings for various programs.
export PAGER="less -siXM"
export BUILDTOP=$HOME/work
export BLOCKSIZE K
export RSYNC_RSH=ssh
export CVS_RSH=ssh
#export PACKAGESITE=ftp://ftp4.us.freebsd.org/pub/FreeBSD/ports/i386/packages-4-stable/Latest/

set_if_found LESSOPEN lesspipe.sh "|{} %s"
set_if_found EDITOR vim

export HTML_TIDY=$HOME/.tidy_config.txt

##############################################################################
# Aliases for convenience.
alias pydebug="python /usr/local/lib/pydebug.py"
alias CPAN="perl -MCPAN -e shell"
# -E will preserve the environment.
alias sur="sudo -E `which bash`"

rfind() {
    find . -type f -exec grep "$@" {} /dev/null \;
}
pyfind() {
    find . \( -name "*.py" -or -name "*.pxi" -or -name "*.pxd" -or -name "*.pyx" \) -exec grep "$@" {} /dev/null \;
}
cfind() {
    find . \( -name "*.[CHchm]" -or -name "*.cc" -or -name "*.cpp" -or -name "*.[cC]++" -or -name "*.cxx" \
    -or -name "*.hpp" -o -name "*.hxx" -o -name "*.[hH]++" -o -name "*.hh" \) -exec grep "$@" {} /dev/null \;
}
tmplfind() {
    find . -name "*.tmpl" -exec grep "$@" {} /dev/null \;
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