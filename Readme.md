# My bash scripts

This folder contains a few bash scripts I use on my machines. You can read a bit more about some of those scripts here: https://folk.uio.no/jeanra/Informatics/increasing_bash_productivity.html .

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

The *hg* and *hx* functions can be made available by putting the following in the bashrc (you will need to adapt your paths):

 ```
alias hg='/home/jrlab/Desktop/Git/MyBashScripts/histg.sh'
. /home/jrlab/Desktop/Git/MyBashScripts/histx.sh
 ```

## zg.sh and zx.sh

While I love using *z*, sometimes I wish I get to see all results that match a search and easily choose one of them. To do this, I have implemented a script (*zg.sh*) and a function (*zg.z*) that work on the same model as *histg* and *histx*.

To use them easily, simply:

- install z, see: https://github.com/rupa/z
- add to your bashrc (you will need to adapt your paths to where you put the scripts):

```bash
# use z
. /home/jrmet/Desktop/Git/z/z.sh

# my zg and zh scripts
alias zg='/home/jrmet/Desktop/Git/MyBashScripts/zg.sh'
. /home/jrmet/Desktop/Git/MyBashScripts/zx.sh
``` 

In addition, you will need to set the right values for the following paths:

- in *zg.sh*: PATH_Z_DATABASE, PATH_TO_SAVELAST
- in *zx.sh*: PATH_TO_SAVELAST

Then, the use in terminal is trivial:

```
jrlab@jrlab-T150s:~$ zg git bash
   1  /home/jrlab/Desktop/Git/MyBashScripts
jrlab@jrlab-T150s:~$ zx 1
cd /home/jrlab/Desktop/Git/MyBashScripts
jrlab@jrlab-T150s:~/Desktop/Git/MyBashScripts$ 
```

## vim-manual

A simple one liner script to open manual pages with vim in read only mode.

Example of use:

```
vn grep
```

To enable this one, I put the following alias in my .bashrc:

```
alias vn="/home/jrlab/Desktop/Git/MyBashScripts/vim_manual.sh"
```
