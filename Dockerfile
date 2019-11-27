################### 
## Simple Node js
###################

FROM node:13.1.0-alpine3.10
MAINTAINER test nodejs 
LABEL "app"="nodejs"
WORKDIR /app
COPY   ./app/package.json ./
COPY   ./config/entrypoint.sh /usr/local/bin/

RUN npm install \
    && chmod +x  /usr/local/bin/entrypoint.sh

COPY ./app/server.js /app 

EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["node", "server.js"]
