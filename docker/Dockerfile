FROM node:24-alpine AS build

WORKDIR /usr/app

COPY file.ext file2 ./
COPY . .

# secret mounting
RUN --mount=type=secret,id=ENV_ID,mode=0444 \
  --mount=type=secret,id=ENV_ID_2,mode=0444 \
  export ENV_ID=$(cat /run/secrets/ENV_ID)  && \
  export ENV_ID_2=$(cat /run/secrets/ENV_ID_2)  && \
  npm command

ENV ENV_3= \
  ENV_4= \
  ENV_5= 

USER node
ENTRYPOINT [ "node" ]
CMD [ "server.js" ]