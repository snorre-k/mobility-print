# PaperCut MobilityPrint together with a CUPS printserver

## CUPS setup

For Initial CUPS Setup - please follow these steps:

 - Enable host network in ```docker-compose.yml```
 - Start container: ```docker-compose up -d```
 - Container Bash: ```docker exec -it mobilityprint bash```
   + Setup AVAHI
     * ```apt-get update && apt-get install avahi-daemon cups-browsed```
     * ```/etc/init.d/dbus start && /etc/init.d/avahi-daemon start```
   + Set root password for CUPS admin management
     * ```passwd```
 - Configure CUPS to find network or direct attached (not tested) printers
   + https://%servername%:631/admin
   + Add Printers - e.g. IPP (ipp://printer.fqdn:631/ipp/print) - Driver: Manufact. -> driverless cups filter
 - Disable host network
 - Restart container: ```docker-compose up -d```

If you have configured the virtual CUPS PDF printer you can enable the volume mount of ```/var/spool/cups-pdf/ANONYMOUS```

## Own Certs for CUPS and MobilityPrint

Optional create the folder and then copy your cert and keyfile to the following folder:```./mobility-print/cups-config/ssl```.
The files have to be named ```own.crt``` and ```own.key```.
