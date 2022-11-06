FROM ubuntu:22.04

RUN \
  apt-get update -q -q && \
  apt-get --yes upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends --yes install \
    wget ca-certificates sudo iproute2 iptables \
    ghostscript cups cups-pdf cups-bsd printer-driver-gutenprint \
    supervisor && \
#  DEBIAN_FRONTEND=noninteractive apt-get --no-install-recommends --yes install less vim bind9-utils && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm && \
  echo "Install done"

RUN \
  /etc/init.d/cups start && \
  cupsctl --remote-admin && \
  cupsctl --remote-any && \
  sed -i '1s/^/ServerAlias *\n/' /etc/cups/cupsd.conf && \
  cp -a /etc/cups /etc/cups.orig && \
  echo "Setup CUPS done"

RUN \
  wget -nv https://www.papercut.com/api/product/mobility-print/latest/server/linux/ && \
  mv index.html setup.sh && \
  chmod +x setup.sh && \
  useradd -m -d /home/papercut papercut && \
  echo "papercut   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers && \
  su - -p papercut -c "/setup.sh --non-interactive" && \
  rm /setup.sh && \
  echo "Install PaperCut done"

COPY supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor/_*.conf /etc/supervisor/conf.d/
COPY run.sh /run.sh
RUN chmod +x /run.sh
VOLUME /var/cache/cups

CMD ["/run.sh"]
