# Projet : Création d'une Pipeline CI/CD avec GitLab

## Objectif
L'objectif de ce projet est de créer une pipeline d'intégration continue (CI) et de déploiement continu (CD) pour le déploiement d'une application web [Flask](https://github.dev/eazytraining/alpinehelloworld) sur un serveur accessible via SSH. L'apprenant devra mettre en œuvre les étapes nécessaires pour garantir la qualité et la sécurité du code tout en automatisant le processus de déploiement.

## Étapes de la Pipeline CI/CD

La pipeline doit inclure les étapes suivantes :

1. **Linter**
   - Validation syntaxique du code avec flake8 (ignorer les vunerabilités E501 et E303) et hadolint .

2. **Compilation**
   - Compilation du code source avec comme artefact une image docker de l'app.

3. **Scan de Sécurité (Image Docker)**
   - Analyse de l'image Docker pour détecter les vulnérabilités de sécurité avec [Trivy](https://blog.wescale.fr/trivy-un-scanner-de-s%C3%A9curit%C3%A9-couteau-suisse).

4. **Tests Automatisés**
   - Exécution de tests unitaires et d'intégration.

5. **Vérification de la Qualité de Code**
   - Analyse statique du code pour respecter les normes de qualité avec [Sonarcloud](https://docs.sonarsource.com/sonarqube-cloud/).

6. **Packaging**
   - Création d'un package de l'application à sauveguarder dans le registre de conteneur de Gitlab.

7. **Déploiement dynamique en Review**
   - Déploiement dynamique de l'application dans un environnement de revu.

8. **Staging**
   - Déploiement dans un environnement de pré-production.

9. **Production**
   - Déploiement final dans l'environnement de production.

10. **Tests de Validation des Déploiements**
    - Vérification que le déploiement a réussi et que l'application fonctionne comme prévu.

## Modèle Gitflow

- Sur la **branche principale** (`main`), toutes les étapes doivent être exécutées, sauf le déploiement en review.
- Sur les **autres branches**, seules les étapes suivantes doivent être exécutées :
  - Linter
  - Compilation
  - Scan de Sécurité (Image Docker)
  - Tests Automatisés
  - Vérification de la Qualité de Code
- Lors d'une **Pull Request (PR)**, en plus des étapes précédentes, les étapes de packaging et de déploiement en review doivent être exécutées.

## Exigences Techniques

- Utiliser un fichier `.gitlab-ci.yml` pour définir la pipeline.
- S'assurer que le script est optimal et respecte les meilleures pratiques de CI/CD.

## Résultats Attendus

À la fin de ce projet, l'apprenant doit être capable de :

- Configurer une pipeline CI/CD complète avec GitLab.
- Déployer une application web de manière sécurisée et automatisée.
- Garantir la qualité et la sécurité du code à chaque étape du processus de développement.

## Ressources

- [Formation GitLab ](https://eazytraining.fr/cours/gitlab-ci-cd-pour-devops/)
- [Documentation GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [Meilleures pratiques CI/CD](https://docs.gitlab.com/ee/topics/gitlab_ci_cd_best_practices.html)