#!/bin/bash

# Script d'initialisation PostgreSQL pour le blog
# Ce script s'exécute automatiquement lors de la première création du conteneur

set -e

echo "Initialisation de la base de données du blog..."

# Créer des extensions utiles
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Extension pour les UUID
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    
    -- Extension pour la recherche en texte intégral
    CREATE EXTENSION IF NOT EXISTS "pg_trgm";
    
    -- Extension pour les statistiques
    CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
    
    -- Afficher les extensions installées
    \dx
EOSQL

echo "Initialisation terminée avec succès."