FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
COPY /ubuntu-run.sh /usr/bin/

RUN mv /usr/bin/ubuntu-run.sh /usr/bin/run.sh && \
    chmod +x /usr/bin/run.sh && \
    apt-get update && \
    apt-get --assume-yes install curl gpg wget && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && \
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://packages.microsoft.com/repos/vscode stable main" | \
   tee /etc/apt/sources.list.d/vs-code.list
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && apt install --assume-yes --fix-missing code \
    default-jdk g++ zlib1g-dev unzip openssh-client git \
    google-chrome-stable \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin \
    sudo \
    wget \
    xorgxrdp \
    xrdp && \
    apt remove -y light-locker xscreensaver && \
    apt autoremove -y && apt clean && \
    wget https://github.com/bazelbuild/bazel/releases/download/7.1.1/bazel_7.1.1-linux-x86_64.deb && \
    dpkg -i bazel_7.1.1-linux-x86_64.deb && rm -f bazel_7.1.1-linux-x86_64.deb && \
    wget https://github.com/bazelbuild/buildtools/releases/download/v7.1.0/buildifier-linux-amd64 && \
    wget https://github.com/bazelbuild/buildtools/releases/download/v7.1.0/buildozer-linux-amd64 && \
    mv buildifier-linux-amd64 /usr/sbin/buildifier && chmod +x /usr/sbin/buildifier && \
    mv buildozer-linux-amd64 /usr/sbin/buildozer && chmod +x /usr/sbin/buildozer && \
    mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession

