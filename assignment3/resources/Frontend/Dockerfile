FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY ./fix-nginx-conf.sh /usr/src/

WORKDIR /usr/src

VOLUME /hypervisor_etc

EXPOSE 80

RUN echo "./fix-nginx-conf.sh $CC_BACKEND_SERVERS" > entrypoint.sh; \
    echo "nginx" >> entrypoint.sh


CMD ["bash", "./entrypoint.sh"]