#!/bin/bash

MINUTO=60
HORA=3600
DIA=86400
ANO=31536000
usuario=$1
if [ -z $usuario ]; then
#Verifica se foi passado algum parâmetro
	echo "Falta de parâmetro!"
	exit
elif [ -z $(grep -w ^$usuario /etc/passwd | cut -d: -f 1) ]; then
#Verifica se o usuário passado existe
	echo "Usuário $usuario não encontrado"
	exit
fi
last -w -F $usuario | grep -e still -e gone &> /dev/null
if [ $? -eq 0 ]; then
#verifica se o usuário está logado
	echo "O usuário encontra-se logado"
	exit
fi
dataUltLogon=`last -w -F $usuario | tr -s " " | cut -f2 -d"-" | sed 's/^ *//' | sed -n 1p |cut -f1-5 -d" "` 
dataEpochLogon=`date -d"$dataUltLogon" +"%s"`
dataEpochAgora=`date +%s`
dataDiff=`bc <<< $dataEpochAgora-$dataEpochLogon`
if (( $dataDiff < $ANO )); then
	echo "Último logon foi a menos de um ano!"
elif (( $dataDiff > $ANO )); then
		echo "Último logon foi a mais de um ano!"
fi