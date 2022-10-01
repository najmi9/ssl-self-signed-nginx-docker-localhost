### Creating the SSL Certificate

TLS/SSL functions by a combination of a public certificate and a private key. The SSL key is kept secret on the server and encrypts content sent to clients. The SSL certificate is publicly shared with anyone requesting the content. It can be used to decrypt the content signed by the associated SSL key.

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```

While using OpenSSL, you should also create a strong Diffie-Hellman (DH) group, which is used in negotiating Perfect Forward Secrecy with clients.

You can do this by typing:

```bash
sudo openssl dhparam -out /etc/nginx/dhparam.pem 4096
```

### Configuring Nginx to Use SSL

```conf
server {
    server_name 127.0.0.1;
    listen 443 ssl;
    listen [::]:443 ssl;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/nginx/dhparam.pem;
    root /usr/share/nginx/html;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name 127.0.0.1;
    return 301 https://$server_name$request_uri;
}
```
