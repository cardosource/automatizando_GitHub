#! /bin/bash 

export USER_NAME="git-cardoso"
usuario=$USER 

export TOKEN="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"
#https://github.com/settings/tokens



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
printf   "${RED}${BOLD}.${NBOLD}${NC}${BLUE}....${NC}Entre com sua `tput bold` %-50s `tput sgr0`\n" "SENHA"
eval "$(ssh-agent)" > /dev/null
ssh-add ~/.ssh/id_rsa
ssh -T git@github.com
echo -e "\n"


function inicio(){

    init=`git init`

if [[ "$init" == "Initialized"* ]];
 then
      arquivos_disponiveis=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'` 
     
    return 0
else
   return 1
  fi
}




function estado_atual(){
   
    inicio
    if test $? = 0    
      then
        echo -e "${RED}${BOLD}[${NBOLD}${NC}  GIT ${RED}${BOLD}]${NBOLD}${NC} "
        arquivos=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'`
        gitignore=`git status | grep    '[\.]gitignore'`
       iniciandoTrabalhos
    else
         echo -e "${RED}${BOLD}[${NBOLD}${NC}  GIT ${RED}${BOLD}]${NBOLD}${NC} "
         arquivos=`git status | grep   '[[:alpha:]]\.py\|\.c\|\.sh\|\.java\|\.md\|\.txt|\.cpp'`
         arquivosPendentes        
    fi
}


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


adicionarArquivo(){

   git add $1
   echo -e "${RED}|_${NC}${BLUE}.${NC} Adicionado - Arquivo :  ${RED}$1${NC}"   
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
  
  echo -e "${RED}|_${NC}${BLUE}.${NC}  Adicionar LICENSE sim/nao : "
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

     echo -e "${RED}|_${NC}${BLUE}.${NC}  Criar gitignore: sim ou nao "
     echo -e "${RED}|_${NC}${BLUE}.${NC} Ao utilizar sera apresentado visualizador less, pressionando a tecla ${RED}v${NC} abrira o editor padrão para acrescentar extensões indesejadas "
     read adicionargitignore
     if [[ $adicionargitignore == "sim" ]];
      then
          echo "criado"
          touch .gitignore
          less .gitignore
   
   
   fi
     
  for  indice in  $arquivos
  do 
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

   a_add=`git status | grep -c  'new'`
   m_modified=`git status | grep -c  'modified'`
  if test $a_add  -ge  1 || test $m_modified  -ge  1
        then
        echo -e "${RED}|_${NC}${BLUE}.${NC} ${RED}${BOLD}ATENÇÃO${NBOLD}${NC} nesse local há  ${RED}$a_add${NC} arquivos esperando continuidade" # fazer alguma coisa caso apenas usar 

        if test $m_modified  -ge  1
          then
            echo -e "${RED}|_${NC}${BLUE}.${NC} ${RED}${BOLD}ATENÇÃO${NBOLD}${NC} nesse local há  ${RED}$m_modified${NC} modificado\n${RED}|${NC}"
            echo -e "${RED}|_${NC}${BLUE}.${NC} Adicionar as modificações sim ou nao"
            read up_arquivo
            if  test "$up_arquivo" = "sim"
              then 
                echo -e "${RED}|_${NC}${BLUE}.${NC} ${RED}${BOLD}[${NBOLD}${NC} ${BLUE}Modified${NC} ${RED}${BOLD}]${NBOLD}${NC}"
                for  alterado in  $arquivos
                  do
                    arq=`git status | grep   $alterado | cut -c 12-50`
                    if  test "$alterado" = "modified:"
                      then
                        echo -e "\n${BLUE}**${NC}${RED}$arq${NC}"
                    
                          for mods in $arq
                            do 
                              adicionarArquivo "$mods"
                            upload
                      
                          done
                        break
                    fi
              done
          else
          echo "tchau"
          fi



        else

          echo -e "${RED}|_${NC}${BLUE}.${NC} Resetar sim \n${RED}| ${NC}${BOLD}Enter${NBOLD} para continuar"
          
          read resetar
        
        if  test "$resetar" = "sim"
          then
            rm -rf .git
        else
        
          for  c in  $arquivos
            do
              ct=`git status | grep   $c| cut -c 12-50`
              
              for continue_normalmente in $ct
                do

                adicionarArquivo "$continue_normalmente"
                upload
                
                done
              
                break
                
            done
        fi


        fi
    else
       echo "nao a nada"
    fi
}

estado_atual
