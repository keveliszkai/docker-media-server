# [DMS] Docker media server

## Steps

```
git clone https://github.com/keveliszkai/docker-media-server.git
```

```
docker-compose up -d
```

```
chmod +x ./generate-ovpn-keys.sh
```

```
./generate-ovpn-keys.sh --vpn-url "udp://x.x.x.x" --vpn-client "DMS-USER" --vpn-service "dms-openvpn"
```

Install Nextcloud

Set trusted domains

```
docker-compose exec --user www-data dms-nextcloud php occ config:system:set trusted_domains 0 --value=<IP-ADDRESS>
docker-compose exec --user www-data dms-nextcloud php occ config:system:set trusted_domains 1 --value=<DOMAIN>

docker-compose exec --user www-data dms-nextcloud php occ config:system:get trusted_domains
```

```
Install plugin NcDownloader for torrent
```
