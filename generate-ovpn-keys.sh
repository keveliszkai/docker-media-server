#!/bin/sh
# INFO: https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

#!/bin/bash

VPN_CLIENTNAME="DMS"
VPN_URL="udp://x.x.x.x"
VPN_SERVICE="dms-openvpn"

VALID_ARGS=$(getopt -o c:u:s --long vpn-client:,vpn-url:,vpn-service: -- "$@")

eval set -- "$VALID_ARGS"

while [ : ]; do
  case "$1" in
    -c | --vpn-client)
        VPN_CLIENTNAME="$2"
        shift 2
        ;;
    -u | --vpn-url)
        VPN_URL="$2"
        shift 2
        ;;
    -s | --vpn-service)
        VPN_SERVICE="$2"
        shift 2
        ;;
    --) shift; 
        break 
        ;;
  esac
done

#Initialize the configuration files and certificates
docker-compose run --rm $VPN_SERVICE ovpn_genconfig -u $VPN_URL
docker-compose run --rm $VPN_SERVICE ovpn_initpki

# with a passphrase (recommended)
docker-compose run --rm $VPN_SERVICE easyrsa build-client-full $VPN_CLIENTNAME

# without a passphrase (not recommended)
# docker-compose run --rm $VPN_SERVICE easyrsa build-client-full $VPN_CLIENTNAME nopass

# Retrieve the client configuration with embedded certificates
docker-compose run --rm $VPN_SERVICE ovpn_getclient $VPN_CLIENTNAME > $VPN_CLIENTNAME.ovpn