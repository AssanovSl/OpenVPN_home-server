#!/bin/bash
set -e

BASE_DIR="./pki"
CA_DIR="$BASE_DIR/ca"
CERTS_DIR="$BASE_DIR/clients"
mkdir -p "$CERTS_DIR"

echo "=== Создание клиентского сертификата ==="
read -p "Введите CN для клиента (например laptop, iphone): " CN

# Генерация ключа
openssl genrsa -out $CERTS_DIR/$CN.key 4096

# CSR
openssl req -new -key $CERTS_DIR/$CN.key -out $CERTS_DIR/$CN.csr \
    -subj "/C=RU/ST=Moscow/L=Moscow/O=HomeVPN/OU=Client/CN=$CN"

# Подписываем у CA
openssl x509 -req -in $CERTS_DIR/$CN.csr \
    -CA $CA_DIR/ca.crt -CAkey $CA_DIR/ca.key -CAcreateserial \
    -out $CERTS_DIR/$CN.crt -days 825 -sha256

echo "Клиентский сертификат создан:"
echo "  $CERTS_DIR/$CN.key"
echo "  $CERTS_DIR/$CN.crt"
