#!/bin/bash
#Um dia tem 86400 segundos
#Data Epoch segundos desde 00:00:00 de 01/01/1970
diaSeg=86400
dataEpochAtual=`date +"%s"` #Atribui data Epoch atual
numDias=`sudo cat /etc/shadow | grep "$LOGNAME" | cut -f3 -d:`	#Atribui número de dias do arquivo shadow
dataMod=`date -d "1970-01-01 +$numDias days" +"%d de %b de %Y"` #Atribui a data calculada da modificaçãao da senha
dataEpochModif=$((numDias*diaSeg)) #Atribui transformação de dias em segundos, cálculo da data Epoch para o dia de modificação
diasModif=$(((dataEpochAtual-dataEpochModif)/diaSeg)) #Atribui cálculo de quantos dias passaram da data de modificação
#dataMod=`date -d @$segDataModi`
#!/bin/bash
echo "UID do usuário atual: $UID"
echo "Nome do usuário logado: $LOGNAME"
echo "Data da última modificação da senha: $dataMod"
echo "Se passaram $diasModif dias desde a última modificação"