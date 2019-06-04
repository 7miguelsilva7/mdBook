#!/bin/bash

(
echo 'Executando tarefa, aguarde... '
cd /opt/lampp/htdocs/mdBook

data=`date +%Y-%m-%d`
killall gedit


arquivo=$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS
XTERM="xterm"

### Localizando e abrindo o arquivo
entra=`zenity --title="Selecione o arquivo de texto" --file-selection --file-filter="*.*"`

soffice --writer $entra

gedit book.toml
 
rm -r src/*

cp $entra src/
rename 's/-/ /g' src/*.odt


gitbook-convert src/* src/

gedit src/SUMMARY.md
gedit src/README.md


source book.toml

#Inicio janela condicional
if zenity --width 300 --height 100 --question --text="Deseja realemente substituir livro em Leitura Cristã?"; then
#comando caso resposta positiva

rm /opt/lampp/htdocs/leituracrista/content/$bookdir.md

echo "" > /opt/lampp/htdocs/leituracrista/content/$bookdir.md
sed -i "s/^/---\ndate: $data\nslug: $type\/$subtype\/$bookdir\/\ntitle: $title\nauthor: $authors\nthumbnail: images\/$bookdir.png\ntags: $authors\ncategories: $cat\n---/" /opt/lampp/htdocs/leituracrista/content/$bookdir.md

#cp /opt/lampp/htdocs/leituracrista/content/default.md~ /opt/lampp/htdocs/leituracrista/content/$bookdir.md

#sed -i "s/\$data/$data/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i "s/\$type/$type/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i "s/\$subtype/$subtype/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i "s/\$bookdir/$bookdir/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i "s/\$authors/$authors/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i "s/\$cat/$cat/g" /opt/lampp/htdocs/leituracrista/content/$bookdir.md

#sed -i 's/\/\//\//g' /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i 's/\[//g' /opt/lampp/htdocs/leituracrista/content/$bookdir.md
#sed -i 's/\]//g' /opt/lampp/htdocs/leituracrista/content/$bookdir.md
else
#comando caso resposta negativa
  echo "no";
fi
#Fim janela condicional

sleep 2
rm -r book/*

mkdir book/$bookdir

cp comandoEmPastas.sh src/

cd src/
bash comandoEmPastas.sh
sed -i 's/{#.*}//g' *.md
echo "<!-- Go to www.addthis.com/dashboard to customize your tools -->
<script type=\"text/javascript\" src=\"//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-59d4445a35d0aa43\"></script>
" >> *.md

cd ..
mdbook build -d book/$bookdir/

sed -i 's/src\=\"custom\.js\"//g' book/$bookdir/print.html
cd book/$bookdir/

sed -i "s/<\/body>/<script type\=\"text\/javascript\" src\=\"\/\/s7\.addthis\.com\/js\/300\/addthis\_widget\.js\#pubid\=ra\-59d4445a35d0aa43\"><\/script>/" *.html
bash comandoEmPastas.sh

cd ..
cd ..

# sed -i 's/{#.*}//g' book/$bookdir/*.html

mkdir /opt/lampp/htdocs/livros/$type
mkdir /opt/lampp/htdocs/livros/$type/$subtype
mkdir /opt/lampp/htdocs/livros/$type/$subtype/$bookdir


# mkdir /opt/lampp/htdocs/livros/$bookdir/$type/$subtype

# cp -r book/$bookdir/* /opt/lampp/htdocs/livros/$type
# cp -r book/$bookdir/* /opt/lampp/htdocs/livros/$type/$subtype
cp -r book/$bookdir/* /opt/lampp/htdocs/livros/$type/$subtype/$bookdir
cp img/* /opt/lampp/htdocs/livros/$type/$subtype/$bookdir
cp divBol.css /opt/lampp/htdocs/livros/$type/$subtype/$bookdir

# mv book/$bookdir/ /opt/lampp/htdocs/livros/$type/

# cp -r book/$bookdir/* /opt/lampp/htdocs/livros/$type/$subtype/$bookdir
# mv book/$bookdir/ /opt/lampp/htdocs/livros/$type/$subtype

# chromium-browser /opt/lampp/htdocs/livros/$type/$bookdir/index.html && 
google-chrome /opt/lampp/htdocs/livros/$type/$subtype/$bookdir/index.html

sleep 2
) | zenity --progress --width 300 --height 100 --title "Informação do Sistema" --text "Executando tarefa, aguarde... !!!" --pulsate --auto-close

rm lock
exit


