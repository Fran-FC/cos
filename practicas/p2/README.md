# Francesc Folch Company

## Información del hardware

Con el comando `cpufreq-info` obtenemos la información para la frecuencia de funcionamiento del procesador, y leyendo el fichero de información de la cpu con `cat /proc/cpuinfo` podemos averiguar el modelo del procesador y más detalles:

- 4 Cores Intel Xeon X3320 
	- Max: 2.5GHz
	- Actual freq work: 2GHz

Para ver la información sobre la memoria RAM podemos ejecutar `htop` donde se visualiza de forma gráfica el uso de memoria RAM y SWAP así como otros parámetros de funcionamiento del sistema:

- RAM: 2010MB 
- Swap Mem: 2055MB

## Información del sistema operativo

Para averiguar la distribución de linux instalada podemos ejecutar `cat /etc/*-release` y mostrará en este caso la versión de OpenSUSE, habrá abierto el fichero /etc/SuSE-release.

- Distribution: OpenSUSE distribution v11.0 - x86-64

Obtendremos la versión del kernel con el comando `uname -a`:
- Linux kernel: 2.6.25.16-0.1-default 

## Información de red

- Con el comando `/sbin/ifconfig` obtendremos la información de las interfaces de red, las de interés son:
```BashScript
~> /sbin/ifconfig
	...
	eth0      Link encap:Ethernet  HWaddr 00:15:17:27:C3:39 
		  inet addr:158.42.181.219  Bcast:158.42.181.255  Mask:255.255.254.0
		  inet6 addr: fe80::215:17ff:fe27:c339/64 Scope:Link
		  UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
		  RX packets:1249184 errors:0 dropped:0 overruns:0 frame:0
		  TX packets:57008 errors:0 dropped:0 overruns:0 carrier:0
		  collisions:0 txqueuelen:100 
		  RX bytes:84777196 (80.8 Mb)  TX bytes:14093529 (13.4 Mb)
		  Memory:81b00000-81b20000 

	eth1      Link encap:Ethernet  HWaddr 00:15:17:27:C3:37  
		  inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
		  inet6 addr: fe80::215:17ff:fe27:c337/64 Scope:Link
		  UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
		  RX packets:1305382 errors:0 dropped:0 overruns:0 frame:0
		  TX packets:726020 errors:0 dropped:0 overruns:0 carrier:0
		  collisions:0 txqueuelen:100 
		  RX bytes:529057896 (504.5 Mb)  TX bytes:54621472 (52.0 Mb)
```

Podemos observar que la interfaz eth0 se comunica con la red externa de la UPV, mientras que eth1 tiene comunicación con la red local con el resto de nodos del cluster.

- Con el comando `/sbin/route` se puede observar la tabla de encaminamiento del frontend del cluster, la salida por defecto es rou-labdisca.ne. Si un paquete tiene otro destino como por ejemplo una IP con el prefijo 192.168.1.0/24, no será redireccionado.
```
~> /sbin/route
	Kernel IP routing table
	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
	192.168.1.0     *               255.255.255.0   U     0      0        0 eth1
	158.42.180.0    *               255.255.254.0   U     0      0        0 eth0
	link-local      *               255.255.0.0     U     0      0        0 eth0
	loopback        *               255.0.0.0       U     0      0        0 lo
	default         rou-labdisca.ne 0.0.0.0         UG    0      0        0 eth0
```

- Para mostrar la tabla ARP con la conversión de MAC a IP ejecutamos `/sbin/arp`. Si quisieramos mostrar las IP numéricas en lugar de los nombres simbólicos utilizamos la opción `-n`:
```
~> /sbin/arp -n
Address                  HWtype  HWaddress           Flags Mask            Iface
158.42.181.15            ether   F0:79:59:64:55:DA   C                     eth0
158.42.181.11            ether   08:62:66:48:E1:9B   C                     eth0
192.168.1.105            ether   00:15:17:27:C3:8E   C                     eth1
192.168.1.254            ether   00:C0:B7:CF:8F:87   C                     eth1
158.42.181.17            ether   F0:79:59:64:55:F8   C                     eth0
192.168.1.106            ether   00:15:17:27:B2:13   C                     eth1
158.42.181.250           ether   2C:FA:A2:2D:10:95   C                     eth0
192.168.1.100            ether   00:14:FD:13:01:7E   C                     eth1
192.168.1.102            ether   00:15:17:27:C3:AC   C                     eth1
158.42.181.6             ether   08:62:66:48:DE:B2   C                     eth0
158.42.181.9             ether   08:62:66:48:E0:DD   C                     eth0
192.168.1.107            ether   00:15:17:27:BF:86   C                     eth1
158.42.181.10            ether   08:62:66:48:E1:66   C                     eth0
158.42.181.14            ether   F0:79:59:64:55:DD   C                     eth0
158.42.181.8             ether   F0:79:59:64:56:23   C                     eth0
192.168.1.108            ether   00:15:17:27:BF:C8   C                     eth1
158.42.181.5             ether   08:62:66:48:E4:CB   C                     eth0
192.168.1.104            ether   00:15:17:27:C8:1D   C                     eth1
158.42.181.3             ether   08:62:66:48:DF:6D   C                     eth0
192.168.1.103            ether   00:15:17:27:C3:58   C                     eth1
158.42.181.19            ether   08:62:66:48:E0:C9   C                     eth0
158.42.181.29            ether   08:62:66:48:DB:20   C                     eth0
158.42.181.16            ether   08:62:66:48:E1:9E   C                     eth0
```

A continuación se ejecutan una serie de comandos para las consultas a DNS. 

- En este comando realiza un DNS *lookup*, en este caso, www.upv.es es el alias de ias.cc.upv.es, el cual es el dominio real, con IP 158.42.4.23. También muestra el dominio de correo de ias.cc.upv.es, el cual es mxv.cc.upv.es.
```
~> host www.upv.es

www.upv.es is an alias for ias.cc.upv.es.
ias.cc.upv.es has address 158.42.4.23
ias.cc.upv.es mail is handled by 7 mxv.cc.upv.es.
```

- El siguiente comando resuelve el nombre de host de la direcion dada, haciendo un *reverse lookup* o rDNS. Lo que devuelve el dominio.
```
~> host 158.42.4.23

23.4.42.158.in-addr.arpa domain name pointer ias.cc.upv.es.
```

- El siguiente comando indica que el nombre del host con la dirección ip 8.8.8.8 es dns.google, el cual es un servidor dns.
```
~> nslookup 8.8.8.8

8.8.8.8.in-addr.arpa	name = dns.google.
```

- El comando dig también realiza una operación DNS *lookup*, dice que el CNAME de www.upv.es es ias.cc.upv.es y que la dirección IP de esta es 158.42.4.23. Adicionalmente vemos el *time to live* de estas asociaciones, cuando este tiempo acaba el dns volverá a refrescar la tabla.
```
~> dig www.upv.es

;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 9597
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;www.upv.es.			IN	A

;; ANSWER SECTION:
www.upv.es.		300	IN	CNAME	ias.cc.upv.es.
ias.cc.upv.es.		3600	IN	A	158.42.4.23

;; Query time: 4 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Mon Nov 08 15:40:06 CET 2021
;; MSG SIZE  rcvd: 76
```


- En esta ocasión realizamos un *reverse lookup*, insertando la IP con la opción -x. Lo que nos devolverá el nombre de dominio ias.cc.upv.es.
```
~> dig -x 158.42.4.23

; <<>> DiG 9.16.22-RH <<>> -x 158.42.4.23
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 6640
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;23.4.42.158.in-addr.arpa.	IN	PTR

;; ANSWER SECTION:
23.4.42.158.in-addr.arpa. 6025	IN	PTR	ias.cc.upv.es.

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Mon Nov 08 15:47:27 CET 2021
;; MSG SIZE  rcvd: 80
```

- Para especificar el servidor dns al que preguntar, lo cual nos devuelve que el nombre de 8.8.4.4 es dns.google.
```
~> dig @8.8.8.8 -x 8.8.4.4

; <<>> DiG 9.16.22-RH <<>> @8.8.8.8 -x 8.8.4.4
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 23791
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;4.4.8.8.in-addr.arpa.		IN	PTR

;; ANSWER SECTION:
4.4.8.8.in-addr.arpa.	20782	IN	PTR	dns.google.

;; Query time: 11 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Mon Nov 08 15:48:42 CET 2021
;; MSG SIZE  rcvd: 73
```

- El fichero `/etc/passwd` muestra los usuarios del sistema y su configuración, como el nombre de usuario o el shell asociado.
- El fichero `/etc/nsswitch.conf` es la configuración para saber de donde obtener los nombres de servicio como alias o nombres de host entre otros.
- `/etc/hosts` guarda algunas relaciones de IP y nombre de dominio. Por defecto solo estará la relación de locahost y 127.0.0.1, pero a demás se encuentran almacenadas las direcciones de los demás nodos del cluster y del apc y nas.
- `/etc/resolv.conf` es un archivo para información DNS, el campo search muestra los resultados de los DNS *lookup* recientes.
```
search upv.es
nameserver 158.42.248.88
nameserver 158.42.1.8
```

- `/etc/dhcpd.conf` contiene configuración del sercvicio dhcpd.

Ahora se analizan los scripts de ejecución de nivel 5.

- En /etc/init.d/rc5.d/ se encuentran los enlances simbólicos a los servicios asociados al nivel 5 de ejecución.
- Los servicios son:
```
cos08@cac1:/etc/init.d> ls
1                   boot.getclock     dhcpd             portmap         setserial
aaeventd            boot.ipconfig     earlysyslog       postfix         single
acpid               boot.klog         earlyxdm          powerd          skeleton
alsasound           boot.ldconfig     energysaving      powerfail       skeleton.compat
apache2             boot.loadmodules  fbset             powersaved      smartd
atd                 boot.local        gpm               pxe             smbfs
auditd              boot.localfs      haldaemon         random          spamd
autofs              boot.localnet     halt              raw             splash
autoyast            boot.lvm          halt.local        rc              splash_early
avahi-daemon        boot.md           irq_balancer      rc0.d           sshd
avahi-dnsconfd      boot.proc         java.binfmt_misc  rc1.d           stopblktrace
bluetooth           boot.rootfsck     joystick          rc2.d           SuSEfirewall2_init
boot                boot.sched        kbd               rc3.d           SuSEfirewall2_setup
boot.apparmor       boot.scpm         mdadmd            rc4.d           syslog
boot.blktrace       boot.swap         microcode.ctl     rc5.d           uuidd
boot.cleanup        boot.sysctl       montar.sh         rc6.d           vboxdrv
boot.clock          boot.udev         mysql             rcS.d           waitfornm
boot.crypto         boot.udev_retry   network           README          xdm
boot.crypto-early   condor            nfs               reboot          xfs
boot.cycle          consolekit        nfsserver         resmgr          xinetd
boot.d              cron              nscd              rpasswdd        ypbind
boot.device-mapper  cups              ntp               rpmconfigcheck  yppasswdd
boot.dmraid         dbus              openct            rsyncd          ypserv
boot.fuse           denyhosts         pcscd             saslauthd       ypxfrd
```
  
## SSH 

Se ha creado una clave pública y se ha cargado en todos los nodos del cluster - Tras ejecutar una serie de comandos en cac2, se listan los procesos en ejecución de todos los nodos :

```bash
cos08@cac1:~> for i in 2 3 4 5 6 7 8; do echo cac$i ; ssh cac$i ps ; done
cac2
  PID TTY          TIME CMD
31937 ?        00:00:00 sshd
31938 ?        00:00:00 ps
cac3
  PID TTY          TIME CMD
26288 ?        00:00:00 sshd
26289 ?        00:00:00 ps
cac4
  PID TTY          TIME CMD
 6549 ?        00:00:00 sshd
 6550 ?        00:00:00 ps
cac5
  PID TTY          TIME CMD
12451 ?        00:00:00 sshd
12452 ?        00:00:00 ps
cac6
  PID TTY          TIME CMD
22746 ?        00:00:00 sshd
22747 ?        00:00:00 ps
cac7
  PID TTY          TIME CMD
22568 ?        00:00:00 sshd
22569 ?        00:00:00 ps
cac8
  PID TTY          TIME CMD
22780 ?        00:00:00 sshd
22781 ?        00:00:00 ps
```
- Al ejecutar `./psh ps` aux sin comillas, solo se envía el comando ps, ya que el script solo lee el primer argumento.

- Si hicieramos `sudo ./psh poweroff` apagaríamos los nodos de la máquina.

-  Para ejecutar un comando simultaneamente en todos los nodos se utiliza la herramienta `multixterm`.

- Para el script de copiar un archivo a todos los nodos se utilizará el siguiente esquema: `scp $origen cac$i:$destino`

- El comando `pdsh` ejecuta un comando en los nodos del cluster que se especifiquen y con la opción -R se selecciona que los comandos se ejecutan a través de ssh. 



