# 🔧 Установка Puppeteer для n8n

## ❌ Проблема: Cannot find module 'puppeteer'

Эта ошибка возникает когда Puppeteer не установлен или установлен не в той директории.

## ✅ Решение

### Вариант 1: Установка в директорию n8n (рекомендуется)

```bash
# Найдите директорию n8n
cd ~/.n8n

# Установите puppeteer
npm install puppeteer

# Проверьте установку
npm list puppeteer
```

### Вариант 2: Глобальная установка

```bash
# Установите puppeteer глобально
npm install -g puppeteer

# Или в директорию n8n
npm install --prefix ~/.n8n puppeteer
```

### Вариант 3: Для Docker n8n

Если используете n8n в Docker:

```dockerfile
# Добавьте в Dockerfile или docker-compose.yml
FROM n8nio/n8n:latest

USER root

# Установка Chromium и зависимостей
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Установка Puppeteer
RUN cd /usr/local/lib/node_modules/n8n && npm install puppeteer

# Переменные окружения
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
```

Или через docker-compose.yml:

```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=password
      - PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
    volumes:
      - ~/.n8n:/home/node/.n8n
      - ./custom-node-modules:/usr/local/lib/node_modules/n8n/node_modules
    command: sh -c "apk add --no-cache chromium && npm install puppeteer && n8n start"
```

## 🔍 Проверка установки

После установки проверьте:

```bash
# Проверьте, что puppeteer установлен
cd ~/.n8n
npm list puppeteer

# Должно вывести что-то вроде:
# └── puppeteer@21.x.x
```

## 🐛 Troubleshooting

### Ошибка: "Chromium not found"

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install -y chromium-browser

# Alpine (Docker)
apk add chromium

# macOS
brew install chromium
```

### Ошибка: "Failed to launch browser"

```bash
# Установите зависимости
# Ubuntu/Debian:
sudo apt-get install -y \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libc6 \
  libcairo2 \
  libcups2 \
  libdbus-1-3 \
  libexpat1 \
  libfontconfig1 \
  libgbm1 \
  libgcc1 \
  libglib2.0-0 \
  libgtk-3-0 \
  libnspr4 \
  libnss3 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libstdc++6 \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  lsb-release \
  wget \
  xdg-utils
```

### Ошибка: "Permission denied"

```bash
# Дайте права на запись
sudo chown -R $USER:$USER ~/.n8n

# Или запустите с sudo (не рекомендуется)
sudo npm install puppeteer
```

## 📝 Альтернатива: Использование системного Chrome/Chromium

Если Puppeteer устанавливается долго или не хватает места, используйте системный Chrome:

```bash
# Установите только puppeteer-core (без Chromium)
npm install puppeteer-core

# Затем укажите путь к Chrome в коде workflow
```

В workflow замените в начале:

```javascript
const puppeteer = require('puppeteer');

browser = await puppeteer.launch({
  executablePath: '/usr/bin/chromium-browser', // или /usr/bin/google-chrome
  headless: true,
  args: ['--no-sandbox', '--disable-setuid-sandbox']
});
```

## ✅ После установки

1. Перезапустите n8n:
   ```bash
   # Если запущен через npm
   pkill -f n8n
   n8n start

   # Если через Docker
   docker-compose restart
   ```

2. Откройте workflow в n8n

3. Нажмите "Execute Workflow"

4. Должно работать! ✅

## 📍 Проверка пути установки

```bash
# Найдите где установлен n8n
npm list -g n8n

# Типичные пути:
# ~/.n8n/
# /usr/local/lib/node_modules/n8n/
# /home/user/.n8n/

# Установите puppeteer в ту же директорию
cd <путь_к_n8n>
npm install puppeteer
```

## 🎯 Быстрая установка (скопируйте и вставьте)

```bash
# Для локального n8n
cd ~/.n8n && npm install puppeteer && echo "✅ Puppeteer установлен!"

# Проверка
npm list puppeteer && echo "✅ Puppeteer найден!"
```

## 📚 Дополнительные ресурсы

- [Puppeteer Documentation](https://pptr.dev/)
- [n8n Community Forum](https://community.n8n.io/)
- [Troubleshooting Puppeteer](https://pptr.dev/troubleshooting)

---

После установки Puppeteer workflow должен работать без ошибок! 🚀
