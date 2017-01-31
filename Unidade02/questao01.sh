#!/bin/bash

nomeArqAgenda=$1
if [ -z $nomeArqAgenda ]; then
#Verifica se foi passado algum parâmetro
	echo "Falta de parâmetro!"
	exit
elif [ ! -e $nomeArqAgenda ]; then
#Verifica se o processo existe
	echo "Arquivo inexistente! Criando arquivo..."
	touch $nomeArqAgenda
fi
echo -e "1 - Incluir atividade\n2 - Editar atividade\n3 - Apagar atividade\n4 - Atividades do dia\n5 - Todas Atividades"
read opMenu
case $opMenu in
	1 )
		echo "Inserir atividade no formato: dd/mm/aaaa hh:mm - Atividade"
		read entrada
		#retira o excesso de espaços em branco
		entrada=`echo "$entrada" | tr -s " "`
		#pega a data
		data=`echo "$entrada" | cut -f1 -d" "`
		#separa data
		dia=`echo "$data" | cut -f1 -d"/"`
		mes=`echo "$data" | cut -f2 -d"/"`
		ano=`echo "$data" | cut -f3 -d"/"`
		#resto da entrada - Hora e Atividade
		resEnt=`echo "$entrada" | sed 's/^[0-3][0-9]\/[0-1][0-9]\/[0-9]\{4\}//'`
		#formata data e insere dia da semana
		formatData=`date +"%d/%m/%Y - %a" -d"$ano$mes$dia" 2>> /dev/null`
		if [[ $? -gt 0 ]]; then
		#se a data informada estiver incorreta
			echo "Data incorreta, ajuste a data no menu Editar"
			formatData='Data inválida'
		fi
		#monta data e atividade e adiciona ao arquivo 
		echo "$formatData $resEnt" >> $nomeArqAgenda
		#ordena as entradas do arquivo
		sort -n -t/ -k2 $nomeArqAgenda | sort -n -t/ -k3 --output=$nomeArqAgenda;;
	2 )
		echo -e "NÚMERO \tDATA \t\t  HORA    ATIVIDADE"
		cat -n $nomeArqAgenda
		numLinhasArquivo=`wc -l $nomeArqAgenda | cut -f1 -d" "`
		if [[ $numLinhasArquivo -eq 0 ]]; then
			echo "Agenda vazia, nada para EDITAR"
			exit
		fi
		echo "Insira o número da atividade que deseja EDITAR"
		read numAtividade
		if [[ $numAtividade -gt $numLinhasArquivo || $numAtividade -eq 0 || $numAtividade -lt 0 ]]; then
			echo "Insira um valor válido!"
			exit
		fi
		sed -n "$numAtividade p" $nomeArqAgenda
		;;
	3 )
		echo -e "NÚMERO \tDATA \t\t  HORA    ATIVIDADE"
		cat -n $nomeArqAgenda
		numLinhasArquivo=`wc -l $nomeArqAgenda | cut -f1 -d" "`
		if [[ $numLinhasArquivo -eq 0 ]]; then
			echo "Agenda vazia, nada para DELETAR"
			exit
		fi
		echo "Insira o número da atividade que deseja DELETAR"
		read numAtividade
		if [[ $numAtividade -gt $numLinhasArquivo || $numAtividade -eq 0 || $numAtividade -lt 0 ]]; then
			echo "Insira um valor válido!"
			exit
		fi
		sed -i "$numAtividade d" $nomeArqAgenda
		echo "Atividade REMOVIDA com sucesso"
		echo -e "NÚMERO \tDATA \t\t  HORA    ATIVIDADE"
		cat -n $nomeArqAgenda;;
	4 )
		echo "Insira uma data no formato: dd/mm/aaaa, para listar as atividades do dia."
		read dataEnt
		grep $dataEnt $nomeArqAgenda
		if [[ $? -gt 0 ]]; then
			echo "Não existe agendamentos para a data informada"
			exit
		fi;;
	5 )	echo -e "NÚMERO \tDATA \t\t  HORA    ATIVIDADE"
		cat -n $nomeArqAgenda;;
	* ) exit;;
esac
#hora=`ps aux | tr -s " " | grep -m1 $pid | cut -f9 -d" " `
#horaEpochPidStart=`date +"%s" -d "$hora"`
#horaEpochNow=`date +"%s"`
#horaDiff=`bc <<< $horaEpochNow-$horaEpochPidStart`
#tempoTotal=`bc <<< $horaDiff/60`
#echo "$tempoTotal minutos"
#if [[ $tempoTotal -ge 60 ]]; then
#	echo "O processo $pid encontra-se em execução a mais de uma hora"
#	exit
#else
#	echo "O processo $pid encontra-se em execução a menos de uma hora"
##elif [[ $tempoTotal -le 5 ]]; then
##	echo "O processo $pid encontra-se em execução a menos de uma hora"
##dataUltLogon=`last -w -F $usuario | tr -s " " | cut -f2 -d"-" | sed 's/^ *//' | sed -n 1p |cut -f1-5 -d" "` 
#dataEpochLogon=`date -d"$dataUltLogon" +"%s"`
#dataEpochAgora=`date +%s`
#dataDiff=`bc <<< $dataEpochAgora-$dataEpochLogon`
#if (( $dataDiff < $ANO )); then
#	echo "Último logon foi a menos de um ano!"
#elif (( $dataDiff > $ANO )); then
#		echo "Último logon foi a mais de um ano!"
#fi
#echo "$1"
#DIALOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f3 -d" " | cut -f3 -d"-"`
#echo "DIA $DIALOGUSER"
#MESLOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f3 -d" " | cut -f2 -d"-"`
#echo "MES $MESLOGUSER"
#ANOLOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f3 -d" " | cut -f1 -d"-"`
#echo "ANO $ANOLOGUSER"
#HHMMLOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f4 -d" "`
#dataHoraLogon=`who | grep -E "$s1.*pts"| tr -s " " | cut -f3,4 -d" "`
#HORASLOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f4 -d" " | cut -f1 -d":"`
#echo "HORA $HORASLOGUSER"
#MINUTOSLOGUSER=`who | grep -E "$1.*pts" | tr -s " " | cut -f4 -d" " | cut -f2 -d":"`
#echo "MINUTOS $MINUTOSLOGUSER"
#MINTOTLOGUSER=`bc <<< $HORASLOGUSER*60+$MINUTOSLOGUSER`
#echo "MINUTOS TOTAIS $MINTOTLOGUSER"
#DATASYSNOW=`date +"%d"`
#echo "DATA AGORA $DATASYSNOW"
#DATADIF=`bc <<< $DATASYSNOW-$DIALOGUSER`
#echo "DIFERENÇA DE DIAS $DATADIF"
#HORASYSNOW=`date +"%H"`
#echo "HORA DE AGORA $HORASYSNOW"
#MINSYSNOW=`date +"%M"`
#echo "MINUTOS DE AGORA $MINSYSNOW"
#MINTOTALSYSNOW=`bc <<< $HORASYSNOW*60+$MINSYSNOW`
#echo "MINUTOS TOTAIS AGORA $MINTOTALSYSNOW"
#MINUTOSLOGDIF=`bc <<< $MINTOTALSYSNOW-$MINTOTLOGUSER`
#echo "$MINUTOSLOGDIF"
#case $MESLOGUSER in
#	01 ) MES=Jan;;
#	02 ) MES=Fev;;
#	03 ) MES=Mar;;
#	04 ) MES=Abr;;
#	05 ) MES=Mai;;
#	06 ) MES=Jun;;
#	07 ) MES=Jul;;
#	08 ) MES=Ago;;
#	09 ) MES=Set;;
#	10 ) MES=Out;;
#	11 ) MES=Nov;;
#	12 ) MES=Dez;;
#	*)	;;
#esac
#echo "$MES"
#dataEpochLogon=`date -d "$dataHoraLogon" +"%s"`
##echo "Data em segundos do logon: $dataEpochLogon"
#dataEpochAgora=`date +%s`
#difDataEpoch=`bc <<< $dataEpochAgora-$dataEpochLogon`
#calcHoras=`bc <<< $difDataEpoch/60`
#echo "Usuário logado a $calcHoras minutos"
#if (( $calcHoras < $BREVE )); then
	#echo "BREVE"
#elif (( $calcHoras > $LONGO )); then
		#echo "LONGO"
	#else
		#echo "NORMAL"
#fi

