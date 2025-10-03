#!/bin/bash
set -e  # Stop on any error
echo "🧹 Cleaning previous build..."
rm -rf _site

echo "🛠 Building Jekyll site..."
bundle exec jekyll build

JEKYLL_BUILD_DIR="_site"
GH_PAGES_DIR="/tmp/gh-pages"

echo "📂 Preparing gh-pages branch..."

# Create gh-pages worktree if it doesn't exist
if [ ! -d "$GH_PAGES_DIR" ]; then
    git worktree add "$GH_PAGES_DIR" gh-pages || git worktree add "$GH_PAGES_DIR" -b gh-pages
fi

# Clear old content in gh-pages
rm -rf "$GH_PAGES_DIR"/*

# Copy new site files
cp -r "$JEKYLL_BUILD_DIR"/* "$GH_PAGES_DIR/"

echo "✅ Committing and pushing to gh-pages..."
cd "$GH_PAGES_DIR"
git add .
git commit -m "Deploy latest site"
git push origin gh-pages --force
cd -

echo "🎉 Deployment complete! Your main code is safe."
