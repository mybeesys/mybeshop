#!/usr/bin/env bash
# Builds Flutter web output for Cloudflare Workers static assets (./build/web).
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

FLUTTER_DIR="${FLUTTER_HOME:-$ROOT_DIR/.flutter}"

install_flutter() {
  echo "==> Flutter not found. Installing stable SDK to: $FLUTTER_DIR"
  if [ -d "$FLUTTER_DIR/.git" ]; then
    echo "==> Flutter directory exists, updating..."
    git -C "$FLUTTER_DIR" fetch --depth 1 origin stable
    git -C "$FLUTTER_DIR" checkout stable
    git -C "$FLUTTER_DIR" pull --ff-only origin stable || true
  else
    rm -rf "$FLUTTER_DIR"
    git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
  fi
  export PATH="$FLUTTER_DIR/bin:$PATH"
  flutter config --enable-web --no-analytics
  echo "==> Precaching Flutter web artifacts..."
  flutter precache --web
}

if command -v flutter >/dev/null 2>&1; then
  echo "==> Using system Flutter: $(command -v flutter)"
elif [ -x "$FLUTTER_DIR/bin/flutter" ]; then
  export PATH="$FLUTTER_DIR/bin:$PATH"
  echo "==> Using cached Flutter at $FLUTTER_DIR"
else
  install_flutter
fi

flutter --version
echo "==> flutter pub get"
flutter pub get

echo "==> flutter build web --release"
flutter build web --release --base-href=/ --no-wasm-dry-run

if [ ! -f build/web/index.html ]; then
  echo "ERROR: build/web/index.html was not created." >&2
  exit 1
fi

echo "==> Web build ready at build/web ($(du -sh build/web | cut -f1))"
