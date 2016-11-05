#!/bin/bash
HISTFILE=~/.bash_history
set -o history
#Comandos para ativar exeecução do comando history no script
#cat "$HOME/.bash_history"
usuario=suporte
senha=suporte
data=`date +"%y%m%d"`
hora=`date +"%H%M"`
history >> history.$USER.$data.$hora
nomeArq=`ls | grep "history.$USER.$data.$hora"`
ftp -n 192.168.2.2 << Fim &> ftp.mensagens.$data
quote USER $usuario
quote PASS $senha
put $nomeArq
quit
Fim