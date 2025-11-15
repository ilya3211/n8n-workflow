# ⚡ Быстрое решение: Cannot find module 'puppeteer'

## ✅ Решено! Puppeteer установлен

Puppeteer установлен в `/home/user/n8n-workflow/node_modules/puppeteer`

## ⚠️ Текущая проблема: Chromium заблокирован сетью

Скачивание Chromium заблокировано (Error 403 Forbidden).
Это ограничение сетевого доступа в вашей среде.

### 🔧 Решение 1: Скачать Chromium вручную (рекомендуется)

```bash
# Скачайте Chromium
cd /home/user/n8n-workflow
npx @puppeteer/browsers install chrome@stable

# Или укажите конкретную версию
npx @puppeteer/browsers install chrome@121.0.6167.85
```

### 🔧 Решение 2: Использовать Docker Chromium

Если n8n запущен в Docker, добавьте Chromium в контейнер:

```bash
# В контейнере выполните:
apt-get update && apt-get install -y chromium

# Или добавьте в Dockerfile:
RUN apt-get update && apt-get install -y chromium-browser
```

### 🔧 Решение 3: Указать путь к системному Chrome/Chromium

Если Chrome/Chromium уже установлен в системе:

1. Найдите путь к Chrome:
   ```bash
   which google-chrome chromium chromium-browser
   ```

2. Откройте workflow в n8n

3. В ноде "Claude AI Automation" найдите:
   ```javascript
   browser = await puppeteer.launch({
     headless: true,
     args: [...]
   });
   ```

4. Замените на:
   ```javascript
   browser = await puppeteer.launch({
     executablePath: '/usr/bin/chromium-browser', // или путь из шага 1
     headless: true,
     args: [
       '--no-sandbox',
       '--disable-setuid-sandbox',
       '--disable-dev-shm-usage',
       '--disable-gpu'
     ]
   });
   ```

## 🚀 Проверка после установки Chromium

```bash
# Проверьте Puppeteer
cd /home/user/n8n-workflow
node -e "const puppeteer = require('puppeteer'); console.log('✅ Puppeteer OK');"

# Проверьте Chromium (если установлен через npx)
ls -la /home/user/n8n-workflow/node_modules/puppeteer/.local-chromium/
```

## 📝 Текущий статус

```
✅ Puppeteer: установлен (v24.30.0)
❌ Chromium: НЕ установлен (нужно установить вручную)
📍 Путь: /home/user/n8n-workflow/node_modules/puppeteer
```

## 🎯 Следующие шаги

1. **Выберите** одно из решений выше
2. **Установите** Chromium
3. **Запустите** workflow снова
4. **Готово!** ✅

---

**Если проблемы продолжаются**, попробуйте использовать версию workflow без Puppeteer (через API).
