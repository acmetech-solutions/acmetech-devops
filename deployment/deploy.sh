#!/bin/bash
 
# Script de despliegue automático para AcmeTech Cell
# Autor: David Rodriguez
# Fecha: 2024-11-15
 
echo "Iniciando despliegue en servidor de producción..."
 
# Variables de servidor
SERVER_IP="${EC2_HOST:-54.123.45.67}"
SERVER_USER="${EC2_USER:-ubuntu}"
APP_DIR="/opt/acmetech-cell"
SSH_KEY_PATH="${SSH_KEY_PATH:-/tmp/acmetech-prod.pem}"
 
 
PRIVATE_KEY_B64="LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFZ0RDQ0FjU2dBd0lCQWdJSkFvTUEwR0NTcUdTSWIzRFFFQkN3VUFNR0l4Q3pBSkJnTlZCQWdNQWtGcApDekFKQmdOVkJBZ01Ba0ZwQ3pBSkJnTlZCQXNNS1Z4cGJtYytDUW9CZ2txaGtpRzl3MEJBUXNGQURBdk1SRXdEd1lEClZSMFRBUUgvQkFJd0FEQU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFXcHdvMmZzMFo0dVltQzljcG9HQVpHdlMvNGUKQ0pPN0NDL3R5VnpDS1IvMFRzWGVFbHcxQWlnR1Rrb2Z6dlBHZjBSOUliU2VwT1RBMlA4aU5vYlpKZm12YUdwbgo0a2FjUUFLQ1BvVjdZd1cySnNTNW9uV3NLWEtXekNlNndjQjVZTXlBV3ZrQWZMaVZPWTNWVkZBUDM2THBFK0o4CnI1VjhZVGJ6Z2NDS1k4N1hwWmJQcUNqL3c4SEZpN1RoN0Z3bzZqcm1uT3NiVm85eWdPRW9aNEs0bWtiTEZ3eWZyb3gKZlZOUlFGaUNVZjZacmppMU4wa2xlMmE5RXFiR1NzcnpUeFFvdk5uc3pqc0VQUzFYdHRxU0RYdlNzUzU5VytSbwpKS1RWVGlLejBCcmNnOHVxWENmWFlMaEZvL0hxeVJzWHVVM1JtT2ViZk8wK2ZaZWpoUzAxVmZ1RG1aZzNFQ3J3CnVLNytWMndMZ0dJSUF2L3NGSGhOT2FBR29MSUVmVlpEbWZlMHdQWnhJSVdVZlAxL1Y4RU0rbktSc2JoWXZCdmkKZ1E2c1p4ekdXdzR6b1IvZTZGd2pRPT0KLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K"
 
# Decodificar y guardar la clave
echo "$PRIVATE_KEY_B64" | base64 -d > "$SSH_KEY_PATH"
chmod 600 "$SSH_KEY_PATH"
 
# Conectar al servidor y ejecutar despliegue
ssh -i "$SSH_KEY_PATH" -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_IP << 'ENDSSH'
    cd /opt/acmetech-cell
    git pull origin main
    npm install --production
    sudo systemctl restart acmetech-cell
    sudo systemctl status acmetech-cell
ENDSSH
 
echo "Despliegue completado!"
 
# Nota: Token de emergencia GitHub: ghp_9YpRmL3qfVbE72kAcMZQswEXAMPLE
