# Instructions pour Corriger SSH_KEY_PS

## Problème Identifié

La variable `SSH_KEY_PS` est marquée comme **"Protected"**, ce qui signifie qu'elle n'est accessible QUE sur les branches protégées (généralement `main`).

Votre branche `feature/documentation-complete` n'est pas protégée, donc la variable est invisible pour la pipeline.

## Solution

### Étape 1: Éditer la Variable SSH_KEY_PS

1. Allez sur: https://gitlab.com/Adalbert-code/alpinehelloworld00/-/settings/ci_cd
2. Cliquez sur **Variables** > **Expand**
3. Trouvez `SSH_KEY_PS`
4. Cliquez sur l'icône **Éditer** (crayon) à droite

### Étape 2: Modifier les Flags

Dans la configuration de la variable:

```
┌──────────────────────────────────────────────┐
│  Key: SSH_KEY_PS                             │
│                                              │
│   Type: File ✅ (NE PAS CHANGER)             
│                                              │
│  Value: [Garder le contenu actuel]           │
│                                              │
│  Flags:                                      │
│  ☐ Protected     ⬅️ DÉCOCHER CETTE CASE     │
│  ☐ Masked        ⬅️ Doit rester décoché     │
│  ☑ Expand variable reference                 
│                                              │
│  Environments: All (default)                 │
│                                              │
│  [Update variable]                           │
└──────────────────────────────────────────────┘
```

### Étape 3: Sauvegarder

1. Cliquez sur **Update variable**
2. Allez dans **CI/CD > Pipelines**
3. Cliquez sur **⟳ Retry** sur la dernière pipeline

## Pourquoi Retirer "Protected"?

- **Protected** = Variable uniquement accessible sur branches protégées (main, etc.)
- Votre MR est sur `feature/documentation-complete` qui n'est PAS protégée
- Donc la variable est invisible et `$SSH_KEY_PS` est vide

## Alternative: Protéger la Branche

Si vous voulez GARDER Protected (plus sécurisé), vous devez:

1. Merger votre MR vers `main` d'abord
2. Ou temporairement protéger la branche `feature/*` dans Settings > Repository > Protected branches

Mais la solution la plus simple est de retirer "Protected" pour les tests.

## Vérification

Après modification, la pipeline devrait montrer:

```bash
$ if [ -f "$SSH_KEY_PS" ]; then
    cp "$SSH_KEY_PS" ~/.ssh/id_rsa  ✅ Succès
```

Au lieu de:

```bash
ERROR: SSH_KEY_PS file not found ❌
```
