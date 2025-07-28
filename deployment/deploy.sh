#!/bin/bash

# Script de despliegue automático para AcmeTech Cell
# Autor: David Rodriguez
# Fecha: 2024-11-15

echo "Iniciando despliegue en servidor de producción..."

# Variables de servidor
SERVER_IP="${EC2_HOST:-54.123.45.67}"
SERVER_USER="${EC2_USER:-ubuntu}"
APP_DIR="/opt/acmetech-cell"
SSH_KEY_PATH="${SSH_KEY_PATH:-~/.ssh/acmetech-prod.pem}"

# Verificar que existe la llave SSH
if [ ! -f "$SSH_KEY_PATH" ]; then
    echo "Error: No se encuentra la llave SSH en $SSH_KEY_PATH"
    echo "Usar: scp -i ~/.ssh/my-key.pem /path/to/acmetech-prod.pem ubuntu@$SERVER_IP:~/"
    exit 1
fi

# Conectar al servidor y ejecutar despliegue
ssh -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP << 'ENDSSH'
    cd /opt/acmetech-cell
    git pull origin main
    npm install --production
    sudo systemctl restart acmetech-cell
    sudo systemctl status acmetech-cell
ENDSSH

echo "Despliegue completado!"

# Nota: Para acceso de emergencia usar: ssh -i ~/.ssh/acmetech-prod.pem ubuntu@ec2-54-123-45-67.us-east-1.compute.amazonaws.com
# Token backup en caso de fallo: ghp_2K8x9QvN4rM7sP1wB5cY3eR6tL0nA8zA 