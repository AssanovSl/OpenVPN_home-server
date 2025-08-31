#!/bin/bash
set -e

BASE_DIR="./pki"
CA_DIR="$BASE_DIR/ca"
CERTS_DIR="$BASE_DIR/server"
mkdir -p "$CERTS_DIR"

echo "=== Создание серверного сертификата ==="
read -p "Введите CN для сервера (например vpn-server): " CN

# Генерация ключа
openssl genrsa -out $CERTS_DIR/$CN.key 4096

# CSR (запрос на сертификат)
openssl req -new -key $CERTS_DIR/$CN.key -out $CERTS_DIR/$CN.csr \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=HomeVPN/OU=Server/CN=$CN"

# Подписываем у CA
openssl x509 -req -in $CERTS_DIR/$CN.csr \
    -CA $CA_DIR/ca.crt -CAkey $CA_DIR/ca.key -CAcreateserial \
    -out $CERTS_DIR/$CN.crt -days 825 -sha256

echo "Серверный сертификат создан:"
echo "  $CERTS_DIR/$CN.key (ключ)"
echo "  $CERTS_DIR/$CN.crt (сертификат)"
