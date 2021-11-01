#! /bin/bash 
export TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
function repositorio_github(){
          echo "  |_ . Escolha o melhor nome :)"
          read -p "Por gentileza escreva o nome que dara ao novo repositorio  : " NOME_PROJETO 
          read -p "Do repositorio nomeado de ${NOME_PROJETO} faça uma descrição : " DESCRICAO 
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
  
   echo -e "[ GIT ] - Sistema de controle de versão\n|_ .O git havia sido iniciado anteriormente.\n" \
   "  |_ . não é possivel iniciar 2 vezes no mesmo diretorio"
   echo -e "\t Vamos remover o git e reiniciar um novo :\n "\
         "\t\t 'sim'  ou pressione 'ENTER' para continuar..." 
     read  removergit 
       if [[ $removergit == "sim" ]];
        then
          rm -rf .git
          echo -e "\n|_ .Removido \n " \
          " |_ . iniciado git" 
          git init > /dev/null
          echo -e "\n"
      fi
fi


arquivos=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'`
gitignore=`git status | grep    '[\.]gitignore'`

adicionarArquivo(){
#    read -p "[ COMENTARIO ] - Adicionar um comentario : " comentario 
    add=$1
    #echo "adicionado $1"
  
    #git commit -m $comentario
    #git branch -M main
  #  read -p "Url repositories : "  remote
  #  git remote add origin $remote
   # git push -u origin main
   
   }
   
license(){

  case $1 in
   1 ) touch mit ;;
   
   2 ) touch gpl;;
   
   2 ) touch apache;;
   
   esac
   
   }
   

function iniciandoTrabalhos(){
   echo -e "\n"
  read -p "|_. Adicionar LICENSE sim/nao : " adicionarlicense  
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
      echo -e "\n"
     read -p "|_ . Usar gitignore: sim ou nao " adicionargitignore
     if [[ $adicionargitignore == "sim" ]];
      then
          echo "criado"
          touch .gitignore
          nano .gitignore
      fi
   
   fi
   echo -e "\n"
  for  indice in  $arquivos
  do
   adicionarArquivo "$indice"  
   #adicionarArquivo primeira chamada
   echo -e "|_ .Adicionado - Arquivo :  $indice"
   git add $indice
   

  done
         
 }
 
 
 
function arquivosPendentes(){
  

   for  indice in  $arquivos
    do
    novo=`git status | grep   $indice| cut -c 12-50`
    
    
    if  test "$indice" = "new"
     then
     
      quantidade_arquivos_novos=`git status | grep   $indice | cut -c 2-4 | wc -l`
       echo -e "\n|_. ATENÇÃO nesse local há  $quantidade_arquivos_novos  esperando continuidade são eles:"
       echo -e "  |\n$novo"

     read -p "|_. Resetar ou continuar sim ou nao :" resetar
     
      if  test "$resetar" = "sim" 
        then
         git restore --staged $novo
         git  rm --cached $novo
         git restore $novo
         
         #read -p "(ou pressione entender para continuar... ) " removergit          
       #  git rm --force  $novo ##
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
