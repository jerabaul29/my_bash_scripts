# My bash scripts

This folder contains a few bash scripts I use on my machines.

To add a bash script to the terminal:

- Make it executable, for example:
```
chmod +x script_prepare_figures
``` 

- Create an alias, for example adding to your .bashrc:
```
alias script_prepare_figures='/home/jrlab/Desktop/Git/MyBashScripts/script_prepare_figures.sh'
```

## script_prepare_figures.sh

A script to trim, convert to pdf, and reduce size of images. Useful to run for example on the /Figures folder of a LaTex project.

## script_compile_latex.sh

A script to compile a LaTex project including references and diff file. To avoid multiple repetitive pdflatex, bibtex and diff commands. The main file to compile should be called mainfile.tex. The previous version on which to compute the diff should be called previous.tex.

## histg.sh and histx.sh

A couple of scripts to easily search through commands in the history, and call them.

- *histg* can be used to **history grep**. In addition, multiple instances of a command are removed, the commands get ordered by time of use, and a command number is added for working with *histx*.

- *histx* can be used to execute a command found with *histg*, using the *histg* command number.

NOTE: those commands fulfill the needs I have, but can be improved: see the *TODO*s in the *histg.sh* and *histx.sh*. In addition, at installation, you will need to set the following parameters by hand:

- *histg.sh*: HISTSIZE, HISTFILE, PATH_TO_SAVELAST
- *histx.sh*: PATH_TO_SAVELAST

Example of use (I have set hg as an alias of histg and hx as an alias of histx; enter at end of line):

```
jrlab@jrlab-T150s:~/Desktop/Git/Example_Debug_Macros_arduino/src$ hg g++ src success
   1  16053  cat src.ino > src.cpp && g++ -E -P -DPREPROCTEST src.cpp > src.i && rm src.cpp && echo "success"
   2  16054  hg g++ src success
jrlab@jrlab-T150s:~/Desktop/Git/Example_Debug_Macros_arduino/src$ hx 1
success
```

NOTE: in order for all commands to work (also those that should be executed in the corresponding shell and not a subshell, for example *cd*), the aliases could be something of the kind:

```
alias hg='. /home/jrlab/Desktop/Git/MyBashScripts/histg.sh'
alias hx='. /home/jrlab/Desktop/Git/MyBashScripts/histx.sh'
```

But this creates more problems than it fixes; therefore, I keep the aliases as:

```
alias hg='/home/jrlab/Desktop/Git/MyBashScripts/histg.sh'
alias hx='/home/jrlab/Desktop/Git/MyBashScripts/histx.sh'
```

and I use other scripts (for example, the excellent *z*) for cd-ing.
