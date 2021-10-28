# P1. ENCENDIDO/APAGADO DE LOS NODOS DEL CLUSTER
## FRANCESC FOLCH COMPANY


Para pasar a telnet la secuencia de acciones utilizamos una tubería y la función printf. 

```Shell
{ printf "practica\ncos\n1\n$OUTLET\n$ACTION\nyes\n\n\033\0334"; } | telnet 158.42.181.26
```

### 1. Realizar  un  script  que  encienda  inmediatamente  todas  las  salidas.

`$OUTLET` tendrá el valor de 9 (todos) y `$ACTION` será 1 (Immediate On).

### 2. Realizar  un  script  que  apague  inmediatamente  todas  las  salidas.

`$OUTLET` tendrá el valor de 9 (todos) y `$ACTION` será 2 (Immediate Off).

### 3. Realizar un script genérico que encienda inmediatamente la salida que se indique como como parámetro de entrada al script.

Con la instrucción `read -p "Especifique el nodo que quiera encender [1-8]: " nodo`
Y posteriormente el `$OUTLET` será `$nodo`, con `$ACTION = 1`.

### 4. Realizar  un  script  genérico  que  a pague  inmediatamente  la  salida  que  se  indique  como parámetro de entrada al script.

Al igual que en el ejercicio 3, se leerá un input del usuario eligiendo el `$OUTLET` a apagar.

### 5. Realizar un script que encienda secuencialmente todas las salidas, con un retardo entre encendidos.

En este caso `$OUTLET = 9` y `$ACTION = 4` (Delayed On).

### 6. Realizar  un  script  que  apague  secuencialmente  todas  las  salidas,  con  un  retardo  entre encendidos.

En este caso $OUTLET = 9 y $ACTION = 5 (Delayed Off).

### 7. Realizar un script genérico para manipular las salidas de la PDU. Por ejemplo: `pdu <acción> <salidas>` donde `<acción>` indica la operación a realizar.

Empezamos con definir las diferentes funciones que puede ejecutar el script según las opciones especificadas por el usuario.   

- Para recoger todos los argumentos posibles se utiliza la opción getopts y se introducen los valores de los argumentos que queremos aceptar. Si se introduce un argumento que no está contemplado, se ejecutará la función `usage`.
- La funcion `usage` imprimirá los argumentos que se le pueden pasar al script.
- La función `conmutaTodas` actuará sobre todos los outlets y leerá la variable `$opCode` creada tras leer el primer argumento, que será o -1 o -0.
- La función `conmutaX` solo actuará sobre un outlet guardado en la variable `$x` con el argumento `-n x`.
- `conmutaFromTo` se ejecuta si se ha especificado al menos uno de los dos parámetros (`-f x` o `-t y`), si uno de los dos no se concreta, será o 1 o 8, respectivamente. Posteriormente se conmuta cada outlet con la operación delayed (on u off).


## TRABAJO OPCIONAL

Tras acceder al cluster y abrir una sesión telnet sobre la pdu se muestran estas opciones en Device Manager:

```
> 1

------- Device Manager --------------------------------------------------------

     1- Phase Monitor
     2- Power Supply Status

     <ESC>- Back, <ENTER>- Refresh
> 
```

Es posible observar los estados del monitor de fase y las fuentes de alimentación.

```
------- Power Supply Status ---------------------------------------------------

          Primary Power Supply Status: OK
        Secondary Power Supply Status: OK


     <ESC>- Back, <ENTER>- Refresh
>
```
Se aprecia que las fuentes de alimentación primaria y secundaria (backup) tienen un correcto funcionamiento.
```
------- Phase Monitor ---------------------------------------------------------

                  Outlet           --- Thresholds ---
        Phase  Restriction   Load  Low  NearOver Over     State
        -----------------------------------------------------------------
          1    None           2.8    0      8      8      Normal Load 


     <ESC>- Back, <ENTER>- Refresh
> 
```
En el monitor de fase se observa que la carga es normal y que hay un límite cuando la carga excede 8.


