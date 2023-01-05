FROM ubuntu:22.04

RUN apt update && apt-get --no-install-recommends install -y python3-pip mosquitto-clients python3-dev gcc && \
    pip install python-miio && \
    apt remove -y python3-dev gcc && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /miio
COPY run.sh /miio/

ENTRYPOINT ["/miio/run.sh"]