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

function iniciandoTrabalhos(){
   echo -e "\n"
  echo -e "Deseja usar alguma licença de uso de software : "
  read -p "[ LICENSE    ] - Adicionar LICENSE sim/nao  " adicionarlicense  
  if [[ $adicionarlicense == "sim" ]];
      then
         echo -e  "1 - MIT\n2 - GPL v3\n3 - Apache 2.0"
         read  license
          license $license 
  fi
  
  if [[ $gitignore == *"gitignore"  ]];
  then
  
   echo -e "\n-Extenções ignoradas. \n "
   cat .gitignore
   
   echo -e "----------------------\n"
   
   
   else
     echo -e "\n-Não foi encontrado  um .gitignore  não deseja ser adicionada.\n
              lembro que ao "
     read -p "[ GITIGNORE  ] sim ou nao " adicionargitignore
     if [[ $adicionargitignore == "sim" ]];
      then
          echo "criado"
          touch .gitignore
          nano .gitignore
      fi
   
   fi
  for  indice in  $arquivos
  do
   adicionarArquivo "$indice"  
   #adicionarArquivo primeira chamada
   echo "[ ADICIONADO ] - Arquivo :  $indice"
   
   

  done
         
 }
 
 function arquivosPendentes(){
  

   

}
