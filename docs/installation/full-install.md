# Full YaCy installation guide
##### (systemd or runit, nginx, let's encrypt)

## Prerequisites
- Any UNIX-like system which has Nginx, Certbot and Wget in its repos (assuming your distribution is Debian, but actually you can install it even on StaLI.
- A domain name
- Systemd or Runit-powered UNIX-like system (for using on Runit system, see this: https://aur.archlinux.org/packages/yacy-runit)
- `also, if anyone reading it has some free time, please write services and instructions for their installation for sysvinit, openrc, dinit, etc...`

## Installation
#### Note: `#` before the command means running as root.
**1.** Install needed packages:
```
# apt install nginx certbot python3-certbot-nginx wget openjdk-17-jdk-headless
```

**2.** Create a user needed for running YaCy
```
# useradd --system yacydm -m -d /home/yacy
# useradd --system yacy -m -d /home/yacy
```

**3.** Download, unpack and fix permissions for YaCy\*, please replace download link with new one **for *"Linux"*** located [here](https://yacy.net/download_installation/#download)
#### `$` here means running as user created later, not your own user.
```
# su -l yacy

$ wget https://release.yacy.net/yacy_latest.tar.gz
$ tar -xf yacy_v1.930_202404051704_de941c6fe.tar.gz -C ..
$ exit

# chown -R yacydm:yacydm /home/yacy/
# chown -R yacy:yacy /home/yacy/DATA/
```

**4.** Install systemd service (runit instructions are missing, so if anyone write it, I would be grateful. Write by editing this page on GitHub.)
```
# cat > yacy.service << EOF
[Unit]
Description=YaCy P2P Search Server
After=network.target

[Service]
Type=forking
User=yacy
ExecStart=/home/yacy/startYACY.sh
ExecStop=/home/yacy/stopYACY.sh
ExecRestart=/home/yacy/restartYACY.sh

[Install]
WantedBy=multi-user.target
EOF

# cp yacy.service /etc/systemd/system/
# systemctl enable --now yacy.service
```

**5.** Add Nginx site
```
# cat >> yacy-nginx << EOF
server {
        server_name [your domain name];
        access_log /var/log/nginx/search-access.log;
        error_log /var/log/nginx/search-error.log;

        location / {
                proxy_pass http://127.0.0.1:8090;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Real-IP $remote_addr;
        }
}
EOF
# cp yacy-nginx /etc/nginx/sites-available/yacy
# ln -s /etc/nginx/sites-{available,enabled}/yacy
# nginx -t
# nginx -s reload
```

**6.** Let's Encrypt!
```
# certbot --nginx -d [your domain name]
```

Now you can visit `https://[your domain name]/` from your phone or whatever you use and see the YaCy search page!
