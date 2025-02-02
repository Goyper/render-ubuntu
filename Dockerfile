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
    && rm -rf /var/lib/apt/lists/*

# Descarga e instala Gotty desde la versión más reciente
RUN wget -O gotty.tar.gz https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz \
    && tar -xvzf gotty.tar.gz \
    && mv gotty /usr/local/bin/ \
    && chmod +x /usr/local/bin/gotty \
    && rm gotty.tar.gz

# Expone el puerto 8080 para la terminal web
EXPOSE 8080

# Comando para iniciar Gotty con una terminal root
CMD ["gotty", "-w", "-p", "8080", "/bin/bash"]
