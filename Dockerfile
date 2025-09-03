FROM bitnami/spark:3.5.6

USER root

RUN mkdir -p /app && \
    groupadd -g 1000 sparkuser && \
    useradd sparkuser -u 1000 -g 1000 -s /bin/bash && \
    chown -R sparkuser:root /opt/bitnami/spark && \
    chown -R sparkuser:sparkuser /app

WORKDIR /app

USER sparkuser
