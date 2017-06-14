FROM ubuntu:17.04


ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Required packages
RUN apt-get update
RUN apt-get -y install \
    python \
    build-essential \
    python2.7-dev \
    python-pip \
    git \
    libhdf5-dev \
    software-properties-common \
    sudo

WORKDIR /root

RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; bash install-deps;
RUN cd ~/torch; ./install.sh


WORKDIR /root

RUN ~/torch/install/bin/luarocks install nn
RUN ~/torch/install/bin/luarocks install rnn
RUN ~/torch/install/bin/luarocks install penlight
RUN ~/torch/install/bin/luarocks install https://raw.githubusercontent.com/benglard/htmlua/master/htmlua-scm-1.rockspec
RUN ~/torch/install/bin/luarocks install https://raw.githubusercontent.com/benglard/waffle/master/waffle-scm-1.rockspec

COPY . /code

WORKDIR /code

ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua'
ENV LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
ENV PATH=/root/torch/install/bin:$PATH
ENV LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH
ENV DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH
