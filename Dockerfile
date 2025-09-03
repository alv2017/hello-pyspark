FROM bitnami/spark:3.5.6

USER root

RUN groupadd -g 1000 sparkuser
RUN useradd sparkuser -u 1000 -g 1000 -s /bin/bash
RUN chown -R sparkuser:root /opt/bitnami/spark

WORKDIR /opt/bitnami/spark

USER sparkuser