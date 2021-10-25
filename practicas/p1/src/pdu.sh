function usage {
    echo "Usage:"
    echo "
            -1:  Encender 
            -0: Apagar 
        <salidas> la/s salida/s afectada/s:  
            -a: Todas las salidas 
            -n x: La salida x 
            -f x: Desde la salida x 
            –t y: Hasta la salida y 
    "
}

function conmutaTodas {
    if [ -z "${opCode}" ]; then
        echo "antes se debe de especificar accion de apagar o encender"
        usage
    else
        echo "Conmutando todas"
        { printf "practica\ncos\n1\n9\n$opCode\nyes\n\n\033\0334"; } | telnet 158.42.181.26
    fi
}

function conmutaX {
    if [ -z "${opCode}" ]; then
        echo "antes se debe de especificar accion de apagar o encender"
        usage
    else
        { printf "practica\ncos\n1\n$x\n$opCode\nyes\n\n\033\0334"; } | telnet 158.42.181.26
    fi
}

function conmutaFromTo {
    if [ -z "${opCode}" ]; then
        echo "antes se debe de especificar accion de apagar o encender"
        usage
    else
        for (( i=$from; i<=$to; i++ ))
        do
            echo "Conmuting $i"
            { printf "practica\ncos\n1\n$i\n$opCode\nyes\n\n\033\0334"; } | telnet 158.42.181.26
        done
    fi
}

while getopts ":h10an:f:t:" arg; do
    case ${arg} in 
        h)
            usage
            exit 1
            ;;
        1)
            opCode="1"
            ;;
        0)
            opCode="2"
            ;;
        a)
            conmutaTodas
            exit 1
            ;;
        n) 
            x=$OPTARG
            conmutaX
            exit 1
            ;;
        f)
            from=$OPTARG
            ;;
        t)
            to=$OPTARG
            ;;
        \?) 
            echo "Invalid argument..."
            usage
            exit 1
            ;;
    esac
done


if [ -z ${from} ] && [ -z ${to} ]; then
    exit 1
else
    if [ -z ${from} ]; then
        from=0
    elif [ -z ${to} ]; then
        to=8
    fi
    conmutaFromTo
fi