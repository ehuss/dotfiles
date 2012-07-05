#!/bin/sh

if [ `dirname $0` != "." ]
then
	echo "You must run this from within the dotfiles directory."
	exit 1
fi

#
# Finding the relative path to a certain file ($2), given the absolute path ($1)
# (available here too http://pastebin.com/tWWqA8aB)
#
relpath () {
  local  FROM="$1"
  local    TO="`dirname  $2`"
  local  FILE="`basename $2`"
  local  DEBUG="$3"

  local FROMREL=""
  local FROMUP="$FROM"
  while [ "$FROMUP" != "/" ]; do
    local TOUP="$TO"
    local TOREL=""
    while [ "$TOUP" != "/" ]; do
      [ -z "$DEBUG" ] || echo 1>&2 "$DEBUG$FROMUP =?= $TOUP"
      if [ "$FROMUP" = "$TOUP" ]; then
        echo "${FROMREL:-.}/$TOREL${TOREL:+/}$FILE"
        return 0
      fi
      TOREL="`basename $TOUP`${TOREL:+/}$TOREL"
      TOUP="`dirname $TOUP`"
    done
    FROMREL="..${FROMREL:+/}$FROMREL"
    FROMUP="`dirname $FROMUP`"
  done
  echo "${FROMREL:-.}${TOREL:+/}$TOREL/$FILE"
  return 0
}

FILES=`echo .[a-z]*`

for file in $FILES
do
	if [ "$file" != ".git" ]
	then
		doit=1
		hf=$HOME/$file
		if [ -e $hf ]
		then
			if [ ! $hf -ef $file ]
			then
				echo "$hf already exists."
				echo -n "Would you like to make a backup and replace it with a symlink? [y/n]"
				read REPLY
				if [ "$REPLY" != "y" ]
				then
					echo "Will not overwrite."
					doit=
			    else
			    	mv $hf $hf.bak || exit 1
			    fi
			fi
		fi
		if [ $doit ]
		then
			echo "Symlink $hf"
			# Convert to a relative path.
			REAL=`realpath $PWD/$file`
			REALHF=`realpath $HOME`
			RPATH=`relpath $REALHF $REAL`
			#echo "HF is " $REALHF
			#echo "REAL IS " $REAL
			#echo "RPATH IS " $RPATH
			ln -fs $RPATH $hf || exit 1
	 	fi
	 fi
done
