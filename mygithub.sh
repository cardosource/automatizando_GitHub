#! /bin/bash -x
# mygithub.sh ssh file ou subirprojeto ssh [file...]
#simples script auxiliar


echo "Init `git init`"
echo "Add README `git add README.md`"
for i in $*
do
if [ "$i" = "${1}" ]; then
    echo "Local/Remoto `git remote add origin ${i}`"
else
    echo "Append file `git add ${i}`"
fi
done

echo "Marked `git commit -m "dev"`"

echo "Up `git push -u origin master`"

