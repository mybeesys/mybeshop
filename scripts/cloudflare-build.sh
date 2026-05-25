#!/usr/bin/env bash
# Builds Flutter web output for Cloudflare Workers static assets (./build/web).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter not found; installing stable SDK..."
  FLUTTER_HOME="${FLUTTER_HOME:-$HOME/flutter}"
  if [ ! -d "$FLUTTER_HOME/.git" ]; then
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_HOME"
  fi
  export PATH="$FLUTTER_HOME/bin:$PATH"
  flutter precache --web
  flutter config --enable-web
fi

flutter pub get
flutter build web --release

if [ ! -f build/web/index.html ]; then
  echo "Build failed: build/web/index.html was not created." >&2
  exit 1
fi

echo "Web build ready at build/web"
