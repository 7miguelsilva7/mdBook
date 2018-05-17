#!/bin/bash

(
echo 'Executando tarefa, aguarde... '

cp comandoEmPastas.sh src/
bash src/comandoEmPastas.sh

gedit book.toml

sleep 2
rm -r book/*
mdbook build

sleep 2
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

chromium-browser book/index.html
exit
