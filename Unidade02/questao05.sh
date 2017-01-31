#!/bin/bash

pid=$1
if [ -z $pid ]; then
#Verifica se foi passado algum parâmetro
	echo "Falta de parâmetro!"
	exit
elif [ -z $(ps aux | tr -s " " | cut -f2 -d" " | grep -m1 $pid) ]; then
#Verifica se o processo existe
	echo "PID inexistente!"
	exit
fi
hora=`ps aux | tr -s " " | grep -m1 $pid | cut -f9 -d" " `
horaEpochPidStart=`date +"%s" -d "$hora"`
horaEpochNow=`date +"%s"`
horaDiff=`bc <<< $horaEpochNow-$horaEpochPidStart`
tempoTotal=`bc <<< $horaDiff/60`
echo "$tempoTotal minutos"
if [[ $tempoTotal -ge 60 ]]; then
	echo "O processo $pid encontra-se em execução a mais de uma hora"
	exit
else
	echo "O processo $pid encontra-se em execução a menos de uma hora"
fi