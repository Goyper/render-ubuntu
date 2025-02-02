# Usa Ubuntu como base
FROM ubuntu:latest

# Evita preguntas interactivas en la instalación
ARG DEBIAN_FRONTEND=noninteractive

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    sudo \
    bash \
    curl \
    wget \
    net-tools \
    iputils-ping \
    unzip \
    tmate \
    openssh-server \
    nano \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH para que tmate pueda funcionar
RUN mkdir /var/run/sshd \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Agregar variable de entorno para arreglar `clear`
ENV TERM xterm-256color

# Descarga e instala Gotty desde la versión más reciente
RUN wget -O gotty.tar.gz https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    && tar -xvzf gotty.tar.gz \
    && mv gotty /usr/local/bin/ \
    && chmod +x /usr/local/bin/gotty \
    && rm gotty.tar.gz

# Expone el puerto 8080 para Gotty y el 22 para SSH
EXPOSE 8080 22

# Inicia SSH y Gotty sin el conflicto de -w y sin bucles infinitos
CMD service ssh start && gotty -p 8080 --title-format "Terminal Web" /bin/bash
