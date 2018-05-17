(
echo 'Executando tarefa, aguarde... '

find . -maxdepth 1 -type d -empty | xargs rmdir

#Cria Pasta
ls --format single-column >arquivos.txt 
ls --format single-column >pastas.txt 
sed -i 's/.ODT//g' pastas.txt

for i in `cat pastas.txt`
do
mkdir $i
done

#juntas os arquivos
cat -n pastas.txt > pastasIndice.txt
cat -n arquivos.txt > arquivosIndice.txt
#join arquivosIndice.txt pastasIndice.txt > juntos.txt


#Move cada arquivos para sua pasta

for i in `cat juntos.txt`
do
mv $i 
done

sleep 1
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

