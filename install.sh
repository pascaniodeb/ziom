#!/usr/bin/env sh
set -eu

REPO="pascaniodeb/ziom"
VERSION="${ZIOM_VERSION:-latest}"
INSTALL_DIR="${ZIOM_INSTALL_DIR:-/usr/local/bin}"
BIN_NAME="ziom"

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

sha256_file() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  elif command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    echo "Missing sha256sum or shasum" >&2
    exit 1
  fi
}

need_cmd curl
need_cmd awk
need_cmd uname

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$OS" in
  darwin|linux) ;;
  *) echo "Unsupported OS: $OS" >&2; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64) ARCH="amd64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

ASSET="ziom_${OS}_${ARCH}"
BASE_URL="https://github.com/${REPO}/releases"
if [ "$VERSION" = "latest" ]; then
  DOWNLOAD_URL="${BASE_URL}/latest/download/${ASSET}"
  CHECKSUM_URL="${BASE_URL}/latest/download/checksums.txt"
else
  DOWNLOAD_URL="${BASE_URL}/download/${VERSION}/${ASSET}"
  CHECKSUM_URL="${BASE_URL}/download/${VERSION}/checksums.txt"
fi

TMP_DIR="$(mktemp -d 2>/dev/null || mktemp -d -t ziom-install)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT INT TERM

echo "Downloading ZIOM CLI (${ASSET})..."
curl -fsSL "$DOWNLOAD_URL" -o "$TMP_DIR/$ASSET"
curl -fsSL "$CHECKSUM_URL" -o "$TMP_DIR/checksums.txt"

EXPECTED="$(awk -v f="$ASSET" '$2 == f || $2 == "*" f { print $1 }' "$TMP_DIR/checksums.txt" | head -n 1)"
if [ -z "$EXPECTED" ]; then
  echo "Checksum for $ASSET not found. Install aborted." >&2
  exit 1
fi

ACTUAL="$(sha256_file "$TMP_DIR/$ASSET")"
if [ "$EXPECTED" != "$ACTUAL" ]; then
  echo "Checksum mismatch. Install aborted." >&2
  exit 1
fi

chmod 0755 "$TMP_DIR/$ASSET"
mkdir -p "$INSTALL_DIR"
cp "$TMP_DIR/$ASSET" "$INSTALL_DIR/$BIN_NAME"

if [ -x "$INSTALL_DIR/$BIN_NAME" ]; then
  if ! VERSION_OUTPUT="$("$INSTALL_DIR/$BIN_NAME" --version 2>&1)"; then
    echo "Installed binary did not pass version check. Install aborted." >&2
    echo "$VERSION_OUTPUT" >&2
    exit 1
  fi
  echo "✓ Version check: $VERSION_OUTPUT"
fi

echo ""
echo "✓ ZIOM v${VERSION} installed successfully"
echo ""
echo "Get started:"
echo "  ziom init"
echo ""
echo "Documentation: https://ziom.dev/docs"
echo "GitHub: https://github.com/pascaniodeb/ziom"
