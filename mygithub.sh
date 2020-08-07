#! /bin/bash -x
# mygithub.sh ssh file ou subirprojeto ssh [file...]
#simples script auxiliar

up=`shuf -i 1-19 -n 1`
m=`shuf -i 1-9 -n 1`

echo "Init `git init`"
for i in $*
do
if [ "$i" = "${1}" ]; then
    echo ">>> Local/Remoto `git remote add origin ${i}`"
else
    echo "+++ Append file `git add ${i}`"
fi
done

echo "*** Marked `git commit -am "dev"`"

echo " ^^^ Up `git push -u origin master`"

echo "<<>> Tag" `git tag -a 1.${m}.${up} -m "modified"`
echo "..^.. Up `git push -u origin master --tags`"
