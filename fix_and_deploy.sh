#!/bin/bash
# Safe Jekyll build and deploy to GitHub Pages

SITE_DIR="PicaoCaldenseSite"
BUILD_DIR="$SITE_DIR/_site"
BRANCH="gh-pages"

echo "🧹 Step 0: Remove old _site folder"
rm -rf "$BUILD_DIR"

echo "🛠 Step 1: Build Jekyll site"
cd "$SITE_DIR" || { echo "❌ Could not enter $SITE_DIR"; exit 1; }
jekyll build --destination ./_site

if [ ! -d "_site" ]; then
    echo "❌ ERROR: Build failed, _site folder not found"
    exit 1
fi
cd ..

echo "📂 Step 2: Deploy to $BRANCH branch safely"

# Temporary folder for deployment
TEMP_DIR=$(mktemp -d)
git clone -b "$BRANCH" . "$TEMP_DIR"

# Copy only generated site files into temp folder
cp -r "$BUILD_DIR"/* "$TEMP_DIR"

cd "$TEMP_DIR" || { echo "❌ Could not enter temp directory"; exit 1; }
git add .
git commit -m "Deploy latest site" || echo "⚠ Nothing to commit"
git push origin "$BRANCH"

cd ..
rm -rf "$TEMP_DIR"

echo "✅ Deployment complete! Your source files are safe."
