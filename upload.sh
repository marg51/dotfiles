#!/bin/bash 

x=`echo $(( $RANDOM * $$ )) | base64`
x=${x:0:5}

if [ $# -eq 0 ]; then
        file="/Users/uto/screenshots/$(ls -t ~/screenshots/ | head -n 1)"
else
        file=$1
fi
if [ ! -f "$file" ]; then
        echo "<$file> n'existe pas"
        exit
fi

echo -e "envoi de \033[01;32m$file\033[0m en cours"
scp "$file" marg51@uto.io:public_html/fs/img/$x.png

echo -e ">>>>>>>>>>>>>>> \033[01;33mhttp://i.uto.io/$x\033[0m"

#curl -X PUT -F "img=@/Users/desktop/Desktop/$(ls -t ~/Desktop/ | head -n 1)" http://dev.traduzic.com:8080/upload --progress-bar | tee -a /dev/null
