#!/bin/bash

#####################################################
# Script de Test des Déploiements
# Usage: ./test-deployments.sh
#####################################################

echo "Test des Déploiements - Pipeline CI/CD"
echo "=========================================="
echo ""

# Couleurs pour l'output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction de test
test_endpoint() {
    local env_name=$1
    local url=$2

    echo -n "Testing ${env_name}... "

    if [ -z "$url" ]; then
        echo -e "${YELLOW}SKIPPED${NC} (URL not configured)"
        return
    fi

    # Test HTTP
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null)

    if [ "$response" = "200" ]; then
        # Vérifier le contenu
        content=$(curl -s "$url" 2>/dev/null)
        if echo "$content" | grep -q "Hello world"; then
            echo -e "${GREEN}✅ SUCCESS${NC} (HTTP 200, Content OK)"
        else
            echo -e "${YELLOW}⚠️  WARNING${NC} (HTTP 200, but content unexpected)"
            echo "   Expected: 'Hello world!'"
            echo "   Got: $content"
        fi
    else
        echo -e "${RED}❌ FAILED${NC} (HTTP $response or unreachable)"
    fi
}

# Instructions pour l'utilisateur
echo " Instructions:"
echo "   1. Allez sur GitLab: Deployments > Environments"
echo "   2. Copiez les URLs de vos environnements"
echo "   3. Modifiez ce script avec vos URLs"
echo ""
echo "🔗 URLs à configurer dans le script:"
echo "   - STAGING_URL="
echo "   - PRODUCTION_URL="
echo ""

# Configuration des URLs (à modifier avec vos vraies URLs)
STAGING_URL="http://ec2-54-234-61-221.compute-1.amazonaws.com"
PRODUCTION_URL=""  # Remplir après déploiement en prod

echo "   Environments configurés:"
echo "   Staging: ${STAGING_URL:-'Not configured'}"
echo "   Production: ${PRODUCTION_URL:-'Not configured'}"
echo ""

# Tests
echo " Lancement des tests..."
echo ""

test_endpoint "Staging" "$STAGING_URL"
test_endpoint "Production" "$PRODUCTION_URL"

echo ""
echo "=========================================="
echo "✅ Tests terminés"
echo ""

# Instructions supplémentaires
echo "   Astuces:"
echo "   - Pour tester manuellement: curl <URL>"
echo "   - Pour voir le contenu: curl <URL> -v"
echo "   - Pour tester en boucle: watch -n 5 curl <URL>"
