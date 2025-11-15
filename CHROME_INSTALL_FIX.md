# 🚨 Решение проблемы Chrome not found

## Проблема
```
Could not find Chrome (ver. 142.0.7444.162)
Cache path: /home/node/.cache/puppeteer
```

## ✅ Быстрое решение - Скачать Chrome вручную

Из-за сетевых ограничений автоматическая загрузка заблокирована. Используйте один из вариантов:

### Вариант 1: Portable Chrome (рекомендуется)

```bash
# Создайте директорию для Chrome
mkdir -p /home/node/.cache/puppeteer/chrome/linux-142.0.7444.162/chrome-linux

# Скачайте портативную версию Chrome с зеркала
# (выполните на машине с интернетом без ограничений)
wget https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F1372858%2Fchrome-linux.zip?alt=media -O chrome.zip

# Распакуйте
unzip chrome.zip -d /home/node/.cache/puppeteer/chrome/linux-142.0.7444.162/

# Дайте права на выполнение
chmod +x /home/node/.cache/puppeteer/chrome/linux-142.0.7444.162/chrome-linux/chrome
```

### Вариант 2: Использовать любой установленный браузер

Настройте n8n-nodes-puppeteer на использование системного браузера:

**Для n8n-nodes-puppeteer:**

1. Установите Chrome/Chromium любым доступным способом:
   ```bash
   # Через snap (если доступен)
   snap install chromium

   # Или вручную скачайте .deb пакет
   ```

2. Найдите путь к браузеру:
   ```bash
   which chromium || which google-chrome || which chromium-browser
   ```

3. В n8n настройте environment variable:
   ```bash
   export PUPPETEER_EXECUTABLE_PATH=/snap/bin/chromium
   # или
   export PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome
   ```

4. Перезапустите n8n

### Вариант 3: Для Code Node workflow - укажите executablePath

Если используете Code node (FULL READY версию):

Откройте workflow → ноду "Claude AI Automation" → измените код:

```javascript
browser = await puppeteer.launch({
  executablePath: '/snap/bin/chromium', // укажите путь к вашему браузеру
  headless: true,
  args: [
    '--no-sandbox',
    '--disable-setuid-sandbox',
    '--disable-dev-shm-usage',
    '--disable-gpu'
  ]
});
```

### Вариант 4: Использовать Playwright вместо Puppeteer

Установите Playwright (он скачивает браузеры по-другому):

```bash
npm install playwright
npx playwright install chromium
```

Затем измените код на использование Playwright.

## 🔍 Проверка после установки

```bash
# Проверьте что Chrome установлен
ls -la /home/node/.cache/puppeteer/

# Или проверьте системный браузер
chromium --version
google-chrome --version

# Проверьте что Puppeteer его видит
node -e "const puppeteer = require('puppeteer'); (async () => { const browser = await puppeteer.launch({headless: true}); console.log('✅ Browser launched!'); await browser.close(); })();"
```

## 📋 Рекомендуемая последовательность действий

1. **Попробуйте snap:**
   ```bash
   snap install chromium
   export PUPPETEER_EXECUTABLE_PATH=/snap/bin/chromium
   ```

2. **Если snap не работает**, скачайте Chrome портативный:
   - На машине с интернетом скачайте chrome-linux.zip
   - Перенесите на целевую машину
   - Распакуйте в `/home/node/.cache/puppeteer/chrome/linux-142.0.7444.162/`

3. **Настройте n8n**:
   ```bash
   # Добавьте в переменные окружения n8n
   export PUPPETEER_EXECUTABLE_PATH=/путь/к/chrome

   # Перезапустите n8n
   ```

4. **Тестируйте workflow**

## 🎯 Альтернатива - API вместо браузерной автоматизации

Если установка Chrome невозможна, рассмотрите использование официального Claude API (когда будет доступен) или других методов автоматизации.

---

**После установки Chrome workflow заработает!** 🚀
