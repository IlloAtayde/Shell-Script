#!/bin/bash
#Comandos para ativar exeecução do comando history no script
num=`cat arqSoma | tr ':' '\n' | tr '\n' '+' | sed 's/$/0/ ; s/+/ + /g'`
soma=$(($num))
cat arqSoma
echo "Soma de todos os números: $soma"