# CCNA III

**CSMA/CD** Carrier sense multiple access/collision detect. Utilizado solo por half
 duplex.

**Carrier Sense** El método de acceso por señal portadora implica que todos los 
dispositivos en la red esperan que la red este libre para poder transmitir, si 
detectan otra señal en la red, espera un tiempo para poder transmitir.

**Multi-access** La distancia entre los dispositivos debe ser tal que cada uno 
de los dispositivos pueda registrar la señal del otro en caso de transmisión 
para que no ocurran colisiones.

**Collision Detection** Cuando un dispositivo está en "listening mode", puede 
registrar una colisión detectando el incremento de la amplitud de la señal.

**Jam Signal and Random Backoff** Un dispositivo al detectar una colisión envia
 una "señal jamming" notificando a los otros dispositivos de la colisión e
invocando a un algoritmo "backoff", que para las transmisiones de los 
dispositivos por un periodo aleatorio.

**Unicast** Envio de tramas(frames) desde un host origen hacia un host destino. 
(HTTP, STMP, FTP, Telnet).

**Broadcast** Envio de tramas(frames) desde un host origen hacia todos los 
destinos posibles del segmento. (ARP).

**Multicast** Envio de tramas(frames) desde un host origen hacia un grupo de 
host destinos.

**Ethernet frame**
- Estructure: `Preamble:Delimiter:DST-MAC:SRC-MAC:Length/Type:DATA:FCS`
- Mac Address: Tamaño de 48 bits expresado en 12 dígitos hexadecimales.
    * Consta de: 24 bits OUI - 24 bits Vendor assignment number.
    * OUI: Identifica al fabricante de la NIC.  

**Half Duplex**
 
- Flujo unidireccional de datos, donde la TX/RX no se dan en el mismo tiempo.
- Se implementa basado en CSMA/CD.
- Utilizado en hubs.

**Full Duplex** Flujo bidireccional de datos, donde la TX/RX se da en el mismo 
tiempo.
- Utilizan diferentes circuitos para enviar y recibir data.
- Es el tipo de comunicación Ethernet más común.
- Requiere soporte full-duplex en ambos extremos.
- No hay colisiones.
- Comunicación punto a punto.

**Switch Port Settings**
- Auto: autonegocio el modo duplex. En caso de error se toma half duplex.
- Full: configura full duplex.
- Half: configura half duplex.

**MAC Addressing and Switch MAC Address Tables**
Un switch construye su MAC Address Table grabando cada dirección de los 
dispositivos que están conectados a sus puertos. Una vez relacionado un 
dispositivo a un puerto, el switch conoce como enviar paquetes a ese destino.
Cuando llega un paquete con una MAC que no se encuentra en la tabla, el switch 
reenvia el paquete a todos los puertos excepto por el puerto que fue recibido. 
Si el nodo destino responde, el switch graba la relación MAC - puerto en su
tabla utlizando la dirección mac origen.

**Consideraciones de diseño**
- Bandwidth and Throughput: Las colisiones que se dan en un segmento limitan la
 cantidad efectiva de data transmitida por un puerto. Una vez que las colisiones
 se resuelvan el segmento puede transmitir a su velocidad ideal.

**Dominios de colisión** 
- Se dice que una área de la red donde las tramas se originan y chocan se llama
 dominio de colisión. 
- A mayor dispositivos en la red es más probable las colisiones.
- Los hubs aumentan los dominios de colisión, ya que comparten el mismo medio.
- Los switches reducen los dominios de colisión, porque construyen su 
MAC address table para asociarlos a un puerto.

**Dominios de Broadcast**
- Cuando un dispositivo envia un broadcast de capa 2, la dirección MAC es procesada
y aceptada por todos los dispositivos del segmento de red.
- Cuando un switch recibe una trama broadcast, la reenvia a todos sus puertos 
menos por el que la recibe.

**Network Latency** Tiempo que una trama o paquete le toma viajar desde el 
origen hasta el destino. Se da por 3 motivos:
- NIC Delay: El tiempo que toma la NIC en aplicar pulsos al medio y el tiempo 
que toma interpretar esos pulsos.
- Propagation Delay: Tiempo que le toma la señal en viajar al destino.
- Intermediate Devices Delay: Añadidos por los dispositivos intermedios que 
procesan las tramas o paquetes.

**Network Congestion** Para evitar la congestión se segmenta la LAN en partes 
pequeñas para aislar el tráfico y aumentar el ancho de banda. 
Causas de congestión:
- Los dispositivos envian y procesan la data más rápido.
- Mayor volumen de tráfico de red.
- Aplicaciones que requiere alto ancho de banda.

**Controlling Network Latency**
- Considerar la latencia causada por cada dispositivo en la red.
- Remover cuellos de botella, aumentando el ancho de banda entre los puntos.

# Switch Packet Forwarding Methods
**Store-and-Forward Switching**
- Recibe toda la trama, computa el CRC, verifica el tamaño de la trama. Si el 
CRC y el tamaño del paquete son válidos, la dirección MAC destino se revisa 
para ver el puerto de salida y se reenvia la trama.
- Verifica errores.
- Reenvio Lento.
- Reduce el ancho de banda al detectar errores.

**Cut-Trough Switching**
- Reenvia la trama antes de que sea recibida completamente. Como mínimo, 
lee la dirección MAC destino para poder ser reenviada.
- Reenvio rápido.
- No verifica errores.
- Aumenta el ancho de banda al no detectar errores.
    * 2 tipos de Cut-Trough:
        - Fast-Forward switching: No hace ningún tipo de verificación de errores.
        - Fragment-free switching: Almacena los primeros 64 bytes de la trama 
        antes de reenviar. Se realiza porque en los 64 primeros bytes 
    usualmente se generan los errores.

**Switching Asimétrico**
- Mayor ancho de banda es asignado a un puerto para un dispositivo específico.

**Switching Simétrico**
- Cada puerto en el switch tiene asignado el mismo ancho de banda.

**Memory Buffering** Usado cuando el puerto de destino está ocupado.
- Port Based and Shared memory:
    * Las tramas son alamacenadas en colas que son enlazadas a puertos 
    específicos de entrada y salida.
    * Puede retardar la transmisión debido a un frame esperando en cola a ser 
    transmitido.

Shared Memory Buffering:
- Deposita todas las tramas en un buffer de memoria común que todos los puertos 
del switch comparten.
- La cantidad de memoria requerida es obtenida dinámicamente.

# Switch Boot Sequence:
- Se carga el boot loader desde el NVRAM.
- El boot loader realiza:
    * Incialización del CPU a bajo nivel(Mapeado de memoria, cantidad de memoria,
     y velocidad).
    * Realiza un POST.
    * Inicializa el sistema del archivo flash.
    * Carga el SO por defecto a memoria y bootea el switch

# Configuración básica
Agregar IP a la vlan administrativa:

        S#configure terminal
        S(config)#interface vlan [number]
        S(config-if)#ip address [ip-address] [netmask]
        S(config-if)#no shutdown

Asignar la vlan administrativa a un puerto:

        S#configure terminal
        S(config)#interface [interface-name][number]S(config-if)#switchport mode access
        S(config-if)#switchport access vlan [number]

Default GW:

        S#configure terminal
        S(config)#ip default-gateway [ip]

Configurar Duplex:

        S#configure terminal
        S(config)#interface [interface-name][number]
        S(config-if)#duplex auto
        S(config-if)#speed auto

Administrando la MAC address Table
Dinámicas: Se aprenden automáticamente y se pueden configurar un tiempo de actualización.
Estáticas: Se agregan manualmente y remueven, nunca se actualizan.

        S#mac-address-table static [MAC address] vlan [number] interface [name][number] //

Verificación:

        S#show ip interface brief.
        S#show interfaces [name][number]
        S#show running-config
        S#show startup-config
        S#show mac-address-table

Login/MOTD Banner:

        S1(config)#banner login "Authorized Personnel Only!"
        S1(config)#banner motd "Device maintenance will be occurring on Friday!"

Habilitar Telnet:

        S1(config)#line vty 0 4
        S1(config-line)#transport input telnet

Habilitar SSH:

        S1(config)#hostname [name]
        S1(config)#ip domain-name [name]
        S1(config)#crypto key generate rsa
        S1(config)#ip ssh version 2
        S1(config)#line vty 0 4
        S1(config-line)#transport input SSH

**MAC Address Flooding** El atacante envia paquetes con direcciones mac destino 
inválidas sobrecargando la MAC Address Table con la finalidad de que el switch 
entre en fail-open-mode comportandose como un hub, y asi poder conseguir que los
siguientes paquetes se reenvien a todos los puertos.

**Spoofing Attacks** 2 tipos:
- Spoofing: Un atacante activa un servidor DHCP en un segmento de la red, el 
cliente solicita un IP al DHCP más cercano, como el servidor DCHP falso se 
encuentra en el mismo segmento le entrega una configuración infectada
con la finalidad de redireccionar los paquetes a algún lugar.
- DHCP Spoofing: Un atacante requiere varias direcciones IP al servidor real 
DHCP agotando todos los IP's del segmento.

**CDP Attacks**
- Protocolo de cisco que envia información del estado de los enlaces como 
puertos, modelos de dispositivo, IP address, software version, plataforma, 
VLAN nativa.
- La información se envia en texto plano, siendo una vulnerabilidad.

**Telnet Attacks**
- Ataques de fuerza bruta para conseguir los passwords.
    * Se debe cambiar las contraseñas frecuentemente.
    * Utilizar contraseñas fuertes.
    * Limitar el número de entradas VTY.
- Ataques DoS.
    * Se previene actualizando el IOS.

**Security Tools**
- Network Security Audit ayuda a:
    * Que tipo de información se puede conseguir monitoreando el tráfico.
    * Determina la cantidad de MAC spoofed a eliminar.
    * Determina la actualización de la MAC Address Table.
- Network Penetration Testing ayuda a:
    * Identifica debilidades dentro de la configuración de los dispositivos networking.
    * Prueba diferentes ataques dentro de la red para detectar vulnerabilidades.
- Caracteristicas de las herramientos de seguridad:
    * Identificación de servicios por escaneo de puertos.
    * Soporte de servicios SSL.
    * Testeo destructivo y no destructivo.
    * Vulnerabilidades en la base de datos.
- Funciones de las herramientas de seguridad:
    * Capturar mensajes de chat.
    * Capturar archivos de tráfico NFS.
    * Capturar paquetes HTTP.
    * Capturar mensajes de correo en formato mbox.
    * Capturar contraseñas.
    * Interceptar paquetes.

# Port Security
- Limita el número de direcciones MAC válidas permitidas en un puerto.
- Tipos de seguridad:
    * Especificar un grupo de direcciones MAC permitidas en un puerto.
    * Permitir solamente una dirección MAC accesar a un puerto.
    * Especificar que el puerto se apague automáticamente si una dirección MAC 
    no permitida es detectada.
- Tipo de direcciones MAC para port security:
    * *Static secure MAC addresses*, las direcciones MAC son manualmente 
    configuradas y se agregan a la running-config. 
    `S(config-if)#switchport port-security mac-address [dirección mac]`
    • *Dynamic secure MAC addresses*, las direcciones MAC son dinámicamente 
    aprendidas y almacenadas en la tabla de direcciones. Son removidas si se 
    reinicia el switch.
    • *Sticky secure MAC addresses*, los puertos aprenden dinámicamente las 
    direcciones MAC agregandolas a la running-config.
        - `S(config-if)#switchport port-security mac-address sticky`, la 
        interface convierte toda las direcciones dinámicas MAC seguras aprendidas
         a "sticky secure MAC address" y las agrega a la running-config.
        - `S(config-if)#no switchport port-security mac-address sticky`, las 
        "sticky secure MAC addresses" se mantienen en la tabla de direcciones 
        pero son removidas de la running-config.
        - `S(config-if)#switchport port-security mac-address sticky [dirección mac]`, 
        estas direcciones son añadidas a la tabla de direcciones y agregadas a 
        la running-config. Si port security está deshabilitado no se agregan a 
        la running-config.

**Security Violation** 
- Cuando una estación que su dirección mac no se encuentra en la tabla de 
direcciones accede a la interface cuando la tabla de direcciones está llena.
- Una dirección está siendo utilizado en 2 interfaces en la misma VLAN.
- Security Violation Mode:
### **NECESITA GRAFICO**

# VLAN's

**Introducción**
- Permite crear grupos de dispositivos de red contectados logicamente como si 
estuvieran en una red independiente, incluso si comparten la infraestructura de 
red con otras VLAN's.
- Pueden ser nombradas para su fácil identificación.
- Una VLAN es una subred lógica separada.
- Configuración básica:
    * Configurar la VLAN en el switch.
    * Asignar obligatoriamente un ID.
    * Asignar puertos a la VLAN.
    * Asignar un IP a las PC que representen a la VLAN.

**Beneficios de las VLAN**
- Seguridad: Agrupa los usuarios según el tipo de necesidades de la red.
- Reducción de costo: Uso eficiente del ancho de banda y menos actualizaciones 
de infraestructura.
- Alto rendimiento.
- Mitigación de tormentas de broadcast. Dividir una red en VLAN's, reduce la 
cantidad de dispositivos en participar en una tormenta de broadcast.
- Escalabilidad.

**Rangos de los VLAN ID**
- Rango Normal:
    * Diseñado para redes pequeñas y medianas.
    * VLAN ID entre 1 y 1005.
    * VLAN ID entre 1002-1005 reservado para Token Ring y FDDI.
    * Las vlans se almacenan en el archivo `vlan.dat` de la memoria flash.
- Rango extendido:
    * VLAN ID entre 1006 y 4094.
    * Diseñado para ISP's.
    * Almacenadas en el archivo 'running configuration'.

**Tipos de VLAN's**
- Port-based VLAN: Asociado con un puerto llamado 'access VLAN'.
- Data VLAN/User VLAN: Solo transporta tráfico generado por un usuario.
- Default VLAN:
    * Todos los puertos se vuelven miembros de la VLAN por defecto despues del 
    booteo inicial.
    * Permite que todos los dispositivos conectados a cualquier puerto puedan 
    comunicarse con otros dispositivos en otros puertos.
    * VLAN 1 es VLAN por defecto.
    * No se puede eliminar o renombrar.
    * CDP y STP son asociados a la VLAN 1.
- Native VLAN:
    * Es asignada a un trunk port 802.1Q.
    * Un puerto trunk 802.1Q soporta tráfico de cualquier VLAN(etiquetado) como
     tráfico que no viene de una VLAN(No etiquetado).
    * El tráfico no etiquetado se transporta por la VLAN nativa.
    * Sirve como un identificador común para orígenes y destino distintos de un
     enlace trunk.
- VLAN administrativa:
    * Es cualquier VLAN configurada para a las funciones de administración del 
    switch.
    * La VLAN 1 es la VLAN administrativa por defecto.
    * Se asigna una dirección IP y máscara de red.
- Voice VLAN:
    * Asegurar ancho de banda para asegurar la calidad de la voz.
    * Prioridad de transmisión sobre otro tipos de tráfico.
    * Habilidad para ser enrutado en áreas congestionadas.
    * Retardo menor de 150 ms a través de la red.

*T*ipos de tráfico**
    - Telefonía IP:
        * Tráfico de señales: Responsable de la configuración de las llamadas.
        * Tráfico de voz: La transmisión de los paquetes de la conversación en sí.
    - IP Multicast: Enviado desde un origen a un grupo multicast 
    identificado por una IP y una MAC destino del grupo multicast.
    - Data Normal: Tráfico relacionado con la creación y almacenamiento, 
    servicios de impresión, correo, y otras aplicaciones de red compartidas.

**Switch Ports**
- Interfaces de capa 2 asociadas a un puerto físico.
- Usados para administrar la interface fisica y asociarla a protocolos de capa 2.
- Pueden pertenecer a una o más VLAN's.
- Modos de Switch Port:
    * Static VLAN:
        • Los puertos a un switch son manualmente asignados a una VLAN.
        • Si la VLAN no existe, es creada cuando se asigna la VLAN al puerto.
    * Dynamic VLAN: Se asignan puertos del switch a las VLAN's dinamicamente, 
    basado en la dirección de MAC del dispositivo conectado al puerto que se 
    registran en un VMPS.
    * Voice VLAN:
        • Un puerto configurado para modo voz para que soporte teléfonos IP.
        • Tiene que ser configurado como VLAN de voz y datos.

**Dominios de broadcast con VLANs**
- Redes sin VLANs: Un switch recibe una trama de broadcast en uno de sus puertos
 y lo reenvia a todos los otros puertos del switch.
- Redes con VLANs: Cuando una trama de broadcast llega a un puerto asociado a 
una VLAN X, la trama solamente se envia a los puertos configurados que soportan
 la VLAN X.

Comunicación en VLANs
- Intra-VLAN: Cuando 2 dispositivos de la misma VLAN se comunican entre si.
- Inter-VLAN: Cuando 2 dispositivos de diferentes VLANs se comunican por medio 
de un enrutador.

**VLAN Trunk**
- Enlace punto a punto entre 2 dispositivos que transportan mas de una VLAN.
- Una VLAN Trunk no pertenece a una VLAN específica, más bien un conducto entre 
switches y enrutadores.
- Permite reducir la necesidad de puertos para que 1 o más VLANs se puedan 
comunicar entre 2 dispositivos, solo con el uso de un puerto en modo trunk.
- 802.1Q Frame Taggin:
    * La cabecera de una trama no contiene información acerca de la pertenencia
     a una VLAN.
    * El trunk etiqueta cada trama con la VLAN de pertenencia (PVID - Port VLAN ID) 
    utilizando el protocolo 802.1Q.

**VLAN Nativa y 802.1Q Trunking**
- Tramas etiqueteadas en VLANs Nativa:
    * Eliminadas por el switch.
    * Configurar dispositivos para que no envian tramas etiquetadas hacia una 
    VLAN Nativa.
- Tramas sin etiquetar en VLANs Nativa:
    * Los puertos en modo trunk reenvian las tramas sin etiquetar por la VLAN 
    Nativa.
    * Tienen el Port VLAN ID(PVID) cambiado al valor configurado por la VLAN de
     pertenencia.

**Configuración VLAN Nativa**
        S1#configure terminal
        S1(config)#interface [type][slot/port number]
        S1(config-if)#switchport mode trunk
        S1(config-if)#switchport trunk native vlan [number]

**Protocolos Trunk**
- Trunk 802.1Q:
    * Soporta tráfico etiquetado y no etiquetado.
    * Un puerto trunk 802.1Q es asignado a un PVID por defecto(Default VLAN) y 
    todo el tráfico sin etiquetar viaja sobre el puerto PVID por defecto.
    * Todo el tráfico sin etiquetar con un VLAN ID null se asume que pertenecen 
    al puerto PVID por defecto.
    * Un paquete con un VLAN ID igual al puerto PVID por defecto es enviado sin
     etiquetas, el resto del tráfico es enviado con un PVID etiquetado.

- ISL trunk:
    * Todo los paquetes son encapsulados con una cabecera ISL.
    * Las tramas nativas recibidas por un trunk ISL son eliminadas.

**DTP(Dynamic Trunking Protocol)**
- Protocolo propietario de CISCO.
- Negocia asociación trunk solo si el puerto en el otro lado del switch soporta 
DTP.
- DTP soporta 802.1Q e ISL.
- Trunking Modes:
    * ON(por defecto):
        - Envia tramas DTP periodicas, al puerto remoto.
        - Configurado con `switchport mode trunk`
        - El puerto siempre se consideran en un estado de trunking incondicional
         sin importar el tipo de mensaje que otorgue el puerto remoto.
    * Dynamic auto:
        - Envia tramas DTP periodicas al puerto remoto.
        - Configurado con `switchport mode dynamic auto`
        - Solamente entra a un estado trunking solo si el puerto remoto está 
        configurado como ON, o desirable.
        - Si ambos puertos están configurados como auto, se configuran en modo 
        acceso.
    * Dynamic desirable:
        - Envia tramas DTP periodicas al puerto remoto.
        - Configurado con `switchport mode dynamic desirable`
        - Entra a un estado trunking, solo si el puerto remoto está configurado 
        como on, desirable, o auto.
        - Si está en modo no negocia, el puerto se mantiene como no trunking.
    * Deshabilitar DTP
        - Permite que el switch no envie tramas DTP.
        - Configurado por `switchport nonegotiate`
        - El puerto local es considerado en un estado incondicional trunking.
        - Utilizado para configurar switches de diferentes marcas.

### **GRÁFICO RESUMEN DE MODOS TRUNK**

**Configuración de VLAN y Trunks**
Añadir una VLAN:

        S1#configure terminal
        S1(config)#vlan vlan id
        S1(config-vlan)#name vlan name
        S1(config-vlan)#end

Verificación:

        S1#show vlan brief

Asignar una VLAN a un puerto:

        S1#configure terminal
        S1(config)#interface [type][slot/number]
        S1(config-if)#switchport mode access
        S1(config-if)#switchport access mode vlan [number]

Elimina una VLAN a un puerto:

        S1#configure terminal
        S1(config)#interface [type][slot/number]
        S1(config-if)#no switchport access mode vlan // Reasigna el puerto a la VLAN por defecto.

Eliminar una VLAN:

        S1(config)#no vlan [id]

Eliminar todas las VLAN:

        S1#delete flash:vlan.dat

Configurar trunk 802.1Q

        S1#configure terminal
        S1(config)#interface [type][slot/number]
        S1(config-if)#switchport mode trunk //Se habilita DTP por defecto.
        S1(config-if)#switchport trunk native vlan [number] //Especifica una vlan nativa diferente a la vlan por defecto.

Convertir de trunk a modo acceso:

        S1#configure terminal
        S1(config)#interface [type][slot/number]
        S1(config-if)#switchport mode access

Reasignar la vlan nativa como la vlan por defecto.

        S1#configure terminal
        S1(config)#interface [type][slot/number]
        S1(config-if)#no switchport trunk native.

**Resolución de problemas**
- VLANs Nativas diferentes: Un enlace está configurado con diferentes VLANs Nativas en sus puertos.
- Modo trunk diferentes.
- Subredes diferentes.Módulo 4:

# VTP(VLAN Trunking Protocol)
- Permite propagar configuraciones de VLANs a otros switches en la red.
- Solo soporta VLANs de rango normal (ID 1-1005).
- Varios tipos de VTP:
    * VTP Server: Distribuye y sincroniza información de VLANs a los VTP clientes.
    * VTP Cliente
    * VTP Transparente
- No funciona si los enlaces trunk en una red de switches que soporta VTP no 
están activos.

**Beneficios de VTP**
- Configuración de VLANs consistente a través de la red.
- Monitoreo y seguimiento de las VLANs.
- Configuración dinámica Trunk cuando las VLANs son añadidas a la red.

**Componentes del VTP**
- Dominio VTP:
    * Consiste en uno o más switches interconectados que comparten los mismos 
    detalles de configuración de VLANs utilizando notificaciones VTP.
    * Permite limitar la extención en la cual las cambios de configuración son 
    propagados en la red si un error ocurre.
- Notificaciones VTP:
    * Sistema jerárquico de notificaciones para distribuir y sincronizar 
    configuraciones de VLANs en un mismo dominio VTP.
    * Trama VTP: Imbuida en el campo de DATA de una trama normal de capa 2. 
    Contiene los siguientes campos:
        - Nombre de dominio.
        - Tamaño del nombre de dominio.
        - Versión.
        - Número de revisión de la configuración.
            - Determina si la información de configuración recibido desde otro 
            swtich VTP es más reciente que la información de configuración 
            almacenada.
            - Valor de 32 bits que indica el nivel de revisión de una trama VTP.
            - Valor por defecto es 0.
            - Cada vez que una VLAN es añadida o eliminada, el número de revisión
             se incrementa.
            - Cada dispositivo revisa su propia revisión de configuración VTP.
            - El cambio de nombre de dominio reinicia el contador del numero de 
            revisión de configuración VTP.
    * Las notificaciones se envia a una dirección multicast que representa al 
    dominio.
    * 3 tipos de notificaciones:
        - Summary Advertisement:
            - Contiene el nombre de dominio, el actual número de revisión y 
            otros detalles VTP.
            - Enviados cada 5 minutos por un VTP server o cliente, o 
            inmediatamente un cambio ocurra.
        - Subset Advertisement: Contiene información de VLANs y vienen luego de 
        un summary advertisement que responde a un request advertisement del 
        cliente, se dan por, 
            - Crear o eliminar VLANs.
            - Suspender o activar VLANs.
            - Cambiar el nombre de una VLAN.
            - Cambiar el MTU de una VLAN.
        - Request Advertisement: Enviados para requerir información VTP a un servidor
        VTP en un mismo dominio. Se dan por,
            - El nombre de dominio VTP ha cambiado.
            - El switch recibe un summary advertisement con una configuración de
             revisión más alta.
            - El switch ha sido reiniciado.

**Modos VTP**
- VTP Server:
    * Notifican la información VLAN del dominio VTP a los otros switches en el 
    mismo dominio VTP.
    * Almacenan la información de VLANs de todo el dominio en la NVRAM.
    * Pueden crear, eliminar o renombrar VLANs.
- VTP Cliente:
    * Funcionan igual que un VTP Server.
    * No pueden crear, eliminar o renombrar VLANs.
    * Almacena la información en la vlan database.
    * Cuando se reinicia se envia un requerimiento a un VTP server para actualizar
     la información de configuración de VLANs.
- VTP Transparente:
    * Reenvia las notificaciones VTP de los VTP clientes y VTP servers.
    * No participan en un dominio VTP.
    * Pueden crear, eliminar o renombrar VLANs, pero se almacenan localmente(NVRAM).
- VTP Pruning:
    * Aumenta el ancho de banda disponible restringiendo tráfico broadcast, 
    multicast e unicast producido por un dominio VTP a los enlaces trunk que el 
    tráfico utiliza para alcanzar dispositivos destinos.

**VTP configuración por defecto**
- VTP version = 1
- VTP Domain Name = null
- VTP mode = Server
- Config Revision = 0
- VLANs = 1

**Configuración VTP**
- Todos los switches tienen que estar en configuración por defecto.
- La *MISMA CONTRASEÑA* VTP debe ser configurada en todos los swtiches del dominio VTP.
- Todos *los switches deben tener la MISMA VERSIÓN de VTP*.
- VTP solo se intercambia en los puertos trunk.

**VTP Servers**
- Siempre reiniciar el número de revisión.
- Configurar el switch en modo VTP Server.
- Configurar al menos 2 VTP servers.
- Configurar un dominio VTP.
- Los nombres de dominio en diferentes servidores tienen que ser los mismos. 
*Son sensitivos a las mayúsculas y minúsculas*.
- Crear las VLANs despúes de que se han habilitado VTP y el VTP server.
- Las VLANs creadas antes de crear el VTP server son eliminadas.

        S1#configure terminal
        S1(config)#vtp domain [name]
        S1(config)#vtp mode server
        S1(config)#vtp version 1
        S1(config)#exit
        S1#show vtp status

- Luego añadir VLANs a su gusto.

**VTP Clients**
- Configurar el switch en modo VTP Client.
- Configurar trunks
- Conectar al VTP Server.
- Configurar puertos de acceso.

        S1#configure terminal
        S1(config)#vtp mode client
        S1(config)#exit
        S1#show vtp status

**Resolución de problemas VTP**
- Versiones VTP incompatibles.
- Contraseñas VTP diferentes.
- Modo VTP incorrecto.
- Todos los switches son configurados como clientes.

Módulo 5: Spanning Tree Protocol
Redundancia:
•
•
•
Mejora la disponibilidad de la red implementando rutas alternativas añadiendo equipo y cableado.
Se implementa en la capa de distribución y core.
Loops Capa 2:
• Inundación infinita de broadcast ethernet por no contar con TTL en dos o más switches. Las tramas
broadcast se reenvian a todos los puertos excepto el puerto que las originó consumiendo ancho de banda.
• Dúplicación de tramas unicast al ser enviada por más de un camino, cuando no se conoce el destino en la
tabal mac del switch.
Spanning Tree Protocol(STP)
•
•
•
•
Asegura una sola ruta lógica entre todos los destino de una red bloqueando intencionalmente rutas redundantes que
puedan causar un loop.
Un puerto bloqueado es cuando se previene que ingrese o envié tráfico, salvo que el tráfico sean BPDU.
STP se recalcula cada vez que un camino lógico no este disponible.
Utiliza una dirección de multicast para comunicarse con otros swtich, los switches no configurados con multicast
descartan el BPDU.
Algoritmo STP
•
•
Designa y utiliza un switch como root bridge para calcular todas las rutas posibles.
Todos los switches envian tramas BPDU para determinar que switch tiene el menor BID(Bridge ID), el menor BID
automáticamente lo convierte en root bridge.
• BPDU:•
•
•
•
•
•
Trama intercambiada por los switches para información STP.
Contiene el BID que identifica el switch que envió el BPDU.
Enviados cada 2 segundos después del booteo de un switch
BID:
• Contiene la prioridad.
• MAC del switch que envió el BPDU.
• ID opcional del sistema extendido.
• El BID es determinado por la combinación de estos valores.
Cada switch utiliza el STA para determinar el camino más corto hacia el switch y el puerto a bloquear, mientras
tanto todo el tráfico se bloquea hasta que se terminé el STA.
Una vez determinado cuáles son las rutas permitidas, configura los puertos del switch en diferentes roles, los cuales
describen la relación en la red con el root bridge y si estos están permitidos de reenviar tráfico.
• Puertos raíz: Puertos de switch más cercanos al root bridge.
• Puertos designados: Todos los que no son puertos raíz que son permitidos de reeniar tráfico en la red.
• Puertos no designados: Todos los puertos configurados para estar en un estado de bloque y prevenir loops.
Root Bridge
•
•
•
•
Punto de referencia para todos cáculos del STA determinando las rutas óptimas hacia el root bridge para determinar
las rutas redundantes a bloquear.
Cada switch se considera a sí mismo root bridge cuando bootea.
Campos del BID:
• Bridge Priority:
• Extendend System ID:
• MAC Address
Costo de la ruta:
• Determinada por la suma de los costos de los puertos hacia el root bridge.
• La ruta con menor costo es la considerada y todas las demás bloqueadas.
• DIBUJO de los COSTOS DEL PUERTO 5.2.1.4
• S#configure terminal
• S(config)#interface [type][number]
• S(config)$spannin-tree cost [cost-number]
BPDU
•
•
Contiene 12 campos distintos utilizados para definir la ruta y la prioridad que STP utiliza para determinar el root
bridge.
Cuando un switch adyascente recibe una trama BPDU, se comparan los root ID del BPDU con el root ID local. Si
el root ID en el BPDU es menor que el root ID local, el switch actualiza el root ID local y el nuevo BPDU con el
root ID menor. Estos mensajes sirven para indicar que el nuevo root bridge de la red. También, el costo de la ruta es
actualizado indicando que tan lejos se encuentra el root bridge. Si el root ID del BPDU es menor que el root ID
local, el BPDU se descarta.
BID(Bridge ID)
•
•
•
Usado para determinar el root bridge.
Valor por defecto 24576.
El campo BID en una trama BPDU contiene
• Bridge priority
• Valor para influenciar al switch para que se convierta en root bridge.
• El switch con menor prioridad será el root bridge.
• La prioridad del rango es de 1, 65536.
• Extended system IDSe añade al valor bridge priority en el BID para identificar la VLAN y el BID en una trama
BPDU.
Dirección MAC.
• Cuando 2 switches son configurados con la misma prioridad y tiene el mismo extended system
ID, la MAC con el menor valor hexadecial se convierte en el root bridge.
•
•
Port Roles:
•
•
Port
El rol del puerto se determina según donde se encuentra el root bridge y el algoritmo STA.
Tipos
• Root Port:
• Es el puerto con el camino más corto hacia el root bridge. Si 2 o más puertos tienen el mismo
costo hacia el root bridge, se considera la prioridad del puerto o el port id(Número de interface).
El port id es añadido a la prioridad del puerto: 128.1 seria prioridad 128 con port id igual a 1.
• Existe en non-root bridges y es el puerto del switch.
• Reenvian tráfico hacia el root bridge.
• Solamente un root port por switch.
• Designated Port:
• Existe en el root y non-root bridges.
• Todos los puertos del root bridge son puertos designados.
• En non-root bridges, un puerto designado es un puerto del switch que recibe y reenvia tramas a
hacia el root bridge.
• Solamente un puerto designado es permitido por segmento.
• Non-designated Port:
• Es un puerto del switch que está bloqueado, no reenvia tramas ni llena la MAC address table con
direcciones de origen.
• Disabled Port:
• Es un puerto del switch que ha sido apagado administrativamente.
• No funciona en el proceso STP.
States:
VER
5
posibles
estados
GRÁFICO
del
puerto
DE
del
switch
en
el
PUEROTS
intercambio
de
las
tramas
DE
BPDU timers:
•
•
•
•
El tiempo que un puerto está en un tipo de estado depende de los BPDU timers.
Solo el root bridge puede alterar los timers BPDU.
Spanning tree puede tener un diametro máximo de 7 debido a los BPDU timers.
Tipos:
• Hello time: Tiempo entre cada BPDU se envia a un puerto, 2s por defecto.
• Forward delay: Tiempo en el estado listening y learning, son 15s por defecto para cada estado.
• Maximun age: Tiempo máximo para almacenar información BPDU, es 20s por defecto.
Convergencia STP: 3 pasos
•
•
•
Elegir al root bridge:
Elegir a los root ports:
Elegir a los designated y non-designated ports:
Variantes STP
BPDU.
ESTADO.•
Cisco
•
PVST
•
•
•
•
•
•
•
PVST+
•
•
Cada VLAN es una instancia del spanning tree.
Permite balance de carga de capa 2.
Incluye extenciones STP
Soporta ISL y 802.1Q trunking protocol
Incluye extensiones STP
Rapid-PVST+
•
IEEE Estandar
• RSTP
•
•
•
Utiliza ISL trunking protocol
Convergencia más rápida que 802.1D
Convergencia más rápida que 802.1D
Implementaciones genericas de extenciones STP de Cisco.
MSTP
•
Varias
VLans
pueden
ser
asociadas
a
una
misma
instancia
del
spanning
tree.
PVST+
• Una instancia STP por VLAN, da como resultado que pueda existir varios root bridge
por la cantidad de VLAN's.
• Bridge ID: 8bytes.
• Bridge priority: 4 bits.
• Extended system ID: 12 bits o también llamado VLAN ID.
• MAC Address: 6 bytes.
• Es el modo por defecto de los switches CISCO.
• Configuración de root bridges para cada VLAN:
• S(config)#spanning-tree vlan [vlan-ID] root primary
• S(config)#spanning-tree vlan [vlan-ID] root secondary
RSTP
•
•
•
•
•
Evolución del estándar 802.1D
No tiene un estado de puerto bloqueado, los estado son:
• Discarding.
• Learning.
• Forwarding
Características:
• Protocolo de preferencia para evitar loops de capa 2.
• Provee rápida convergencia después de una falla de un switch, enlace o puerto.
• No es compatible con las extensiones de Cisco, UplinkFast, BackboneFast.
• Define diferentes estados de puertos y roles.
• Mantiene compatibilidad hacia atrás con STP.
• La mayoría de parámetros entre STP y RSTP se mantienen.
• Mismo formato BPDU que STP.
RSTP BPDU
• Utiliza la version 2 de RSTP.
• 3 paquetes BPDU sin respuesta se considera como pérdida de conectividad.
• Se envian paquetes RSTP BPDU cada 6 segundos.
• Permite detectar fallas en la red rápidamente.
Edge Port:
• Nunca estarán conectados hacia otro switch, siempre a host terminales.Cambia inmediatamente a estado forwarding.
Funciona como un puerto configurado con Cisco PortFast.
Configuración:
• s(config-if)#spanning-tree portfast
• Non Edge Port:
• Siempre están conectados hacia otro switch.
• Tipos de Enlace:
• Categoriza cada puerto que participa en RSTP.
• El tipo de enlace puede predeterminar el papel activo que juega el puerto en su forma actual por
la transición inmediata al estado de envío, si se cumplen ciertas condiciones.
• Root ports, alternate y backup ports no utilizan el tipo de enlace.
• Designated ports utilizan el parámetro de tipo de enlace.
• Port States:
• Causados por un cambio en la topología.
• Un rol de puerto puede transitar varios estados de puerto.
• Tipos:
• Discarding:
• Previene reenviar tramas de datos.
• Puede darse en un estado activo de la topología.
• Puede darse en la convergencia de la topología.
• Learning:
• Acepta tramas para llenar la tabla MAC para limitar el envio de tramas unicast
desconocidas.
• Puede darse en un estado activo de la topología.
• Puede darse en la convergencia de la topología.
• Forwarding:
• Puede darse solo en un estado activo de la topología.
• Ocurre después del "proposal & agreement process".
GRAFICO PORT STATES DE STP VS RSTP.
• Port Roles:
• Define el propósito del puerto del switch y como maneja las tramas de datos.
• Tipos:
• Root port:
• Puerto escogido que dirige al root bridge.
• Un solo root port por switch.
• Designated port:
• Recibe tramas de un segmento que son destinados al root bridge.
• Solo un puerto designado por segmento.
• Tiene estado forwarding.
• Alternate port:
• Ofrece una ruta alterna hacia el root bridge.
• Tiene un estado de discarding por defecto.
• Se presentan en switches no designados como root bridge.
• Se activan si la ruta designada falla.
Revisar Proposal and Agreement Process 5.4.6
•
•
•
Rapid-PVST+
• Mantiene una instancia de STP por cada VLAN.
• Los parámetros de Rapid-PVST+ son activados cuando se encuentra un loop de STP.
• Configuración:
• S(config)#spanning-tree mode rapid-pvst
• S(config-if)#spanning-tree link-type point-to-point
• S#clear spanning-tree detected-protocols
• Si un puerto local configurado con Rapida-PVST+ se convierte en puerto designado, y el puerto remoto
tbn está configurado en un estado punto-a-punto; entonces el puerto local pasa a un estado de forwarding.Buenas prácticas STP:
• Generalmente escoger el switch más poderoso para root bridge.
• Localizar el root bridge entre los server - routers - clientes para optimización de cantidad de saltos.
• Para cada VLAN, configurar el root bridge y el backup root bridge utilizando prioridades bajas.
• Mantener una estructura jerarquica y conocer los enlaces redundantes para saber que puertos bloquear.
• Minimizar el número de puertos bloqueados.
• Utilizar VTP pruning para minimizar puertos bloueados
• No deshabilitar STP, no utiliza muchos recursos.
• Mantener tráfico de los usuario fuera de la VLan administrativa.
• VLan 1 sirve como VLan administrativo, donde todos los switches acceden en la misma subred, un loop en la
Vlan 1 puede dar de baja a toda la red.
Resolución de problemas STP:
• Errores ocurren cuando se envian BPDU sin respuesta hacia puertos bloqueados, con el resultado que el puerto
bloqueado se cambia a un estado de forwarding, generando un loop de capa 2.
• Resolución:
• Conocer la topología.
• Conocer el lugar del root bridge.
• Conocer el lugar de los puertos designados y bloqueados.
• Error de configuración PortFast al ser configurado en un puerto que se conecta a otro switch.
• PortFast cambia de un estado bloqueado a forwarding automáticamente.
• Resolución:
• No configurar PortFast en puertos que se conectan a otros switches.
• Esperar que el STP bloquee el puerto.
• Error por tamaño de la red
Módulo
•
•
6:
Inter-Vlan Routing:
Tradicionalmente el enrutamiento es conectando diferentes interfaces físicas del enrutador a diferentes puertos del
switch en modo acceso definiendo diferentes VLAN's a cada puerto.
Router-on-a-stick:
• Enrutadores que pueden transportar múltiples VLAN's por una interface física.
• Acepta tráfico etiquetado con la VLAN origen por la interface trunk adyascente utilizando subinterfaces,
para luego reenviarlo por la misma interface hacia la VLAN destino.
• Pueden
ser
hechos
por
switches
de
capa
3
o
enrutadores.
Subinterfaces:
• Interface virtuales basadas en software que son asignadas a una interface física.
• Permite que una interface física mantenga varias redes lógicas.
• Mantiene el mismo tipo de enrutamiento que las interfaces tradicionales.
• La interface física debe estar conectada a un enlace trunk hacia el switch adyascente que etiqueta
los paquetes con su VLAN asociada.
• Cada interface se configura su dirección IP de la VLAN de pertenencia, máscara y VLAN única.
• Configuración:
• R(config)#interafece [type][number]/[number].[vlan-id] //no requerido que sea el vlan-id
• R(config-subif)#encapsulation dot1q [vlan id]
• R(config-subif)#ip address [IP address][IP mask]
• R(config-if)#interafece [type][number]
• R(config-if)#no
shutdown
