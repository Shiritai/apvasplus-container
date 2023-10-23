# base system: arch linux
FROM archlinux:latest

# update package manager & install bird
RUN pacman -Syuu --noconfirm && \
    pacman -S git gcc binutils m4 make flex bison --noconfirm

RUN mkdir "/etc/bird"
WORKDIR "/etc/bird/"

# install apvasplus
RUN git clone https://github.com/fseclab-osaka/apvasplus.git

# install tepla
COPY ./archive/tepla-2.0.tar.gz /etc/bird/tepla-2.0.tar.gz
RUN tar -xzvf tepla-2.0.tar.gz
WORKDIR "/etc/bird/tepla-2.0/tepla"
RUN ./configure && \
    make && \
    make check && \
    make install

# install bird
WORKDIR "/etc/bird/"
COPY ./archive/patched-bird-1.6.0.tar.gz /etc/bird/bird-1.6.0.tar.gz
RUN tar -xzvf bird-1.6.0.tar.gz
WORKDIR "/etc/bird/bird-1.6.0"
RUN ./configure && \
    make && \
    make install && \
    bird

# modify bird: replace files
RUN cp -r /etc/bird/apvasplus/replaced_files \
          /etc/bird/bird-1.6.0/proto/bgp && \
    chmod +x /etc/bird/apvasplus/setup.sh && \
    /etc/bird/apvasplus/setup.sh
