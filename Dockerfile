FROM kalilinux/kali-linux-docker:latest

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN echo 'path-exclude /usr/share/doc/*\n\
path-exclude /usr/share/doc/*/copyright\n\
path-exclude /usr/share/man/*\n\
path-exclude /usr/share/groff/*\n\
path-exclude /usr/share/info/*\n\
path-exclude /usr/share/lintian/*\n\
path-exclude /usr/share/linda/*\n\
path-exclude /usr/share/locale/*\n\
path-include /usr/share/locale/en*' > /etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

RUN apt-get -yqq update && \
    apt-get -y dist-upgrade -yqq && \
    apt-get install -y \
    kali-desktop-xfce xvfb x11vnc kali-linux-full \
    python python-numpy \
    git menu net-tools unzip wget && \
    git clone https://github.com/kanaka/noVNC.git /root/noVNC && \
    git clone https://github.com/kanaka/websockify /root/noVNC/utils/websockify && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ADD startup.sh /startup.sh

CMD chmod 0755 /startup.sh && /startup.sh