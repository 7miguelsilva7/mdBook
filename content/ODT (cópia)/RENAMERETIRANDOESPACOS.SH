#!/bin/bash
(
echo 'Executando tarefa, aguarde... '
#renomear ODT
cd odt
rename 's/\ /-/g' *.odt
rename 's/--/-/g' *.odt
rename 's/Desconhecido//g' *.odt

for a in *
do
mv -f $a `echo $a | tr "[a-z]" "[A-Z]"`
done

sleep 1
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

