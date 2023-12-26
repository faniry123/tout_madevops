# Utilisez une image légère basée sur Nginx pour servir les fichiers HTML
FROM nginx:alpine

# Copiez le fichier index.html dans le répertoire de base de Nginx
COPY index.html /usr/share/nginx/html

# Exposez le port 80 pour que l'application soit accessible
EXPOSE 80

# Commande par défaut pour démarrer Nginx et servir l'application
CMD ["nginx", "-g", "daemon off;"]

