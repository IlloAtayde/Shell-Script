#!/bin/bash
nomeDir=$1
qntMaiores=$2
dirAtual=$PWD
#MODO COMPLICADO
#função para pesquisa recursiva
pesquisaRecursiva(){
	cd $1
	for i in * ; do
		if [[ -f $i ]]; then #se arquivo, grava nome e tamanho, em bytes, no arqContTemp 
			du -b $i >> $dirAtual/arqContTemp
		elif [[ -d $i ]]; then
			pesquisaRecursiva $i
		fi
	done
	cd ..
return		
}

# verifica se os parâmetros foram informados
if [[ $# -ne 2 ]]; then
	echo "Entrada inválida!"
	exit
# verifica se foi passado um diretório
elif [[ ! -d $nomeDir ]]; then
	echo "Informe um Diretório!"
	exit
fi
if [[ -f $dirAtual/arqContTemp ]]; then #apaga o arquivo se o mesmo já existir
	rm -rf $dirAtual/arqContTemp
fi
if [[ $(ls "$nomeDir" | wc -l) -eq 0 ]]; then
 	echo "Diretório informado encontra-se vazio!"
 	exit
fi
oldIFS=$IFS
IFS=$(echo -e "\t\n") 
pesquisaRecursiva ${nomeDir}
IFS=$oldIFS
sort -nr $dirAtual/arqContTemp 2> /dev/null | sed -n "1,${qntMaiores}p"
rm -rf $dirAtual/arqContTemp #apaga o arquivo ao final do script

#MODO SIMPLES
# ls -laRS $nomeDir | tr -s " " | sed -e '/^\./d' | sed -e '/^d/d' | cut -f5,9 -d" " | sed -e '/^$/d' | sort -n -r | sed -n "1,${qntMaiores}p" 2>> /dev/null