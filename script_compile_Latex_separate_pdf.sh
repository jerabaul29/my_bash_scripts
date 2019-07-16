pdflatex nn_flow_2d.tex
bibtex nn_flow_2d.aux
pdflatex nn_flow_2d.tex
pdflatex nn_flow_2d.tex

now=$(date +"%Y_%m_%d_%H_%M_%S")
filename="v_"${now}"_"$(whoami)".pdf"

echo " "
echo " "
echo " "
echo " "
echo " "
echo "copy pdf to:"
echo "${filename}"

cp nn_flow_2d.pdf pdfs/${filename}

echo "done copy"
echo " "

nbr_ls=$(ls -l pdfs/ | wc -l)
echo "currently ${nbr_ls} pdfs"

if [ ${nbr_ls} -gt 10 ]
    then
        echo "a bit of cleaning now..."
        nbr_rmv=`expr $nbr_ls - 10`
        to_rmv=$(ls pdfs/ | sort | head -${nbr_rmv})
        echo "remove:"
        echo "${to_rmv}"
        
        for crrt_rmv in ${to_rmv}
        do
            # echo "pdfs/${crrt_rmv}"
            rm pdfs/${crrt_rmv}
        done
    fi
