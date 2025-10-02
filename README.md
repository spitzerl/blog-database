# Base de données du Blog

Ce repository contient la configuration de base de données pour l'application blog avec Prisma et PostgreSQL.

## 🚀 Démarrage rapide

### Développement local
```bash
npm install
npm run db:migrate:dev
npm run db:seed
```

### Avec Docker
```bash
# Développement
npm run docker:dev

# Production
npm run docker:prod
```

## 🛠️ Technologies utilisées

- **PostgreSQL 15** - Base de données relationnelle
- **Prisma** - ORM et générateur de client
- **Docker** - Containerisation
- **Migrations Prisma** - Gestion des versions de schéma

## 📁 Structure du projet

```
prisma/
├── schema.prisma        # Schéma de base de données
├── seed.mjs            # Données de test/développement
└── migrations/         # Historique des migrations
    └── 20241002_init/
        └── migration.sql
```

## 🗃️ Schéma de base de données

### Tables principales

#### Users (Utilisateurs)
- `id` - Identifiant unique
- `email` - Email unique
- `password` - Mot de passe hashé
- `roleId` - Référence au rôle
- Relations: `posts[]`, `comments[]`, `role`

#### Roles (Rôles)
- `id` - Identifiant unique  
- `name` - Nom du rôle (admin, user)
- Relations: `users[]`

#### Posts (Articles)
- `id` - Identifiant unique
- `title` - Titre de l'article
- `content` - Contenu Markdown
- `excerpt` - Extrait (optionnel)
- `coverImage` - Image de bannière (optionnel)
- `createdAt` - Date de création
- `updatedAt` - Date de modification
- `authorId` - Référence à l'auteur
- Relations: `author`, `comments[]`

#### Comments (Commentaires)
- `id` - Identifiant unique
- `content` - Contenu du commentaire
- `createdAt` - Date de création
- `updatedAt` - Date de modification
- `authorId` - Référence à l'auteur
- `postId` - Référence à l'article
- Relations: `author`, `post`

## 🔧 Configuration

### Variables d'environnement

Créez un fichier `.env` :

```env
# Base de données PostgreSQL
DATABASE_URL="postgresql://bloguser:password@localhost:5432/blogdb"

# Pour les seeds
ADMIN_EMAIL="admin@example.com"
ADMIN_PASSWORD="secure-password"
```

## 🚦 Commandes disponibles

### Migrations
```bash
# Créer une nouvelle migration
npm run db:migrate:dev

# Appliquer les migrations (production)
npm run db:migrate

# Remettre à zéro la base de données
npm run db:reset
```

### Client Prisma
```bash
# Générer le client Prisma
npm run db:generate

# Interface graphique Prisma Studio
npm run db:studio
```

### Données de test
```bash
# Peupler la base de données
npm run db:seed
```

### Docker
```bash
# Démarrer PostgreSQL en développement
npm run docker:dev

# Démarrer PostgreSQL en production
npm run docker:prod

# Arrêter les conteneurs
npm run docker:stop

# Nettoyer complètement
npm run docker:clean
```

## 🐳 Docker

La base de données utilise l'image officielle PostgreSQL 15 Alpine.

### Configuration Docker

- **Port** : 5432
- **Volumes** : Données persistées dans `postgres_data`
- **Health checks** : Vérification automatique de la santé
- **Backup** : Scripts de sauvegarde intégrés

## 🔄 Migrations

Les migrations Prisma permettent de :
- Gérer les changements de schéma en toute sécurité
- Garder un historique des modifications
- Synchroniser les environnements
- Rollback si nécessaire

## 🔒 Sécurité

- Utilisateur de base de données dédié (non-root)
- Variables d'environnement pour les credentials
- Isolation des données par conteneur Docker
- Sauvegarde automatisée des données

## 📊 Monitoring

- Health checks automatiques
- Logs détaillés des opérations
- Métriques de performance
- Alertes en cas de problème

## 🔧 Maintenance

### Sauvegardes
```bash
# Sauvegarde manuelle
docker exec blog-db pg_dump -U bloguser blogdb > backup.sql

# Restauration
docker exec -i blog-db psql -U bloguser blogdb < backup.sql
```

### Optimisation
```bash
# Analyser les performances
npm run db:studio

# Optimiser les index (voir schema.prisma)
```