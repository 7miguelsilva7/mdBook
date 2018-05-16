#!/bin/bash

(
echo 'Executando tarefa, aguarde... '

cp comandoEmPastas.sh src/
bash src/comandoEmPastas.sh

# Configurações de Livros
nomeLivro=$( zenity --entry --text "Nome do Livro" --entry-text "nomeLivro" --title "Gerando Livro")
nomeAutor=$( zenity --entry --text "Nome do Autor" --entry-text "nomeAutor" --title "Gerando Livro")

echo "[book]
authors = ['$nomeAutor']
multilingual = false
src = 'src'
title = '"$nomeLivro"'

[output.html]
additional-js = ['custom.js']

" > book.toml

sleep 1
rm -r book/*
mdbook build

sleep 1
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

chromium-browser book/index.html
exit