FROM nginx:latest

WORKDIR /files/index.html

COPY index.html /usr/share/nginx/files/index.html


COPY index.css /usr/share/nginx/files/index.css


COPY index.js /usr/share/nginx/files/index.js



EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
