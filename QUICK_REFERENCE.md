# 🚀 Quick Reference - Accès Rapide

## 📦 Container Registry

### Chemins et URLs

**Container Registry UI:**
```
https://gitlab.com/Adalbert-code/alpinehelloworld00/-/container_registry
```

**Image Path:**
```
registry.gitlab.com/adalbert-code/alpinehelloworld00:main
registry.gitlab.com/adalbert-code/alpinehelloworld00:<branch-name>
```

### Commandes Docker

**Login au Registry:**
```bash
docker login registry.gitlab.com
Username: <votre-username-gitlab>
Password: <votre-personal-access-token>
```

**Pull une image:**
```bash
# Image de la branche main
docker pull registry.gitlab.com/adalbert-code/alpinehelloworld00:main

# Image d'une autre branche
docker pull registry.gitlab.com/adalbert-code/alpinehelloworld00:feature-xyz
```

**Run l'image:**
```bash
docker run -d -p 80:5000 -e PORT=5000 --name webapp \
  registry.gitlab.com/adalbert-code/alpinehelloworld00:main
```

---

## 🌐 Environnements de Déploiement

### Accès aux URLs

**Via GitLab UI:**
```
https://gitlab.com/Adalbert-code/alpinehelloworld00/-/environments
```

### URLs Configurées

**Staging:**
```
http://$HOSTNAME_DEPLOY_STAGING
```

**Production:**
```
http://$HOSTNAME_DEPLOY_PROD
```

**Review (dynamique):**
```
http://<ec2-instance-ip>
# URL disponible dans les logs du job deploy_review
```

---

## 🧪 Tests des Déploiements

### Script de Test Automatique

```bash
./test-deployments.sh
```

### Tests Manuels

**Test Staging:**
```bash
curl http://$HOSTNAME_DEPLOY_STAGING
# Expected: Hello world!
```

**Test Production:**
```bash
curl http://$HOSTNAME_DEPLOY_PROD
# Expected: Hello world!
```

**Test Review:**
```bash
# Récupérer l'IP depuis GitLab Environments
curl http://<review-instance-ip>
# Expected: Hello world!
```

---

## 🔐 Variables CI/CD

**Accès Configuration:**
```
Settings > CI/CD > Variables
```

### Variables Configurées

| Variable | Type | Description |
|----------|------|-------------|
| `SSH_KEY_PS` | File | Clé SSH pour tous les environnements |
| `HOSTNAME_DEPLOY_STAGING` | Variable | IP/Hostname du serveur staging |
| `HOSTNAME_DEPLOY_PROD` | Variable | IP/Hostname du serveur production |
| `AWS_ACCESS_KEY_ID` | Variable | Clé d'accès AWS (masked) |
| `AWS_SECRET_ACCESS_KEY` | Variable | Clé secrète AWS (masked) |
| `AWS_DEFAULT_REGION` | Variable | Région AWS (ex: us-east-1) |
| `SONAR_TOKEN` | Variable | Token SonarCloud (masked) |
| `SONAR_PROJECT_KEY` | Variable | Clé projet SonarCloud |
| `SONAR_ORGANIZATION` | Variable | Organisation SonarCloud |

---

## 📊 Monitoring & Logs

### Pipeline

**Pipelines:**
```
CI/CD > Pipelines
https://gitlab.com/Adalbert-code/alpinehelloworld00/-/pipelines
```

**Jobs Logs:**
```
Cliquer sur un pipeline > Voir les jobs > Cliquer sur un job
```

### Environnements

**Liste des environnements:**
```
Deployments > Environments
https://gitlab.com/Adalbert-code/alpinehelloworld00/-/environments
```

### SonarCloud

**Dashboard:**
```
https://sonarcloud.io/project/overview?id=<votre-project-key>
```

### AWS EC2

**Console AWS:**
```
https://console.aws.amazon.com/ec2
```

**Filtrer instances Review:**
```
Tag: review-<branch-name>
```

---

## 🔄 Workflow Git

### Branches

**Main (production):**
```bash
git checkout main
git pull origin main
```

**Feature branch:**
```bash
git checkout -b feature/ma-feature
git add .
git commit -m "feat: description"
git push origin feature/ma-feature
```

### Merge Request

**Créer MR:**
```
GitLab UI > Merge Requests > New merge request
Source: feature/ma-feature
Target: main
```

---

## 🐳 Commandes Docker Utiles

**Build local:**
```bash
docker build -t alpinehelloworld .
```

**Run local:**
```bash
docker run -d -p 80:5000 -e PORT=5000 --name webapp alpinehelloworld
```

**Test local:**
```bash
curl http://localhost
```

**Logs:**
```bash
docker logs webapp
```

**Stop & Remove:**
```bash
docker stop webapp && docker rm webapp
```

---

## 📝 Structure du Projet

```
bootcamp-projet-perso/
├── .gitlab-ci.yml              # Pipeline CI/CD
├── Dockerfile                  # Image Docker
├── README.md                   # Documentation principale
├── RAPPORT_FINAL.md           # Rapport détaillé
├── DEPLOYMENT_GUIDE.md        # Guide de déploiement
├── PORTFOLIO_SUMMARY.md       # Résumé portfolio
├── QUICK_REFERENCE.md         # Ce fichier
├── test-deployments.sh        # Script de test
└── webapp/
    ├── app.py                # Application Flask
    ├── wsgi.py              # Point d'entrée WSGI
    └── requirements.txt     # Dépendances Python
```

---

## 🆘 Troubleshooting Rapide

**Pipeline échoue au deploy_review:**
- Vérifier que AWS variables sont configurées
- Vérifier que SSH_KEY_PS est de type "File"
- Vérifier que SSH_KEY_PS n'est pas "Protected"

**Erreur SSH lors du déploiement:**
```bash
# Tester la connexion SSH
ssh -i <chemin-cle> ubuntu@<hostname> "echo 'Connected'"
```

**Image Docker ne démarre pas:**
```bash
# Vérifier les logs
docker logs webapp

# Mode debug
docker run -it alpinehelloworld /bin/sh
```

**Tests post-déploiement échouent:**
```bash
# Tester manuellement
curl -v http://<hostname>

# Vérifier que le container tourne
ssh ubuntu@<hostname> "docker ps"
```

---

## 📞 Liens Utiles

- **Repository GitLab:** https://gitlab.com/Adalbert-code/alpinehelloworld00
- **Documentation GitLab CI/CD:** https://docs.gitlab.com/ee/ci/
- **Docker Documentation:** https://docs.docker.com/
- **Flask Documentation:** https://flask.palletsprojects.com/

---

**Dernière mise à jour:** Janvier 2026
