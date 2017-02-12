#!/bin/bash
#variável de ambiente IFS - Inter Field Separator, separador default entre dois campos
#por padrão é o espaço em branco
oldIFS=$IFS #salva a variável atual
IFS=: #altera para ":"
diaSeg=86400
numDiasRef=$1
# verifica se os parâmetros foram informados
if [[ $# -ne 1 ]]; then
	echo "Entrada inválida!"
	exit
fi
dataEpochAtual=`date +"%s"` #Atribui data Epoch atual
cat /etc/passwd | #envia linha a linha para o while
while read nomeUsuario nda0 nda1 nda2 nda3 nda4 shIni; do #atribui a cada variavel um campo,separados por ":", do passwd 
#desconsiderar as nda{0..4}
	#identifica os usuários que não fazem login
	if [[ $shIni =~ (/.*/.*/nologin|/.*/false|/.*/sync) ]]; then
		continue
	fi
	read nda5 nda6 numDias nda7 <<< "$(grep "$nomeUsuario" /etc/shadow)"
	# numDias=`cat /etc/shadow | grep "$nomeUsuario" | cut -f3 -d:`	#Atribui número de dias do arquivo shadow
	dataMod=`date -d "1970-01-01 +$numDias days" +"%d de %b de %Y"` #Atribui a data calculada da modificaçãao da senha
	dataEpochModif=$((numDias*diaSeg)) #Atribui transformação de dias em segundos, cálculo da data Epoch para o dia de modificação
	diasModif=$(((dataEpochAtual-dataEpochModif)/diaSeg)) #Atribui cálculo de quantos dias passaram da data de modificação
	if [[ $diasModif -gt $numDiasRef ]]; then
		echo "Usuário: $nomeUsuario"
		echo "Data da última modificação da senha: $dataMod"
		echo "Se passaram $diasModif dias desde a última modificação"
	fi
done
IFS=$oldIFS #retorna o ISF para o valor padrão