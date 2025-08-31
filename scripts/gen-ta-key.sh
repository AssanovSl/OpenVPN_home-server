#!/bin/bash
set -e

BASE_DIR="./pki"
TA_DIR="$BASE_DIR/tls-auth"
mkdir -p "$TA_DIR"

echo "=== Генерация TLS-auth ключа ==="

# Генерация статического ключа
openvpn --genkey --secret $TA_DIR/ta.key

# Устанавливаем безопасные права доступа
chmod 600 $TA_DIR/ta.key

echo "TLS-auth ключ создан:"
echo "  $TA_DIR/ta.key"