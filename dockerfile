FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD root
COPY ./priv.sql