#!/bin/bash
usuario=$LOGNAME #Atribui nome do usuário logado
data=`date +"%y%m%d"` #Atribui data com formatação ano mês dia
mkdir -p /home/back/$usuario.$data #Cria hierarquia de diretórios
#Copia a hierarquia de diretórios e todos os arquivos de forma recursiva "R"
#do HOME do usuário, perguntando se quer sobreescrever arquivos existentes
#"i", ou atualizando somente os arquivos modificados "u"
cp -Ru $HOME /home/back/$usuario.$data
