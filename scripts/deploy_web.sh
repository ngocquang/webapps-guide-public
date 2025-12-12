#!/bin/bash

# Deploy script for webapps-guide-public
# This script downloads necessary files from GitHub repository

set -e

REPO_BASE_URL="https://raw.githubusercontent.com/ngocquang/webapps-guide-public/main"

echo "Starting deployment..."
echo ""

# Prompt user for LOGIN_DOMAIN
read -p "Enter LOGIN_DOMAIN (e.g., login.example.com): " LOGIN_DOMAIN_HERE
if [ -z "$LOGIN_DOMAIN_HERE" ]; then
  echo "Error: LOGIN_DOMAIN cannot be empty"
  exit 1
fi

# Prompt user for BACKEND_DOMAIN
read -p "Enter BACKEND_DOMAIN (e.g., api.example.com): " BACKEND_DOMAIN_HERE
if [ -z "$BACKEND_DOMAIN_HERE" ]; then
  echo "Error: BACKEND_DOMAIN cannot be empty"
  exit 1
fi

# Prompt user for FRONTEND_DOMAIN
read -p "Enter FRONTEND_DOMAIN (e.g., abc.example.com): " FRONTEND_DOMAIN_HERE
if [ -z "$FRONTEND_DOMAIN_HERE" ]; then
  echo "Error: FRONTEND_DOMAIN cannot be empty"
  exit 1
fi

# Extract SERVICE_NAME from FRONTEND_DOMAIN (replace . with -)
SERVICE_NAME=$(echo "$FRONTEND_DOMAIN_HERE" | tr '.' '-')
echo ""
echo "Generated SERVICE_NAME: $SERVICE_NAME"

echo ""
echo "Downloading files..."

# Step 1: Download .env.example and rename to .env.production
echo "Downloading .env.example and renaming to .env.production..."
curl -fsSL "${REPO_BASE_URL}/.env.example" -o .env.production
echo "✓ .env.production created"

# Step 2: Download AGENTS.md
echo "Downloading AGENTS.md..."
curl -fsSL "${REPO_BASE_URL}/AGENTS.md" -o AGENTS.md
echo "✓ AGENTS.md downloaded"

# Step 3: Download Dockerfile.prod
echo "Downloading Dockerfile.prod..."
curl -fsSL "${REPO_BASE_URL}/Dockerfile.prod" -o Dockerfile.prod
echo "✓ Dockerfile.prod downloaded"

# Step 4: Download docker-compose.prod.yml
echo "Downloading docker-compose.prod.yml..."
curl -fsSL "${REPO_BASE_URL}/docker-compose.prod.yml" -o docker-compose.prod.yml
echo "✓ docker-compose.prod.yml downloaded"

echo ""
echo "Replacing placeholders..."

# Replace BACKEND_DOMAIN_HERE in .env.production
sed -i '' "s|BACKEND_DOMAIN_HERE|${BACKEND_DOMAIN_HERE}|g" .env.production
# echo "✓ BACKEND_DOMAIN_HERE replaced in .env.production"
# Replace BACKEND_DOMAIN_HERE in AGENTS.md
sed -i '' "s|BACKEND_DOMAIN_HERE|${BACKEND_DOMAIN_HERE}|g" AGENTS.md
# echo "✓ BACKEND_DOMAIN_HERE replaced in AGENTS.md"
# Replace LOGIN_DOMAIN_HERE in AGENTS.md
sed -i '' "s|LOGIN_DOMAIN_HERE|${LOGIN_DOMAIN_HERE}|g" AGENTS.md
# echo "✓ LOGIN_DOMAIN_HERE replaced in AGENTS.md"

# Replace FRONTEND_DOMAIN_HERE in docker-compose.prod.yml
sed -i '' "s|FRONTEND_DOMAIN_HERE|${FRONTEND_DOMAIN_HERE}|g" docker-compose.prod.yml
echo "✓ FRONTEND_DOMAIN_HERE replaced in docker-compose.prod.yml"
sed -i '' "s|FRONTEND_DOMAIN_HERE|${FRONTEND_DOMAIN_HERE}|g" .env.production
# echo "✓ FRONTEND_DOMAIN_HERE replaced in docker-compose.prod.yml"

# Replace SERVICE_NAME in docker-compose.prod.yml
sed -i '' "s|SERVICE_NAME|${SERVICE_NAME}|g" docker-compose.prod.yml
# echo "✓ SERVICE_NAME replaced in docker-compose.prod.yml"

echo ""
echo "Deployment files downloaded and configured successfully!"
echo ""
echo "Configuration summary:"
echo "  LOGIN_DOMAIN: $LOGIN_DOMAIN_HERE"
echo "  BACKEND_DOMAIN: $BACKEND_DOMAIN_HERE"
echo "  FRONTEND_DOMAIN: $FRONTEND_DOMAIN_HERE"
# echo "  SERVICE_NAME: $SERVICE_NAME"
