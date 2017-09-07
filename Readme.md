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

A script to (trim), convert to pdf, reduce size of images. Useful to run for example on the /Figures folder of a LaTex project.

## script_compile_latex.sh

A script to compile a LaTex project including references and diff file. To avoid multiple repetitive pdflatex, bibtex and diff commands. The main file to compile should be called mainfile.tex. The previous version on which to compute the diff should be called previous.tex.
