# Dockerfile pour PostgreSQL avec Prisma

FROM postgres:15-alpine

# Installer des outils utiles
RUN apk add --no-cache curl

# Créer le répertoire pour les scripts d'initialisation
RUN mkdir -p /docker-entrypoint-initdb.d

# Variables d'environnement par défaut
ENV POSTGRES_DB=blogdb
ENV POSTGRES_USER=bloguser
ENV POSTGRES_PASSWORD=password

# Exposer le port PostgreSQL
EXPOSE 5432

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB || exit 1

# Le script d'entrée par défaut de l'image postgres se charge du reste