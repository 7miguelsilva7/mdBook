(
echo 'Executando tarefa, aguarde... '

ls --format single-column >lista.txt 

for i in `cat lista.txt`
do
mkdir $i
done

sleep 1
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

