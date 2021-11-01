#! /bin/bash 

#CRIAR REPOSITORIO
TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

function repositorio_github(){
          echo "  |_ . Escolha o melhor nome :)"
          read -p "Por gentileza escreva o nome que dara ao novo repositorio  : " NOME_PROJETO 
          read -p "Do repositorio nomeado de ${NOME_PROJETO} faça uma descrição : " DESCRICAO 
          echo $NOME_PROJETO
          echo $DESCRICAO
          curl \
             --header "Content-type: application/json" \
             --request POST \
             -H 'Authorization: token '$TOKEN \
             -d '{"name":"'$NOME_PROJETO'","description":"'$DESCRICAO'"}'\
              https://api.github.com/user/repos > /dev/null
          url="https://github.com/git-cardoso/${NOME_PROJETO}"
          
          echo "Esta pronto : ${url}"     
 }

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
  
for  indice in  $arquivos
    do
    novo=`git status | grep   $indice| cut -c 12-50`
      
    
    if  test "$indice" = "new"
     then
     
      quantidade_arquivos_novos=`git status | grep   $indice | cut -c 2-4 | wc -l`
       echo -e "\n[ ATENÇÃO ] - Há  $quantidade_arquivos_novos  esperando continuidade são eles:"
       echo "$novo"
     echo "resetar ou continuar [y/n]"
     
     read resetar
      if  test "$resetar" = "y" 
        then
         git reset --hard
        # git restore --staged $novo
         #git  rm --cached $novo
        # git rm --force  $novo
         
        echo "[ REMOVIDOS ] - Arquivos removidos : $novo" 
      else
        adicionarArquivo "$indice"
      
   fi
  break
  
  fi
done
   

}


echo "[ GITHUB ] - Criar um novo repositorio no github"
     read -p "|_ . <sim> ou <nao>  : " escolha 
     if [[ $escolha == "sim" ]];
        then
        repositorio_github
    else
      arquivosPendentes
      iniciandoTrabalhos

     fi

