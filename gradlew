#!/usr/bin/env sh
set -eu

PROJECT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
DIST_DIR="$PROJECT_DIR/.gradle-dist/gradle-8.9"
ZIP_FILE="$PROJECT_DIR/.gradle-dist/gradle-8.9-bin.zip"

if [ ! -x "$DIST_DIR/bin/gradle" ]; then
  mkdir -p "$PROJECT_DIR/.gradle-dist"
  if [ ! -f "$ZIP_FILE" ]; then
    curl -fL "https://services.gradle.org/distributions/gradle-8.9-bin.zip" -o "$ZIP_FILE"
  fi
  unzip -q -o "$ZIP_FILE" -d "$PROJECT_DIR/.gradle-dist"
fi

exec "$DIST_DIR/bin/gradle" "$@"
