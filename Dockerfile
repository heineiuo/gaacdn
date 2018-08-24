FROM node:10.9.0-alpine

RUN mkdir -p /root/gaacdn

COPY package.json /root/gaacdn/package.json
COPY dist /root/gaacdn/dist

WORKDIR /root/gaacdn

RUN npm install --only=production --registry=https://r.cnpmjs.org \
  && rm -rf /tmp/* \
  && rm -rf /root/.npm/
  
EXPOSE 8050

CMD [ "node", "dist/index.js" ]
