# Pipeline CI/CD GitLab - Déploiement Automatisé Flask

![GitLab CI/CD](https://img.shields.io/badge/GitLab-CI%2FCD-orange?logo=gitlab)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue?logo=docker)
![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)
![Flask](https://img.shields.io/badge/Flask-Web%20App-green?logo=flask)
![AWS](https://img.shields.io/badge/AWS-EC2-orange?logo=amazon-aws)

## 📋 Description

Ce projet implémente une **pipeline CI/CD complète** avec GitLab pour automatiser le déploiement d'une application web Flask. La pipeline garantit la qualité et la sécurité du code à chaque étape, du développement à la production.

### Objectifs du projet

- ✅ Automatiser l'intégration continue (CI) et le déploiement continu (CD)
- ✅ Garantir la qualité du code avec analyse statique et tests automatisés
- ✅ Assurer la sécurité avec scan de vulnérabilités
- ✅ Déployer sur des environnements multiples (Review, Staging, Production)
- ✅ Implémenter les meilleures pratiques DevOps

---

## 🏗️ Architecture

### Stack Technique

-----------------------------------------------------------------------------
|     Composant        | Technologie         |            Usage             |
|----------------------|---------------------|------------------------------|
| **Application**      | Flask (Python 3.12) | Framework web minimaliste--  |
| **Conteneurisation** | Docker              | Packaging de l'application-  |
| **CI/CD**            | GitLab CI/CD        | Orchestration de la pipeline |
| **Qualité Code**     | SonarCloud, Flake8  | Analyse statique             |
| **Sécurité**         | Trivy, Hadolint     | Scan de vulnérabilités       |
| **Serveur Web**      | Gunicorn            | WSGI HTTP Server             |
| **Infrastructure**   | AWS EC2             | Hébergement (Review)         |
| **Déploiement**      | SSH                 | Staging & Production         |
-----------------------------------------------------------------------------

### Architecture de la Pipeline

```
┌─────────────────────────────────────────────────────────────────┐
│                         PIPELINE CI/CD                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. LINT           → Validation syntaxique (Flake8, Hadolint)   │
│  2. BUILD          → Compilation de l'image Docker              │
│  3. TEST           → Tests d'acceptation automatisés            │
│  4. SCAN           → Analyse de sécurité (Trivy)                │
│  5. SONARCLOUD     → Analyse qualité du code                    │
│  6. RELEASE        → Push vers GitLab Container Registry        │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │              DÉPLOIEMENTS (main uniquement)             │    │
│  ├─────────────────────────────────────────────────────────┤    │
│  │  7. REVIEW    → AWS EC2 (dynamique, MR uniquement)      │    │
│  │  8. STAGING   → Pré-production (automatique)            │    │
│  │  9. PRODUCTION → Production (manuel)                    │    │
│  │  10. TESTS    → Validation post-déploiement             │    │
│  └─────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────┘
```

---

## Fonctionnalités de la Pipeline

### 1. **Linting** 
- **Flake8**: Validation syntaxique Python (ignore E501, E303)
- **Hadolint**: Analyse du Dockerfile (ignore DL3018)

### 2. **Build** 
- Construction de l'image Docker
- Sauvegarde de l'image comme artefact (expire après 1h)

### 3. **Tests Automatisés** ✅
- Démarrage du container
- Test d'acceptation HTTP
- Vérification de la réponse "Hello world!"

### 4. **Scan de Sécurité** 
- **Trivy**: Détection de vulnérabilités (HIGH, CRITICAL)
- Analyse de l'image Docker avant déploiement

### 5. **Qualité de Code** 
- **SonarCloud**: Analyse statique du code Python
- Métriques: bugs, code smells, couverture, duplications

### 6. **Release** 
- Tag de l'image avec `$CI_COMMIT_REF_SLUG`
- Push vers GitLab Container Registry
- Authentification sécurisée

### 7. **Déploiement Review** 
- Création automatique d'instances AWS EC2
- Environnement éphémère par Merge Request
- URL dynamique pour revue
- Arrêt manuel via `stop_review`

### 8. **Déploiement Staging** 
- Déploiement automatique sur serveur staging
- Connexion SSH sécurisée
- Tests de validation automatiques

### 9. **Déploiement Production** 
- Déploiement manuel (protection)
- Environnement de production
- Tests de validation post-déploiement

---

## 📁 Structure du Projet

```
bootcamp-projet-perso/
├── .gitlab-ci.yml              # Configuration de la pipeline CI/CD
├── Dockerfile                  # Image Docker Alpine + Flask
├── .dockerignore              # Exclusions Docker
├── README.md                  # Documentation (ce fichier)
├── mini-projet-gitlab.md      # Énoncé du projet
├── RAPPORT_FINAL.md           # Rapport détaillé du projet
├── DEPLOYMENT_GUIDE.md        # Guide de déploiement
├── PORTFOLIO_SUMMARY.md       # Résumé pour portfolio
├── tokenFile.csv             # Fichier de configuration
└── webapp/
    ├── app.py                # Application Flask
    ├── wsgi.py              # Point d'entrée WSGI
    ├── tests.py             # Tests unitaires
    ├── requirements.txt     # Dépendances Python
    └── .gitignore          # Exclusions Git
```

---

## Configuration Requise

### Variables CI/CD GitLab

Configurez ces variables dans **Settings > CI/CD > Variables**:

---------------------------------------------------------------------------------
|           Variable        |            Description                 | Sensible |
|---------------------------|----------------------------------------|----------|
| `SONAR_TOKEN`             | Token d'authentification SonarCloud    |   ✅    |
| `SONAR_PROJECT_KEY`       | Clé du projet SonarCloud               |   ❌    |
| `SONAR_ORGANIZATION`      | Organisation SonarCloud                |   ❌    |
| `SONAR_HOST_URL`          | URL SonarCloud (https://sonarcloud.io) |   ❌    |
| `SSH_KEY`                 | Clé SSH privée pour Review (AWS)       |   ✅    |
| `SSH_KEY_PS`              | Clé SSH privée pour Staging/Prod       |   ✅    |
| `SSH_USER`                | Utilisateur SSH (ex: ubuntu)           |   ❌    |
| `HOSTNAME_DEPLOY_STAGING` | IP/Hostname du serveur staging         |   ❌    |
| `HOSTNAME_DEPLOY_PROD`    | IP/Hostname du serveur production      |   ❌    |
| `AWS_ACCESS_KEY_ID`       | Clé d'accès AWS                        |   ✅    |
| `AWS_SECRET_ACCESS_KEY`   | Clé secrète AWS                        |   ✅    |
| `AWS_DEFAULT_REGION`      | Région AWS (ex: us-east-1)             |   ❌    |
---------------------------------------------------------------------------------

### Infrastructure AWS pour Review

- **AMI**: Ubuntu Server (ami-0866a3c8686eaeeba)
- **Instance Type**: t2.micro
- **Security Group**: Ports 22, 80 ouverts
- **Key Pair**: `deploy-review`
- **Storage**: 100 GB

---

## Modèle Gitflow

### Branche `main`
Exécute toutes les étapes de la pipeline:
- Lint → Build → Test → Scan → SonarCloud → Release → Staging → Prod

### Autres branches
Exécute uniquement:
- Lint → Build → Test → Scan → SonarCloud

### Merge Request (Pull Request)
Ajoute en plus:
- **Release** (packaging)
- **Review** (déploiement éphémère sur AWS EC2)

---

## Utilisation

### 1. Cloner le projet

```bash
git clone <votre-repo-gitlab>
cd bootcamp-projet-perso
```

### 2. Configurer les variables

Ajoutez les variables CI/CD dans GitLab (voir section Configuration).

### 3. Pousser sur une branche

```bash
git checkout -b feature/ma-fonctionnalite
git add .
git commit -m "feat: nouvelle fonctionnalité"
git push origin feature/ma-fonctionnalite
```

La pipeline exécutera automatiquement les étapes de validation.

### 4. Créer une Merge Request

Une fois les tests passés, créez une MR vers `main`:
- La pipeline déploiera automatiquement un environnement de review sur AWS
- URL accessible pour tester les changements

### 5. Merger vers `main`

Après validation, merger la MR déclenche:
- Déploiement automatique en **staging**
- Déploiement **manuel** en production (via bouton GitLab)

---

## Tests Locaux

### Tester l'application localement

```bash
# Installer les dépendances
pip install -r webapp/requirements.txt

# Lancer l'application
python webapp/app.py

# L'app sera disponible sur http://localhost:5000
```

### Tester avec Docker

```bash
# Build de l'image
docker build -t alpinehelloworld .

# Lancer le container
docker run -d -p 80:5000 -e PORT=5000 --name webapp alpinehelloworld

# Tester
curl http://localhost
# Expected: Hello world!

# Arrêter et supprimer
docker stop webapp && docker rm webapp
```

### Lancer les tests unitaires

```bash
cd webapp
python -m pytest tests.py -v
```

---

## Monitoring et Logs

### GitLab CI/CD
- **Pipelines**: `CI/CD > Pipelines`
- **Environments**: `Deployments > Environments`
- **Container Registry**: `Packages & Registries > Container Registry`

### SonarCloud
- Dashboard: https://sonarcloud.io
- Métriques: Bugs, Vulnerabilities, Code Smells, Coverage

### AWS EC2 (Review)
- Console AWS EC2
- Tag: `review-<branch-name>`

---

## Sécurité

### Mesures implémentées

1. **Scan de vulnérabilités** (Trivy)
   - Analyse des images Docker
   - Détection HIGH/CRITICAL

2. **Analyse statique** (SonarCloud)
   - Détection de bugs
   - Identification de failles de sécurité

3. **Principe du moindre privilège**
   - Container exécuté en tant que `myuser` (non-root)
   - Clés SSH chiffrées dans GitLab

4. **Validation multi-étapes**
   - Tests automatiques avant déploiement
   - Validation manuelle pour production

---

## 🐛 Troubleshooting

### La pipeline échoue au linting

```bash
# Vérifier localement avec flake8
pip install flake8
flake8 --ignore=E501,E303 .

# Vérifier le Dockerfile
docker run --rm -i hadolint/hadolint < Dockerfile
```

### Erreur de connexion SSH

```bash
# Vérifier que la clé SSH est bien configurée
ssh -i ~/.ssh/id_rsa user@host "echo 'Connected'"

# Vérifier les permissions
chmod 400 ~/.ssh/id_rsa
```

### Image Docker ne démarre pas

```bash
# Vérifier les logs
docker logs webapp

# Tester en mode interactif
docker run -it alpinehelloworld /bin/bash
```

---

##  Documentation Complémentaire

- [RAPPORT_FINAL.md](./RAPPORT_FINAL.md) - Rapport détaillé du projet
- [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) - Guide de déploiement complet
- [PORTFOLIO_SUMMARY.md](./PORTFOLIO_SUMMARY.md) - Résumé pour portfolio
- [mini-projet-gitlab.md](./mini-projet-gitlab.md) - Énoncé original

---

##  Compétences Démontrées

- ✅ Configuration et optimisation de pipelines CI/CD
- ✅ Containerisation avec Docker
- ✅ Déploiement multi-environnements
- ✅ Automatisation avec GitLab CI/CD
- ✅ Infrastructure as Code (AWS EC2)
- ✅ Sécurité et qualité du code
- ✅ Tests automatisés
- ✅ Gestion de configuration

---

## Licence

Ce projet est réalisé dans le cadre d'une formation DevOps chez **EAZYTRAINING**.

---

## 👤 Auteur

**Adalbert NANDA TONLIO**
- Formation: DevOps Bootcamp - EAZYTRAINING
- Projet: Mini-projet GitLab CI/CD
- Date: Janvier 2026

---
## Captures d'Écran

### Pipeline GitLab CI/CD
![Pipelines](screenshots/Pipeline_Jobs.png)

![Pipelines](screenshots/Pipeline_Jobs_states.png)

### SonarCloud Dashboard
![SonarCloud](screenshots/Sona_test.png)

### Environnements GitLab
![Test Review ](screenshots/Merge-Request.png)

### Application Déployée
![ec2 Instances ](screenshots/ec2_stagin_prod.png)
![Applications ](screenshots/Application.png)

### Review env
![Test Review ](screenshots/Merge-Request.png)
---

## 🔗 Liens Utiles

- [Documentation GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [Best Practices GitLab CI/CD](https://docs.gitlab.com/ee/topics/gitlab_ci_cd_best_practices.html)
- [Docker Documentation](https://docs.docker.com/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [SonarCloud](https://sonarcloud.io/)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)

---