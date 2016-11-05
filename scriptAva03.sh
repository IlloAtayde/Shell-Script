echo "Número total de processos: `ps auxc | sed '1d'| wc -l`"
echo "Número total de processos do usuário logado: `ps auxc | sed '1d'| grep -c "$USER"`"
echo "Número total de processos com terminal: `ps auxc | sed '1d'| grep -c "tty."`"
echo "Número total de processos em execução: `ps auxc | sed '1d'| grep -c -E "R\+*"`"