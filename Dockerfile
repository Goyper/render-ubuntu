# Usa Ubuntu como base
FROM ubuntu:latest

# Evita preguntas interactivas en la instalación
ARG DEBIAN_FRONTEND=noninteractive

# Actualiza paquetes y agrega herramientas esenciales
RUN apt-get update && apt-get install -y \
    sudo \
    bash \
    vim \
    curl \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Agrega un usuario root sin restricciones (opcional, ya es root por defecto)
RUN echo "root:root" | chpasswd

# Configura la terminal interactiva
CMD ["/bin/bash"]
