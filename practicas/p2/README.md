# Información del hardware

Con el comando `cpufreq-info` obtenemos la información para la frecuencia de funcionamiento del procesador, y leyendo el fichero de información de la cpu con `cat /proc/cpuinfo` podemos averiguar el modelo del procesador y más detalles:

- 4 Cores Intel Xeon X3320 
	- Max: 2.5GHz
	- Actual freq work: 2GHz

Para ver la información sobre la memoria RAM podemos ejecutar `htop` donde se visualiza de forma gráfica el uso de memoria RAM y SWAP así como otros parámetros de funcionamiento del sistema:

- RAM: 2010MB 
- Swap Mem: 2055MB

# Información del sistema operativo

Para averiguar la distribución de linux instalada podemos ejecutar `cat /etc/*-release` y mostrará en este caso la versión de OpenSUSE, habrá abierto el fichero /etc/SuSE-release.

- Distribution: OpenSUSE distribution v11.0 - x86-64

Obtendremos la versión del kernel con el comando `uname -a`:
- Linux kernel: 2.6.25.16-0.1-default 

# Información de red

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

# DNS
A continuación se ejecutan una serie de comandos para las consultas a DNS. 


```
~> host www.upv.es
	www.upv.es is an alias for ias.cc.upv.es.
	ias.cc.upv.es has address 158.42.4.23
	ias.cc.upv.es mail is handled by 7 mxv.cc.upv.es.
```

- host 158.42.4.23
	23.4.42.158.in-addr.arpa domain name pointer ias.cc.upv.es.

- nslookup 8.8.8.8
	Server:		158.42.248.88
	Address:	158.42.248.88#53

	Non-authoritative answer:
	8.8.8.8.in-addr.arpa	name = dns.google.

	Authoritative answers can be found from:
	8.8.in-addr.arpa	nameserver = ns1.level3.net.
	8.8.in-addr.arpa	nameserver = ns2.level3.net.
	ns2.level3.net	internet address = 209.244.0.2
	ns1.level3.net	internet address = 209.244.0.1

- dig www.upv.es
	; <<>> DiG 9.4.2-P1 <<>> www.upv.es
	;; global options:  printcmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 12045
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 4, ADDITIONAL: 6

	;; QUESTION SECTION:
	;www.upv.es.			IN	A

	;; ANSWER SECTION:
	www.upv.es.		300	IN	CNAME	ias.cc.upv.es.
	ias.cc.upv.es.		3600	IN	A	158.42.4.23

	;; AUTHORITY SECTION:
	upv.es.			3600	IN	NS	sun.rediris.es.
	upv.es.			3600	IN	NS	vega.cc.upv.es.
	upv.es.			3600	IN	NS	chico.rediris.es.
	upv.es.			3600	IN	NS	mirzam.ccc.upv.es.

	;; ADDITIONAL SECTION:
	mirzam.ccc.upv.es.	3600	IN	A	158.42.1.5
	vega.cc.upv.es.		3600	IN	A	158.42.4.1
	sun.rediris.es.		24704	IN	A	199.184.182.1
	chico.rediris.es.	24704	IN	A	162.219.54.2
	sun.rediris.es.		3104	IN	AAAA	2620:171:808::1
	chico.rediris.es.	3104	IN	AAAA	2620:10a:80eb::2

	;; Query time: 0 msec
	;; SERVER: 158.42.248.88#53(158.42.248.88)
	;; WHEN: Mon Oct 25 15:20:20 2021
	;; MSG SIZE  rcvd: 275

- dig -x 158.42.4.23
	; <<>> DiG 9.4.2-P1 <<>> -x 158.42.4.23
	;; global options:  printcmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63562
	;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 3, ADDITIONAL: 4

	;; QUESTION SECTION:
	;23.4.42.158.in-addr.arpa.	IN	PTR

	;; ANSWER SECTION:
	23.4.42.158.in-addr.arpa. 10800	IN	PTR	ias.cc.upv.es.

	;; AUTHORITY SECTION:
	42.158.in-addr.arpa.	10800	IN	NS	sun.rediris.es.
	42.158.in-addr.arpa.	10800	IN	NS	vega.cc.upv.es.
	42.158.in-addr.arpa.	10800	IN	NS	mirzam.cc.upv.es.

	;; ADDITIONAL SECTION:
	mirzam.cc.upv.es.	3600	IN	A	158.42.1.5
	vega.cc.upv.es.		3600	IN	A	158.42.4.1
	sun.rediris.es.		24641	IN	A	199.184.182.1
	sun.rediris.es.		3041	IN	AAAA	2620:171:808::1

	;; Query time: 0 msec
	;; SERVER: 158.42.248.88#53(158.42.248.88)
	;; WHEN: Mon Oct 25 15:21:23 2021
	;; MSG SIZE  rcvd: 211

- dig @8.8.8.8 .x 8.8.4.4
