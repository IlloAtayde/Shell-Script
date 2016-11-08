#!/bin/bash
#num=`cat arqSoma | tr ':' '\n' | tr '\n' '+' | sed 's/$/0/ ; s/+/ + /g'`
ls | grep "resultado" &>> log && rm resultado &>> log
ls | grep "parcelas" &>> log && rm parcelas &>> log
linha_1=$((`cat arqSoma | sed '1!d' | tr ':' '+'`))
echo "= $linha_1" >> resultado
linha_2=$((`cat arqSoma | sed '2!d' | tr ':' '+'`))
echo "= $linha_2" >> resultado
linha_3=$((`cat arqSoma | sed '3!d' | tr ':' '+'`))
echo "= $linha_3" >> resultado
linha_4=$((`cat arqSoma | sed '4!d' | tr ':' '+'`))
echo "= $linha_4" >> resultado
linha_5=$((`cat arqSoma | sed '5!d' | tr ':' '+'`))
echo "= $linha_5" >> resultado
cat arqSoma | tr ':' '+' >> parcelas
paste parcelas resultado
soma=$(($linha_1 + $linha_2 + $linha_3 + $linha_4 + $linha_5))
echo "Total: $soma"
rm parcelas resultado log