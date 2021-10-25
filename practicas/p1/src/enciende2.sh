read -p "Especifique el nodo que quiera encender [1-8]: " nodo
{ printf "practica\ncos\n1\n$nodo\n1\nyes\n\n\033\0334"; } | telnet 158.42.181.26