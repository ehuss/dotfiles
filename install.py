#!/bin/env/python

from __future__ import print_function
import sys
import os.path
import glob
import shutil

try: input = raw_input
except NameError: pass

home = os.getenv('HOME')
realhome = os.path.realpath(home)

def main():
    if os.path.dirname(sys.argv[0]) not in ('', '.'):
        print('You must run this from within the dotfiles directory.')
        return

    for filename in glob.glob('.[a-zA-Z]*'):
        if filename == '.git':
            continue
        doit = True
        hf = os.path.join(home, filename)
        if os.path.exists(hf):
            if os.path.samefile(hf, filename):
                print('%s already installed' % (filename))
                doit = False
            else:
                print('%s already exists.' % hf)
                response = input('Would you like to make a backup and replace it with a symlink? [y/n]')
                if response.lower() != 'y':
                    print('Will not overwrite.')
                    doit = False
                else:
                    shutil.move(hf, hf+'.bak')
        else:
            print('%s does not exist' % hf)
        if doit:
            # Convert to a relative path.
            CWD = os.getcwd()
            realpathname = os.path.realpath(os.path.join(CWD, filename))
            relpath = os.path.relpath(realpathname, realhome)
            print('link %s to %s' % (relpath, hf))
            if os.path.exists(hf):
                os.unlink(hf)
            os.symlink(relpath, hf)

if __name__ == '__main__':
    main()
