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
#MENU
echo -e "1 - Incluir atividade\n2 - Editar atividade\n3 - Apagar atividade\n4 - Atividades do dia\n5 - Todas Atividades"
read opMenu
if [[ $opMenu != [1-5] ]]; then
	echo "Insira um valor válido!"
	exit
fi
case $opMenu in
	1 )
		echo "Inserir atividade no formato: dd/mm/aaaa hh:mm - Atividade"
		read entrada
		#retira o excesso de espaços em branco
		entrada=`echo "$entrada" | tr -s " "`
		#pega a data
		data=`echo "$entrada" | cut -f1 -d" "`
		#verifica se adata está no formato correto
		if [[ $data =~ (0[1-9]|[1-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/20[0-9]{2} ]]; then
			#reordena os campos da data para o formato entendido pelo comando date, de ddmmaaaa -> aaaammdd
			dataTemp=`echo "$data" | sed 's/\(0[1-9]\|[1-2][0-9]\|3[0-1]\)\/\(0[1-9]\|1[0-2]\)\/\(20[0-9]\{2\}\)/\3\2\1/'`
			#Valida, formata e insere dia da semana
			data=`date +"%d/%m/%Y - %a -" -d"$dataTemp" 2>> /dev/null`
			#verifica se a data é válida
			if [[ $? -gt 0 ]]; then
			#se a data informada estiver incorreta
				echo "Data incorreta!"
				exit
			fi
		else
			echo "Data com formato inválido!"
			exit
		fi
		resEnt=`echo "$entrada" | sed 's/\(0[1-9]\|[1-2][0-9]\|3[0-1]\)\/\(0[1-9]\|1[1-2]\)\/\(20[0-9]\{2\}\)//'`
		echo "$data$resEnt" >> $nomeArqAgenda
		sort -n -t/ -k2 $nomeArqAgenda | sort -n -t/ -k3 --output=$nomeArqAgenda;;
	2 )
		echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
		#exibe 
		cat -n $nomeArqAgenda
		numLinhasArquivo=`wc -l $nomeArqAgenda | cut -f1 -d" "`
		if [[ $numLinhasArquivo -eq 0 ]]; then
			echo "Agenda vazia, nada para EDITAR"
			exit
		fi
		echo "Insira o número da atividade que deseja EDITAR"
		read numAtividade
		#Verifica a validade do número digitado
		if [[ $numAtividade != [1-$numLinhasArquivo] ]]; then
			echo "Insira um valor válido!"
			exit
		fi
		#Imprime só a linha selecionada
		sed -n "$numAtividade p" $nomeArqAgenda
		#Sub menu EDITAR
		echo -e "1 - Editar DATA\n2 - Editar HORA\n3 - Editar ATIVIDADE\n4 - CANCELAR"
		read opSubMenu
		#Valida opção submenu
		if [[ $opSubMenu != [1-4] ]]; then
			echo "Insira um valor válido!"
			exit
		fi
		case $opSubMenu in
			1 )
				echo "Inserir DATA no formato: dd/mm/aaaa"
				read data 
				#verifica se adata está no formato correto
				if [[ $data =~ (0[1-9]|[1-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/20[0-9]{2} ]]; then
					#reordena os campos da data para o formato entendido pelo comando date, de ddmmaaaa -> aaaammdd
					dataTemp=`echo "$data" | sed 's/\(0[1-9]\|[1-2][0-9]\|3[0-1]\)\/\(0[1-9]\|1[0-2]\)\/\(20[0-9]\{2\}\)/\3\2\1/'`
					#Valida, formata e insere dia da semana
					data=`date +"%d/%m/%Y - %a -" -d"$dataTemp" 2>> /dev/null`
					#verifica se a data é válida
					if [[ $? -gt 0 ]]; then
					#se a data informada estiver incorreta
						echo "Data incorreta!"
						exit
					fi
					#remove a data da atividade escolhida
					subStringTemp=`sed -n "$numAtividade p" $nomeArqAgenda | cut -f3,4 -d"-"`
					sed -i "$numAtividade d" $nomeArqAgenda
					echo "$data$subStringTemp" >> $nomeArqAgenda
					#ordena as entradas do arquivo
					sort -n -t/ -k2 $nomeArqAgenda | sort -n -t/ -k3 --output=$nomeArqAgenda
				else
					echo "Formato inválido!"
					exit
				fi
				echo "Registro EDITADO com sucesso!"
				echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
				cat -n $nomeArqAgenda;;
			2 )
				echo "Inserir HORA no formato: hh:mm"
				read hora
				if [[ $hora =~ ([0-1][0-9]|2[0-3]):([0-5][0-9]) ]]; then
					#substitui o campo hora
					stringTemp=`sed -n "$numAtividade p" $nomeArqAgenda | sed "s/\([0-1][0-9]\|2[0-3]\):\([0-5][0-9]\)/$hora/"`
					sed -i "$numAtividade d" $nomeArqAgenda
					echo "$stringTemp" >> $nomeArqAgenda
					#ordena as entradas do arquivo
					sort -n -t/ -k2 $nomeArqAgenda | sort -n -t/ -k3 --output=$nomeArqAgenda

				else
					echo "hora inválida!"
					exit
				fi
				echo "Registro EDITADO com sucesso!"
				echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
				cat -n $nomeArqAgenda;;
			3 )
				echo "Inserir ATIVIDADE"
				read atividade
				stringTemp=`sed -n "$numAtividade p" $nomeArqAgenda | cut -f1-3 -d"-"`
				sed -i "$numAtividade d" $nomeArqAgenda
				echo "$stringTemp - $atividade" | tr -s " " >> $nomeArqAgenda
				#ordena as entradas do arquivo
				sort -n -t/ -k2 $nomeArqAgenda | sort -n -t/ -k3 --output=$nomeArqAgenda
				echo "Registro EDITADO com sucesso!"
				echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
				cat -n $nomeArqAgenda;;
			4 )
				exit;;
			* )
				exit;;
		esac;;
	3 )
		echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
		cat -n $nomeArqAgenda
		numLinhasArquivo=`wc -l $nomeArqAgenda | cut -f1 -d" "`
		if [[ $numLinhasArquivo -eq 0 ]]; then
			echo "Agenda vazia, nada para DELETAR"
			exit
		fi
		echo "Insira o número da atividade que deseja DELETAR"
		read numAtividade
		if [[ $numAtividade != [1-$numLinhasArquivo] ]]; then
			echo "Insira um valor válido!"
			exit
		fi
		sed -i "$numAtividade d" $nomeArqAgenda
		echo "Atividade REMOVIDA com sucesso"
		echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
		cat -n $nomeArqAgenda;;
	4 )
		echo "Insira uma data no formato: dd/mm/aaaa, para listar as atividades do dia."
		read dataEnt
		grep $dataEnt $nomeArqAgenda
		if [[ $? -gt 0 ]]; then
			echo "Não existe agendamentos para a data informada"
			exit
		fi;;
	5 )	echo -e "NÚMERO \tDATA \t\t   HORA    ATIVIDADE"
		cat -n $nomeArqAgenda;;
	* ) exit;;
esac
