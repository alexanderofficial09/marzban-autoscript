#!/bin/bash

echo "🔧 Marzban Otomatik Kurulum Başlıyor..."
sleep 1

echo "📦 Gerekli paketler kuruluyor (curl, socat)..."
apt update && apt install curl socat -y

echo "✉️ Lütfen bir e-posta adresi girin (sertifika için, doğrulama gelmeyecek):"
read -p "Email: " EMAIL

echo "🌐 Lütfen bir domain veya subdomain girin (örn: youword.duckdns.org):"
read -p "Domain: " DOMAIN

echo "📄 Sertifika üreticisi yükleniyor..."
curl https://get.acme.sh | sh -s email=$EMAIL

export DOMAIN=$DOMAIN

mkdir -p /var/lib/marzban/certs

echo "🔐 SSL sertifikası üretiliyor..."
~/.acme.sh/acme.sh \
  --issue --force --standalone -d "$DOMAIN" \
  --fullchain-file "/var/lib/marzban/certs/$DOMAIN.cer" \
  --key-file "/var/lib/marzban/certs/$DOMAIN.cer.key"

echo "🧱 Marzban kurulumu başlatılıyor..."
sudo bash -c "$(curl -sL https://github.com/Gozargah/Marzban-scripts/raw/master/marzban.sh)" @ install

echo "📝 Sertifika yolları .env dosyasına ekleniyor..."
ENV_PATH="/opt/marzban/.env"

if [ -f "$ENV_PATH" ]; then
    sed -i '/^#\?UVICORN_SSL_CERTFILE/c\UVICORN_SSL_CERTFILE="/var/lib/marzban/certs/'"$DOMAIN"'.cer"' $ENV_PATH
    sed -i '/^#\?UVICORN_SSL_KEYFILE/c\UVICORN_SSL_KEYFILE="/var/lib/marzban/certs/'"$DOMAIN"'.cer.key"' $ENV_PATH
    sed -i '/^#\?XRAY_SUBSCRIPTION_URL_PREFIX/c\XRAY_SUBSCRIPTION_URL_PREFIX="https://'"$DOMAIN"'"' $ENV_PATH
else
    echo "❌ .env dosyası bulunamadı! Lütfen elle kontrol edin: $ENV_PATH"
    exit 1
fi

echo "🔄 Marzban yeniden başlatılıyor..."
marzban restart

echo "👤 Admin hesabı oluşturuluyor..."
marzban cli admin create --sudo

echo ""
echo "✅ Kurulum tamamlandı!"
echo "🔗 Yönetim paneline şu adresten erişebilirsiniz:"
echo "👉 https://$DOMAIN:8000/dashboard/"
