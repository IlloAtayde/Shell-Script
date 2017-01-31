#!/bin/bash

BREVE=60
LONGO=360
USUARIO=$1
if [ -z $1 ]; then
#Verifica se foi passado algum parâmetro
	echo "Falta de parâmetro!"
	exit
elif [ -z $(grep -w ^$1 /etc/passwd | cut -d: -f 1) ]; then
#Verifica se o usuário passado existe
	echo "Usuário $1 não encontrado"
	exit
fi
dataHoraLogon=`who | grep -E "$s1.*pts"| tr -s " " | cut -f3,4 -d" "`
dataEpochLogon=`date -d "$dataHoraLogon" +"%s"`
dataEpochAgora=`date +%s`
difDataEpoch=`bc <<< $dataEpochAgora-$dataEpochLogon`
calcHoras=`bc <<< $difDataEpoch/60`
echo "Usuário logado a $calcHoras minutos"
if (( $calcHoras < $BREVE )); then
	echo "BREVE"
elif (( $calcHoras > $LONGO )); then
		echo "LONGO"
	else
		echo "NORMAL"
fi

