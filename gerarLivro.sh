#!/bin/bash

arquivo=$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
XTERM="xterm"

### Localizando e abrindo o arquivo de vídeo
entra=`zenity --title="Selecione o arquivo de texto" --file-selection --file-filter="*.*"`

soffice --writer $entra
 
rm -r src/*

cp $entra src/
rename 's/-/ /g' src/*.odt
gitbook-convert src/* src/

killall gedit

gedit book.toml

source book.toml

(
echo 'Executando tarefa, aguarde... '

#gedit book.toml

sleep 2
rm -r book/*

mkdir book/$bookdir

cp comandoEmPastas.sh src/
cd src/
sed -i 's/{#.*}//g' *.md
bash comandoEmPastas.sh
cd ..

mdbook build -d book/$bookdir/



sed -i 's/src\=\"custom\.js\"//g' book/$bookdir/print.html 

sleep 2
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

rm -r /opt/lampp/htdocs/livros/$bookdir
mv book/$bookdir/ /opt/lampp/htdocs/livros/



chromium-browser /opt/lampp/htdocs/livros/$bookdir/index.html

exit
