# Práctica 3. Condor

## Francesc Folch Company

### Parte 1

- `condor_status -submitters` muestra quien ha lanzado trabajos y el estado de la cola de los trabajos. Si están en espera o en ejecución.
- `condor_status -running` muestra los trabajos en ejecución, así como la máquina en la que se ejecutan.
- `condor_q` muestra los lanzados por nosotros, con su identificador. Después podemos modificar la prioridad de un trabajo con ese ID, también eliminarlo.
- El archivo .log muestra cuando se lanza y cuando se termina cada trabajo y el .out muestra el resultado de cada benchmark.

### Parte 2

El archivo de descripción de trabajo es el siguiente:

    universe = vanilla
    executable = dlx
    log = dlx.log
    output = out.$(Process)
    error = err.$(Process)
    should_transfer_files = Yes
    when_to_transfer_output = ON_EXIT_OR_EVICT
    transfer_input_files = ordena.s,ordena3.s

    arguments = -s final -d p -c p -f ordena.s
    queue

    arguments = -s final -d c -c p -f ordena.s
    queue

    arguments = -s final -d p -c t -f ordena.s
    queue

    arguments = -s final -d c -c t -f ordena.s
    queue

    arguments = -s final -d p -c 3 -f ordena3.s
    queue

    arguments = -s final -d c -c 3 -f ordena3.s
    queue

A medida que vayan acabando los trabajos se irá almacenando el vector ordenado en los ficheros *out*.

### Parte 3

#### Opción 1

Primero especificaremos los argumentos de entrada generando los archivos *in*: `./prep 0 6.28 1000 50 in`.

Después generaremos el archivo de descripción de trabajo llamado `intsin.condor` que contendrá lo siguiente:

    universe = vanilla
    executable = intsin
    log = intsin.log
    input = in.$(Process)
    output = out.$(Process)
    error = err.$(Process)
    should_transfer_files = Yes
    when_to_transfer_output = ON_EXIT_OR_EVICT
    queue 50

Tras completarse la ejecución sumaremos los resultados repartidos en los archivos *out*: `./sum 50 out`.

#### Opción 2 (dagman)

Para ejecutar los trabajos de manera que se cumplan las dependencias entre trabajos y que todos sean realizados por condor utilizaremos dagman. Generando el fichero intsin.dagman y ejecutándolo con `condor_submit_dag intsin.dagman` acabará generando el fichero `resultado` que contendrá el valor del resultado final de la integral.

El contenido del fichero intsin.dagman simplemente será el nombre de los ficheros condor y la dependencia entre ellos:

    JOB A prep.condor
    JOB B intsin.condor
    JOB C sum.condor

    PARENT A CHILD B
    PARENT B CHILD C

Con esto completamos la realización de la práctica.
