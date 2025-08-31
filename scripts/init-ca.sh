#!/bin/bash
set -e

BASE_DIR="./pki"
CA_DIR="$BASE_DIR/ca"
mkdir -p "$CA_DIR"

echo "=== Создание Центра Сертификации (CA) ==="

# Ключ CA
openssl genrsa -out $CA_DIR/ca.key 4096

# Самоподписанный сертификат CA
openssl req -x509 -new -nodes -key $CA_DIR/ca.key \
    -sha256 -days 3650 -out $CA_DIR/ca.crt \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=HomeVPN/OU=CA/CN=HomeVPN-CA"

echo "Готово! Файлы CA:"
echo "  $CA_DIR/ca.key (секретный ключ, хранить в безопасности)"
echo "  $CA_DIR/ca.crt (публичный сертификат, распространяется)"
