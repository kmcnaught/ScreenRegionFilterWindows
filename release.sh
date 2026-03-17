#!/usr/bin/env bash
set -euo pipefail

# Parse arguments
BUMP="patch"
YES=false

for arg in "$@"; do
  case "$arg" in
    patch|minor|major) BUMP="$arg" ;;
    --yes|-y) YES=true ;;
    *) echo "Unknown argument: $arg"; echo "Usage: $0 [patch|minor|major] [--yes|-y]"; exit 1 ;;
  esac
done

# Check working copy is clean
if [ -n "$(git status --porcelain)" ]; then
  echo "Error: working copy is not clean. Commit or stash changes first."
  git status --short
  exit 1
fi

# Get latest semver tag
LATEST=$(git tag --sort=-v:refname | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | head -1 || true)
if [ -z "$LATEST" ]; then
  LATEST="v0.0.0"
  echo "No existing semver tags found, starting from $LATEST"
fi

# Strip leading 'v' and split
VERSION="${LATEST#v}"
MAJOR=$(echo "$VERSION" | cut -d. -f1)
MINOR=$(echo "$VERSION" | cut -d. -f2)
PATCH=$(echo "$VERSION" | cut -d. -f3)

# Compute next version
case "$BUMP" in
  major) MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0 ;;
  minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
  patch) PATCH=$((PATCH + 1)) ;;
esac

NEXT="v${MAJOR}.${MINOR}.${PATCH}"

echo "Latest tag : $LATEST"
echo "Bump type  : $BUMP"
echo "Next tag   : $NEXT"

# Confirm
if [ "$YES" = false ]; then
  read -r -p "Create and push tag $NEXT? [y/N] " REPLY
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

# Create annotated tag and push
git tag -a "$NEXT" -m "Release $NEXT"
echo "Tag $NEXT created."

git push origin "$NEXT"
echo "Tag $NEXT pushed. GitHub Actions release workflow should now fire."
