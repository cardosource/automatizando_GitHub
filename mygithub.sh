#! /bin/bash 
export USER_NAME="git-cardoso"
export TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
#https://github.com/settings/tokens


usuario=$USER 
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' 
BOLD=`tput bold`
NBOLD=`tput sgr0`
echo -e "\n${RED}-${NC}-----------------------------------------"
printf   "${RED}|_${NC}${BLUE}....${NC} Ola : ${BOLD} %-50s ${NBOLD}\n" "$usuario"
echo -e  "${RED}|_${NC}${BLUE}......${NC} Distribuição : \033[1m `cat /etc/issue |  cut -c 1-5`\033[0m"
echo -e  "${RED}|_${NC}${BLUE}........${NC} Git : \033[0m \033[1m `git --version`\033[0m"
echo -e "${RED}-${NC}-----------------------------------------"
echo -e "\n\n"
printf   "${RED}${BOLD}.${NBOLD}${NC}${BLUE}....${NC}Pressione a tecla  `tput bold` %-50s `tput sgr0`\n" "ENTER"
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
echo -e "\n"

function upload(){
git add LICENSE
echo -e "${RED}|${NC}\n${RED}|_${NC}${BLUE}.${NC} Informação commit : "
read commits
git commit -m "${commits}"
git branch -M main
git remote add origin "git@github.com:${USER_NAME}/${NOME_PROJETO}.git"
git push -u origin main

}
function existente_repositorio_github(){
  echo -e "  ${RED}|_${NC} ${BLUE}.${NC} Escreva o nome do repositorio"
  read  NOME_PROJETO 
  export progeto=${NOME_PROJETO}
  
}
function criar_repositorio_github(){
  
          echo -e "  ${RED}|_${NC} ${BLUE}.${NC} Escolha o melhor nome :)"
          read -p "Por gentileza escreva o nome que dara ao novo repositorio  : " NOME_PROJETO 
          read -p "Do repositorio nomeado de ${NOME_PROJETO} faça uma descrição : " DESCRICAO 
          curl \
              --header "Content-type: application/json" \
              --request POST \
              -H 'Authorization: token '$TOKEN \
              -d '{"name":"'"$NOME_PROJETO"'","description":"'"$DESCRICAO"'"}'\
              https://api.github.com/user/repos #> /dev/null
          export progeto=${NOME_PROJETO}
   
 

              
 }

 gitinit=`git init`

if [[ "$gitinit" == *"Initialized"* ]];
 then
  echo "git iniciado"
  else
  
   echo -e "${RED}[${NC} ${BLUE}GIT${NC} ${RED}]${NC} - Sistema de controle de versão\n${RED}|_${NC} ${BLUE}.${NC} O git havia sido iniciado  anteriormente.\n" \
   "  ${BLUE}|_ ${NC}${RED}.${NC} não é possivel iniciar 2 vezes no mesmo diretorio"
   echo -e "\t Vamos remover o git e reiniciar um novo :\n "\
         "\t\t ${BLUE}'${NC}${BOLD}sim${NBOLD}${BLUE}'${NC}  ou pressione ${BLUE}'${NC}${BOLD}ENTER${NBOLD}${BLUE}'${NC} para continuar..."
     read  removergit 
       if [[ $removergit == "sim" ]];
        then
          rm -rf .git
          echo -e "\n${RED}|_${NC} ${BLUE}.${NC} Removido \n " \
          " ${BLUE}|_ ${NC}${RED}.${NC} iniciado git"  
          git init > /dev/null
          echo -e "\n"
      fi
fi


arquivos=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'`
gitignore=`git status | grep    '[\.]gitignore'`

adicionarArquivo(){
   git add $1
  
   if [ $? -eq 0 ]
then
:
else
  echo "Não existem arquivos novos!" 
  exit 1
  
fi
  
    # if [[  "${rrr}" = *"any"* ]];
    #   then
    #   echo "nada bem"
    #   else
    #   echo "td bem"
    # fi
    #  echo "fatal: pathspec 'new' did not match any file... a"
     
    #  git add $1
    #  git add LICENSE
    
    
   }
solicitar(){
    wget $1  > /dev/null 2>&1
}

license(){

  case $1 in
   1 )
   curl https://gist.githubusercontent.com/git-cardoso/afd20b1defa12781ae5fa2984d269c6a/raw/f3ac66272b1313893459d7355662b494e1e9990a/mit.sh |sh  ;;
   
   2 ) 
   solicitar https://www.gnu.org/licenses/lgpl-3.0.txt;;

   
   3 ) 
   solicitar http://www.apache.org/licenses/LICENSE-2.0.txt ;;

   4 ) 
   solicitar https://libevent.org/LICENSE.txt ;;
     
   
   esac
   
   }
   

function iniciandoTrabalhos(){
  
  echo -e "\n"
  echo -e "${RED}|_${NC}${BLUE}.${NC}  Adicionar LICENSE sim/nao : "
  #read -p "|_. Adicionar LICENSE sim/nao : " adicionarlicense 
  read adicionarlicense
 
  if [[ $adicionarlicense == "sim" ]];
      then
         echo -e  "${BLUE}1${NC}${RED} - ${NC}MIT\n${BLUE}2${NC}${RED} - ${NC}GPL v3\n${BLUE}3${NC}${RED} - ${NC}Apache 2.0\n${BLUE}4${NC}${RED} - ${NC}BSD"
         echo -e "\t${RED}(${NC}Escolha uma licença pelo número correspondente${RED})${NC}"
         read  license
        license $license
        mv LICENSE.txt LICENSE > /dev/null 2>&1
        mv lgpl-3.0.txt LICENSE > /dev/null 2>&1
        mv LICENSE-2.0.txt LICENSE > /dev/null 2>&1
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
   arquivosPendentes
   
  for  indice in  $arquivos
  do
    
   #primeira chamada
   echo -e "${RED}|_${NC}${BLUE}.${NC} Adicionado - Arquivo :  ${RED}$indice${NC}"
   adicionarArquivo "$indice"
  done
     
 echo -e "${RED}|_${NC}${BLUE}.${NC} ${BOLD}Construir${NBOLD} um repositorio ${BLUE}\033[1m NOVO ${NC} sim ou nao" 
 read criado_repositorio
 if  test "$criado_repositorio" = "sim" 
        then
        criar_repositorio_github
        echo -e "\t${RED}(${NC}${BLUE} \033[1m https://github.com/${USER_NAME}/${NOME_PROJETO}${NC} \033[0m${RED})${NC}"
        upload
  else
  echo -e "${RED}|_${NC}${BLUE}.${NC} Usar um  repositorio ${BLUE}\033[1m EXISTENTE ${NC} sim ou nao" 
 read disponivel
 if  test "$disponivel" = "sim" 
        then
        existente_repositorio_github
        echo -e "\t${RED}(${NC}${BLUE} \033[1m https://github.com/${USER_NAME}/${NOME_PROJETO}${NC} \033[0m${RED})${NC}"
        upload
 else  
    echo -e "\t${RED}(${NC}${BLUE} \033[1m TAREFA CONCLUIDA${NC} \033[0m${RED})${NC}"       
   fi
fi



        
 }
 

function arquivosPendentes(){
  

   for  indice in  $arquivos
    do
    novo=`git status | grep   $indice| cut -c 12-50`
    
    
    if  test "$indice" = "new"
     then
     
      quantidade_arquivos_novos=`git status | grep   $indice | cut -c 2-4 | wc -l`
      echo -e "${RED}|_${NC}${BLUE}.${NC} ${RED}${BOLD}ATENÇÃO${NBOLD}${NC} nesse local há  ${RED}$quantidade_arquivos_novos${NC} arquivos esperando continuidade são eles:"
       echo -e "\n${BLUE}**${NC}${RED}$novo${NC}"
     echo -e "${RED}|_${NC}${BLUE}.${NC} ${RED}${BOLD}Resetar${NBOLD}${NC} ou continuar sim ou nao :" 
     read resetar
     
      if  test "$resetar" = "sim" #nao ta funcionadno

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


iniciandoTrabalhos




    #  fi

     
