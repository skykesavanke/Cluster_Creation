FROM nginx:stable-alpine

COPY index.html /usr/share/nginx/html/index.html


COPY index.css /usr/share/nginx/html/index.css


COPY index.js /usr/share/nginx/html/index.js



EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
