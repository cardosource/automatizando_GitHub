#! /bin/bash 

 gitinit=`git init`

if [[ "$gitinit" == *"Initialized"* ]];
 then
  echo "git iniciado"
  else
  
   echo -e "O git foi iniciado  anteriormente,\nnão foi possivel iniciar 2 vezes no mesmo diretorio\n"
   echo -e "Pode remover o git e reiniciar um novo :  <sim> " 
     read -p "(ou pressione a tecla Enter para continuar... ) " removergit 
       if [[ $removergit == "sim" ]];
        then
          rm -rf .git
          echo "[ git del  ] - removido"
          echo "[ novo git ] - iniciado"
          git init > /dev/null
      fi
fi


arquivos=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'`
gitignore=`git status | grep    '[\.]gitignore'`


adicionarArquivo(){
# A implementar
   
   }
license(){

  case $1 in
   1 ) touch mit ;;
   
   2 ) touch gpl;;
   
   3 ) touch apache;;
   
   esac
   
   }
