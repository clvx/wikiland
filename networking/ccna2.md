# Proceso de Arranque
1. ROM - POST
2. ROM - Bootstrap
3. Flash - IOS
   TFTPServer - IOS
4. NVRAM - configuration file
   TFTPServer - configuration file
5. ROM/Console

# Rutas estáticas
- Se pueden sumarizar las rutas estáticas que salen de una misma interfaz 
mientras que estas sean subnets de la sumarizada.
- En una red de broadcast se utiliza el siguiente salto en vez de la interfaz 
de salida.

# CDP
Para deshabilitar globalmente:

		R(config)#no cdp run	

		R# show cdp neighbors 
        Muestra la siguiente información de los vecinos:
        - Device ID del vecino.
        - Interface local conectada.
        - Tiempo de espera.
        - Demás información del vecino.

# Protocolos Vector-Distancia (RIP, IGRP, EIGRP)
**Características**
- Envío de la tabla de enrutamiento.
- Actualizaciones periódicas: Tiempo en el cual los ennrutadores envian toda su 
tabla de enrutamiento.
- Vecindad.
- Actualizaciones por broadcast.

**Convergencia** Cuando todos los enrutadores manejan la misma información de 
la red. Si no hay nueva información, entonces se ha agregado la convergencia.

**Triggered Updates** Se dan cuando hay un cambio en la topología.

**Random Jitter** Cuando hay colisión de actualizaciones de enrutamiento. Se 
soluciona sincronizando las actualizaciones con la variable `RIP_JITTER`

**RIP Timers**
- Update timer
- Invalid timer
- Hold down timer
- Flush timer

**EIGRP Timers**
- Partial updates
- Triggered by topology changes
- Non periodic.
- Bounded.

**Routing Loops** Cuando un paquete es transmitido continuamente. 
Se suelen dar por los siguientes casos:
- Rutas estáticas mal configuradas.
- Convergencia lenta.

Tienen como consecuencia:
- Uso excesivo del ancho de banda.
- Actualizaciones de enrutamiento no son procesadas.
- Utilización de recursos de hw.

**Prevención de routing loops**
- count to infinity: Le pone una métrica de 16 si se cae la red.
- Hold down timers: No se aceptan cambios de ruta hasta pasado un periodo de 
-iempo. Permite que los demás routers se enteren del problema.
- Horizonte dividido: Un router no puede difundir una ruta por la interface por
la cual la conoció.
- Horizonte dividido con envenenamiento inverso. 
- TTL: Previene que el paquete ande indifinidamente, decrese en 1.

# RIPv1:
- Classful: no soporta CIDR
- Metric: Hop count
- Update are broadcast every 30 seconds.
- Administrative Distance 120
- Automatically summarizes classful networks.
- 2 reglas:
    * If a routing update and the interface it's received on belong to the same
    network then the subnet mask of the interface is applied to the network in 
    the routing update.
    * If a routing update and the interface it's received on belong to a 
    different network then the classful subnet mask of the network is applied 
    to the network in the routing update.
- La sumarización automática no soporta redes discontiguas.

**Configuración de una ruta por defecto**
        R(config)#ip route 0.0.0.0 0.0.0.0 [next hop |exit interface]
        R(config-router)#default-information originate
        R(config)#ip route [ip network] [network mask] [next hop | exit interface]
        R(config-router)#redistribute static

# RIPv2
- Classless
- Routing updates are multicast.
- Next hop address is included in updates
- RIPv2 ignora actualizaciones RIPv1

**RIPv1 & RIPv2 similitudes**
- Timers para prevenir routing loops.
- Uso de horizonte dividido y horizonte dividido con envenenamiento de ruta.
- Triggered updates.
- Hop count máximo de 15.
- Realiza sumarización automática.

**Configuración**

        R(config)#router rip
        R(config-router)#version 2
        # Cada subnet tiene una
        # entrada específica con su máscara como la interface de
        # salida o la dirección del siguiente salto.
        R(config-router)#no auto-summary 

**Null interface**
- Virtual interface• Traffic sent to a null interface is discarded.
- No reciben ni envian tráfico.

# EIGRP 
- Vector Distancia.
- Métrica: El ancho de banda más lento hasta un destino sumado todos los 
retardos a cada uno de los enlaces al destino.
        Metric = 10'000'000/bandwithd(kilobits) + Sum(delays)
        - Bandwith: Link bandwith.
        - Delay: Tiempo que se demora un paquete en atravesar un enlace.
        - Realiability: 255 is totally reliable.
        - Load: 1 of 255 is the best load.
- Distancia administrativa:
    * Summary routes = 5
    * Internal Routes = 90
    * Imported Routes = 170
- Sumariza automáticamente.
- Protocol dependent Module: Puede enrutar diversos protocolos.
- RTP: Usado por EIGRP pra transmitir y recibir paquetes EIGRP.
    * Puede ser orientado a conexión y no orientado a conexión.
    * Puede ser enviado por Unicast y Multicast(224.0.0.10)

**Mensajes EIGRP**
- *Hello Packets* Descubre y forma adyacencia con vecinos. Envio cada 5 segundos,
 en ambientes no broadcast cada 60 segundos.
- *Holdtime* 3 veces el tiempo del hello packet. Tiempo que espera para declarar
 a un vecino inalcanzable.
- *Update Packets* Propaga información de enrutamiento. Se envian cuando hay un 
cambio en el estado de enrutamiento.
- *Partial update* Incluye la información que ha cambiado solamente, NO toda la
tabla de enrutamiento.
- *Bounded update* Solo se notifican los enrutadores que son impactados por el
cambio.
- *Query & Reply Packets* Usado por DUAL cuando busca redes específicas.
- *Ack Packets* Confirma los demás paquetes.

**DUAL**
- Previene los loops de enrutamiento.
- Uso mínimo de ancho de banda.
- Convergencia rápida.
- *Sucesor* Mejor ruta con menor costo a una red destino.
- *Distancia factible* La métrica calculada más baja para llegar a una red destino.
- *Suceso factible* Ruta libre de looping a la misma red destino que la ruta 
sucesor. Puede no haber un sucesor factible si no se cumple la condición de 
factibilidad.
- *Distancia Reportada* Métrica que un router reporta a un vecino para llegar a
 una red destino.
- *Condición de factibilidad* Cuando la distancia reportada es menor que la distancia
 factible del router a la misma red destino.

**Tabla topológica**  Puede verse toda las rutas sucesoras y todas las rutas 
sucesoras factibles.

**Configuración**
        R(config)#router eigrp [AS], *el AS debe ser el mismo en todos los routers.*
        R(config-router)#network [ip network] [wildcard mask], el ip network es 
        el classful, si se quiere agregar una red específica se utiliza la wildcard.
        R(config)#show ip eigrp neighbors
        - Address of neighbors.
        - Interface connected to neighbor
        R(config-if)#bandwitdth [kilobits], no cambia el ancho de banda del enlace.
        R#show ip eigrp topology
        R(config-router)#no auto-summary, ya no envia actualizaciones 
        automáticamente sumarizadas.
        R(config-if)#ip summary-address eigrp [AS] [ip network]
        [subnet mask], para la configuración manual de la
        sumarización en una interfaz.
        R(config)#ip route 0.0.0.0 0.0.0.0 [exit interface|next hop
        address]
        R(config-router)#redistribute static
        * Para configurar redistribución de una estática.
        R(config-if)#ip hello-interval eigrp [AS] [seconds]
        R(config-if)#ip hold-time eigrp [AS] [seconds]
        * El tiempo es 3 veces el hello time, y cambiar el hello time
        implica cambiar el hold time.

- 2 condiciones para Null0 Interface EIGRP:
    * Al menos una subnet es aprendida via EIGRP
    * Sumarización automática está habilitada.

# Link State

**Características**
- Utiliza muchos recursos de ancho de banda, CPU, memoria.
- Utilizado por OSPF e IS-IS.
- Utiliza el algoritmos de Dijkstra o SPF.

**Convergencia**
1. Cada enrutador aprende de las directamente conectadas.
2. Intercambian hello packets para conocer a los vecinos.
3. Cada router construye su propio LSP(link state Packet) que incluye:
- Neighbor ID.
- Link type.
- Bandwith.
- Cost.
- Neighbor who is connected to it.
4. Se indunda a todos los vecinos el LSP los cuales guardan la información en una 
base de datos, hasta que todos los vecinos tengan la misma información.
5. Cada router utiliza la base de datos para construir un mapa completo de la 
topología y computar las mejores rutas a las redes destino.

- *Hello Packet* Sirve para crear adyascencia entre vecinos. Sirven para saber 
si el enlace se mantiene encendido.
- *LSP* Cada router construye su propio paquete de estado enlace. Se reenvían a 
todos los vecinos. Se crean cuando:
    * Se inicia el router o el proceso de enrutamiento.
    * Cuando hay un cambio en la topología.

# OSPF
- Distancia administrativa: 110
- NO sumariza automáticamente las redes cercanas.

**5 tipos de paquetes**
- Hello: Descubre vecinos y construye adyascencias. Utilizado para elegir al 
DR y BDR.
    * Contiene router ID.
    * Usualmente multicast(224.0.0.5).
    * Enviado cada 30 segundos para ambientes no broadcast.
    * Dead interval 4 veces el hello interval.
- Database description(DBD):  Verifica sincronización de la base de datos entre
 routers.
- Link State Request: Peticiones para especificar del estado enlace a otros routers.
- Link State Update: Actualizaciones específicas de estado enlace. 
Contiene neighbors y path costs.
- Link State Ack: Confirma los paquetes anteriores.

**Algoritmo OSPF**
1. Construye la base de datos de estado enlace.
2. Se ejecuta el algoritmo de Dijkstra sobre la base de datos de estado enlace.
3. Se crea el árbol del camino más corto.
4. Se añaden las rutas más cortos a la tabla de enrutamiento.

**Métrica**
- Es el valor acumulativo desde un router hasta la ruta destino incluyendola.
- Costo: `(10^8)/bandwidth(bps)`

**Router ID** 
3 criterios:
- Utiliza la IP configurada por el comando router-id.
- Sino se utiliza la dirección loopback más alta. Las loopbacks siempre están 
prendidas.
- Sino se utiliza la dirección de interfaz más alta activa.

**Multiaccess Networks**
- Inundación de LSA en la red en la relación `n(n-1)/2`.
- Se elige el DR & BDR para gestionar los LSA. No se eligen en ambientes punto 
a punto.
- `224.0.0.6` para enviar al DR & BDR .
- `224.0.0.5` para enviar a todos los demás routers.
- Elección del DR y BDR:
    * DR = Router con la prioridad de interface OSPF más alta.
    * BDR = Router con la 2da interface OSPF más alta.
    * Si las prioridades son iguales, se busca el router ID más alto.
    * Se elige cuando se prenden las interfaces en una interface de multiacceso.
    * Se mantiene como DR hasta que:
        - El DR falla.
        - El proceso OSPF falla.
        - La interface falla.

**Configuración**

        *R(config)#router ospf [process id]* el process id es local de
        16bits.
        *R(config-router)#network [ip network][wildcard mask] area [area-id]* 
        el área debe ser la misma en todos los routers.
        *R(config-router)#router-id [ip address]* configuración router ID.
        *R(config-router)#auto-cost reference-bandwidth*
        *R(config-if)#bandwidth [bandwidth in kbs]*
        *R(config-if)#ip ospf cost [cost]* permite especificar el costo
        de la interface directamente.
        - Ambas lados del enlace deben tener el mismo costo de
        ancho de banda.
        *R(config-if)#ip ospf hello-interval [seconds]*
        *R(config-if)#ip ospf dead-interval [seconds]*
        - Dead interval 4 veces el hello interval.
        - Deben ser los mismos entre los vecinos.
        *R#clear ip ospf process* modificar el ID del router.
        *R#show ip ospf interface*
        - Muestra el Neighbor ID, su dirección IP y la interfaz a la
        cual está conectada localmente.
        *R#show interface [interface number]* muestra el ancho de banda del enlace.
        *R(config)#ip route 0.0.0.0 0.0.0.0 [interface number | next hop address]*
        *R(config-router)#default-information originate*
