#!/bin/bash

MENOR=100
MAIOR=1000
ARQUIVO=$1
if [ -z $1 ]; then
#Verifica se foi passado algum parâmetro
	echo "Falta de parâmetro!"
	exit
elif [ -z $(ls $1) ]; then
#Verifica se o usuário passado existe
	echo "Arquivo não encontrado!"
	exit
fi
TAM=`bc <<< $(ls -la $1 | tr -s " " | cut -f5 -d" ")/1000`
if (( $TAM < $MENOR )); then
	echo "PEQUENO"
elif (( $TAM > $MAIOR )); then
		echo "GRANDE"
	else
		echo "MEDIO"
fi