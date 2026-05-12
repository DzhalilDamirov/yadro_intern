FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY section1/httpstat.sh ./httpstat.sh
RUN chmod +x /app/httpstat.sh

ENTRYPOINT ["/app/httpstat.sh"]
