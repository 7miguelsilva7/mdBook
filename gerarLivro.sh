#!/bin/bash

cd /opt/lampp/htdocs/mdBook	

file=lock
if [ -e "$file" ] ; then
#caso outro livro esteja em processamento
zenity --width 300 --height 100 --info --text="Já há Um livro em processamento ou arquivo lock não deletado adequadamente, verifique se há uma operção em andamento "
else
#segue o script
echo > lock
bash script.sh
fi


