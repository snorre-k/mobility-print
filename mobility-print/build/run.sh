#!/bin/bash

# Check CUPS dir exists
if [ -d /etc/cups ]; then
  # Check cups dir empty
  if [ -z "$(ls -A /etc/cups)" ]; then
    echo "Copy original CUPS config files to /etc/cups"
    cp -a /etc/cups.orig/* /etc/cups
  fi
else
  echo "Copy original cups config dir to /etc/cops"
  cp -a /etc/cups.orig /etc/cups
fi

# Copy Certs (if they exist)
if [ -f /etc/cups/ssl/own.crt ]; then
  if [ -f /etc/cups/ssl/own.key ]; then
    echo "Deploying SSL Certi (cups & papercut)"
    cp -a /etc/cups/ssl/own.crt /etc/cups/ssl/$(hostname -f).crt
    cp -a /etc/cups/ssl/own.key /etc/cups/ssl/$(hostname -f).key
    cp -a /etc/cups/ssl/own.crt /home/papercut/pc-mobility-print/data/tls.cer
    cp -a /etc/cups/ssl/own.key /home/papercut/pc-mobility-print/data/tls.pem
    # Cleanup CUPS SSL dir
    echo "Cleaning up CUPS cert dir"
    find /etc/cups/ssl -type f ! -name "$(hostname -f).*" ! -name "own.*" -exec rm {} \;
  fi
fi

# Start Supervisor
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf


