#!/bin/bash
#variável de ambiente IFS - Inter Field Separator, separador default entre dois campos
#por padrão é o espaço em branco
oldIFS=$IFS #salva a variável atual
IFS=: #altera para ":"
numUser=$1
# verifica se os parâmetros foram informados
if [[ $# -ne 1 ]]; then
	echo "Entrada inválida!"
	exit
fi
tamHomes=$(cat /etc/passwd | #envia linha a linha para o while resultado do comando é salvo na variável "tamHomes"
while read userName pass uId gId name homeDir shIni; do #atribui a cada variavel um campo,separados por ":", do passwd 
	#identifica os usuários que não fazem login
	if [[ $shIni =~ (/.*/.*/nologin|/.*/false|/.*/sync) ]]; then
		continue
	fi
	du -d 0 $homeDir 2> /dev/null | cut -f1 -d"	"
done | tr '\n' ' ')
usersList=$(cat /etc/passwd | #envia linha a linha para o while resultado do comando é salvo na variável "usersList"
while read userName pass uId gId name homeDir shIni; do #atribui a cada variavel um campo,separados por ":", do passwd 
	#identifica os usuários que não fazem login
	if [[ $shIni =~ (/.*/.*/nologin|/.*/false|/.*/sync) ]]; then
		continue
	fi
	echo $userName
done | tr '\n' ' ') #subistitui os <ENTER> por "espaço"
IFS=$oldIFS #retorna o ISF para o valor padrão
read -a vetTamHomeDir <<< $(echo $tamHomes) #carrega os valores da variável "tamHomes" no vetor "vetTamHomeDir"
read -a vetUserName <<< $(echo $usersList) #carrega os valores da variável "usersList" no vetor "vetUserName"
tam=${#vetTamHomeDir[@]}

			# ALGORÍTMO DE ORDENAÇÃO, PREENCHE UM VETOR AUXILIAR DE POSIÇÕES

for(( i = 0; i < $tam; i++ )); do #inicializa todas as posições com zero do vetor posição
	indexPos[$i]=0
done

for(( i = 0; i < $tam; i++ )); do 
    for(( j= $i+1; j < $tam; j++ )); do
        if [[ ${vetTamHomeDir[$i]} -lt ${vetTamHomeDir[$j]} ]]; then
            indexPos[$i]=$((${indexPos[$i]}+1))
        else
            indexPos[$j]=$((${indexPos[$j]}+1))
        fi
    done
done
for(( i=0; i < $numUser; i++ )); do #imprime o resultado usando como base o vetor posição
    echo -e "${vetUserName[${indexPos[$i]}]} ${vetTamHomeDir[${indexPos[$i]}]}"
done