read -p "Especifique el nodo que quiera apagar [1-8]: " nodo
{ printf "practica\ncos\n1\n$nodo\n2\nyes\n\n\033\0334"; } | telnet 158.42.181.26