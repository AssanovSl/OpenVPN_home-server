#!/bin/bash
set -e

BASE_DIR="./pki"
DH_DIR="$BASE_DIR/dh"
mkdir -p "$DH_DIR"

echo "=== Генерация DH параметров ==="

echo "Генерация DH параметров (это может занять время)..."
openssl dhparam -out $DH_DIR/dh.pem 2048

echo "DH параметры созданы:"
echo "  $DH_DIR/dh.pem"
