FROM ubuntu:18.04

RUN apt-get update && apt-get install -y build-essential git \
    libpcre3-dev libcurl4-openssl-dev libcurl4 luarocks lua5.3 lua5.3-dev \
    haproxy apt-transport-https ca-certificates
    
    
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
    && apt purge --auto-remove cmake && apt-get update -y && apt-get install -y cmake

COPY install-c-server-sdk.sh .
RUN ./install-c-server-sdk.sh

ADD https://github.com/launchdarkly/lua-server-sdk/archive/1.0.0-beta.3.zip \
    /tmp/lua-server-sdk/sdk.zip

RUN cd /tmp/lua-server-sdk/ && \
    unzip sdk.zip && \
    cd lua-server-sdk-1.0.0-beta.3 && \
    luarocks make launchdarkly-server-sdk-1.0-0.rockspec

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY service.lua /service.lua

CMD haproxy -d -f /etc/haproxy/haproxy.cfg
