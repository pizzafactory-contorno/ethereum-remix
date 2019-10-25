FROM pizzafactory0contorno/piatto:alpine as builder
ARG REMIX_TAG=v0.7.5

USER root
RUN apk add npm alpine-sdk python git
RUN mkdir /remix-ide && chown user /remix-ide
WORKDIR /
RUN git clone -b $REMIX_TAG https://github.com/ethereum/remix-ide.git
USER user
WORKDIR /remix-ide
RUN npm install

RUN sed -i \
      -e 's#127.0.0.1#0.0.0.0#g' \
      node_modules/remixd/src/websocket.js
RUN sed -i \
      -e 's#./contracts#/projects#g' \
      -e 's#http://127.0.0.1:8080#http://0.0.0.0:8080#g' \
      package.json
RUN npm run build

FROM pizzafactory0contorno/piatto:alpine
USER root
RUN apk add --no-cache npm && \
    mkdir /remix-ide && chown user /remix-ide
USER user
COPY --from=builder /remix-ide /remix-ide
ADD start-remix-ide.sh /

EXPOSE 8080 65520

CMD [ "/start-remix-ide.sh" ]
