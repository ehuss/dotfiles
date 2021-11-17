# .bash_profile sourced in login shells.
# login, non-interactive shells (bash -l) only load this file.
# needed by shellenv in Sublime
if [ -f $HOME/.bashrc ]
then
	. $HOME/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
