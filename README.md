# 🚀 Marzban Otomatik Kurulum Scripti

Bu script, [Marzban](https://github.com/gozargah/marzban) kontrol panelini Ubuntu sunucuya tam otomatik şekilde kurar.  
Alan adı (domain) ve SSL sertifikası yapılandırmasıyla birlikte, kullanıma hazır bir VPN yönetim paneli elde edersiniz.

---

## 📌 Özellikler

✅ Ubuntu 20.04 / 22.04 desteği  
✅ SSL sertifikası (Let's Encrypt / acme.sh) otomatik kurulumu  
✅ DuckDNS gibi ücretsiz domainlerle uyumlu  
✅ Gerekli paketlerin kurulumu (`curl`, `socat`)  
✅ Marzban kurulum ve yapılandırması  
✅ `.env` dosyasına otomatik sertifika yolu ekleme  
✅ Admin kullanıcı oluşturma  
✅ Tamamen etkileşimli (email ve domain sorar)

---

## ⚙️ Gereksinimler

- Ubuntu 20.04 veya 22.04 sunucu (root erişimli)
- Açık portlar: `80`, `443`, `8000`
- Bir domain veya DuckDNS subdomain (örn: `myvpn.duckdns.org`)
- Internet bağlantısı
---
> ⚠️ **Önemli Not:**  
> Kurulum sırasında Marzban log ekranı açıldığında **CTRL+C** tuşlarına basarak bu ekranı kapatmalısınız.  
> Bu sadece log görüntüsüdür, kapatmak kuruluma zarar vermez.

![image](https://github.com/user-attachments/assets/8f2462c6-12cf-46e6-b6d6-3591ee8bf688)

---

## 🔧 Kurulum

### 1. Script'i indir

```bash
wget https://raw.githubusercontent.com/alexanderofficial09/marzban-autoscript/main/install.sh
chmod +x install.sh
sudo bash install.sh

