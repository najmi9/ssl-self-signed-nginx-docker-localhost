FROM nginx:stable-alpine

COPY nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY dhparam.pem /etc/nginx/dhparam.pem
