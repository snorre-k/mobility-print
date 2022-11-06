# PaperCut MobilityPrint together with a CUPS printserver

## Requirements
- docker
- docker-compose

## Available container images
- `snorre0815/mobility-print` - DockerHub
- `ghcr.io/snorre-k/mobility-print` - GHCR

## Build yourself
`docker-compose build`

## Running the container
The [docker-compose.yml](https://github.com/snorre-k/mobility-print/blob/main/docker-compose.yml) is configured to use a self built image. If you want to use prebuilt images, please adapt the `image:` lines. Also comment the `build:` line.
- Start: `docker compose up -d`
- Stop: `docker-compose down`

## CUPS setup
For Initial CUPS Setup - please follow these steps:

 - Enable host network (`network_mode: host`) in `docker-compose.yml`
 - Start container: `docker-compose up -d`
 - Start container Bash: `docker exec -it mobilityprint bash`
   + Setup AVAHI
     * `apt-get update && apt-get install avahi-daemon cups-browsed`
     * `/etc/init.d/dbus start && /etc/init.d/avahi-daemon start`
   + Set root password for CUPS admin management
     * `passwd`
 - Configure CUPS to find network or direct attached (not tested) printers
   + Management URL: https://docker.server.fqdn:631/admin
   + Add Printers - e.g. IPP (`ipp://printer.fqdn:631/ipp/print`) - Driver: Manufact. -> driverless cups filter
 - Disable host network (`network_mode: host`) in `docker-compose.yml`
 - Restart container: `docker-compose up -d`

If you have configured the virtual CUPS PDF printer you can enable the volume mount of `/var/spool/cups-pdf/ANONYMOUS`

## Own Certs for CUPS and MobilityPrint
Optional create the folder and then copy your cert and keyfile to the following folder:`./mobility-print/cups-config/ssl`.
The files have to be named `own.crt` and `own.key`.
