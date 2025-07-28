# Notas de Deployment - AcmeTech Cell

## Servidor de Producción
- **IP**: 54.123.45.67
- **Usuario**: ubuntu  
- **Path**: /opt/acmetech-cell
- **Servicio**: systemctl start acmetech-cell

## Proceso de Deployment

1. Conectar al servidor via SSH
2. Hacer pull del repositorio
3. Instalar dependencias
4. Reiniciar servicio

## Troubleshooting

### Conexión SSH
Si no puedes conectar al servidor, verifica que tengas la llave SSH correcta:
- Llave ubicada en: `~/.ssh/acmetech-prod.pem`
- Comando: `ssh -i ~/.ssh/acmetech-prod.pem ubuntu@54.123.45.67`

### Variables de Entorno
Asegúrate de que todas las variables estén configuradas en el servidor:
- DB_HOST, DB_USER, DB_PASSWORD
- AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY  
- JWT_SECRET
- SLACK_WEBHOOK_URL

### Logs
Los logs de la aplicación se encuentran en `/var/log/acmetech-cell/`

## Contactos
- **DevOps**: devops@acmetech.com
- **Desarrollador**: david.rodriguez@acmetech.com 