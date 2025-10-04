#!/bin/bash
set -e

# Paths
SITE_DIR="_site"
SCSS_FILE="assets/main.scss"

echo "🧹 Cleaning old _site folder..."
rm -rf "$SITE_DIR"

echo "🛠 Fixing Sass deprecations..."
# Replace deprecated @import and color functions
if [ -f "$SCSS_FILE" ]; then
    sed -i.bak -E 's/@import "minima";/@use "minima" as */' "$SCSS_FILE"
    sed -i.bak -E 's/lighten\(([^,]+), *([0-9]+)%\)/color.adjust(\1, \$lightness: \2%)/g' "$SCSS_FILE"
    sed -i.bak -E 's/darken\(([^,]+), *([0-9]+)%\)/color.adjust(\1, \$lightness: -\2%)/g' "$SCSS_FILE"
fi

echo "📦 Building Jekyll site..."
bundle install
bundle exec jekyll build

echo "📂 Deploying to gh-pages branch..."
JEKYLL_BUILD_DIR="$SITE_DIR"

# Switch to gh-pages branch safely
git fetch origin
git checkout gh-pages || git checkout --orphan gh-pages

# Remove old files in gh-pages
git rm -rf . || true

# Copy new site files
cp -r "$JEKYLL_BUILD_DIR"/* .

# Commit and push
git add .
git commit -m "Deploy latest site" || echo "No changes to commit"
git push origin gh-pages --force

# Switch back to main branch
git checkout main

echo "✅ Deployment complete!"
