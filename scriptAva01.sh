#!/bin/bash
total=`ls -lha | wc -l`
diretorios=`ls -lah | grep -c "^d"`
arqPerExec=`ls -lah | grep -c "^...x"`
arqSetUid=`ls -lah | grep -c -i "^...s"`
arqComuns=`bc <<< $total-$diretorios-$arqSetUid`
echo "Total de diretórios: $diretorios"
echo "Total de arquivos comuns: $arqComuns"
echo "Total de arquivos com SETUID ligado: $arqSetUid"
echo "Total de arquivos com permição de execução para o dono: $arqPerExec"
echo "Listagem total: $total"