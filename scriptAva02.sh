  #!/bin/bash
  echo "Número de usuários: `cat /etc/passwd | wc -l`"
  echo "Número de usuários utilizando o bash: `cat /etc/passwd | cut -f7 -d: | grep -c "bash"`"
  echo "Número de usuários que não utilizam o bash: `cat /etc/passwd | cut -f7 -d: | grep -v -c "bash"`"
  echo "Número de usuários que não login: `cat /etc/passwd | cut -f7 -d: | grep -c -E '(false|nologin)'`"
 
