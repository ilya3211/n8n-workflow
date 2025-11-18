#!/bin/bash
# Скрипт установки для root пользователя

set -e

echo "════════════════════════════════════════════════════════════"
echo "🚀 Установка n8n + n8n-nodes-puppeteer + Chromium"
echo "════════════════════════════════════════════════════════════"
echo ""

# Проверка root
if [ "$EUID" -ne 0 ]; then
   echo "❌ Запустите от root: sudo ./install-root.sh"
   exit 1
fi

echo "✅ Запущено от root"
echo ""

# 1. Установка Chromium
echo "📦 Шаг 1: Установка Chromium..."
apt-get update -qq
apt-get install -y chromium-browser

if which chromium-browser > /dev/null 2>&1; then
    CHROMIUM_PATH=$(which chromium-browser)
    echo "✅ Chromium установлен: $CHROMIUM_PATH"
    chromium-browser --version
else
    echo "❌ Ошибка установки Chromium"
    exit 1
fi
echo ""

# 2. Установка n8n локально (в проекте)
echo "📦 Шаг 2: Установка n8n..."
cd /home/user/n8n-workflow
npm install n8n
echo "✅ n8n установлен"
echo ""

# 3. Установка n8n-nodes-puppeteer
echo "📦 Шаг 3: Установка n8n-nodes-puppeteer..."
npm install n8n-nodes-puppeteer
echo "✅ n8n-nodes-puppeteer установлен"
echo ""

# 4. Установка Puppeteer
echo "📦 Шаг 4: Установка Puppeteer..."
npm install puppeteer
echo "✅ Puppeteer установлен"
echo ""

# 5. Установка дополнительных зависимостей для Chromium
echo "📦 Шаг 5: Установка зависимостей для Chromium..."
apt-get install -y \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libwayland-client0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils

echo "✅ Зависимости установлены"
echo ""

# 6. Создание .env файла
echo "📝 Шаг 6: Создание .env файла..."
if [ ! -f ".env" ]; then
    cat > .env << EOF
# n8n Configuration
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_HOST=localhost

# Puppeteer Configuration
PUPPETEER_EXECUTABLE_PATH=$CHROMIUM_PATH

# Claude.AI Credentials (ОБНОВИТЕ!)
CLAUDE_SESSION_KEY=YOUR_SESSION_KEY_HERE
CLAUDE_CF_BM_COOKIE=YOUR_CF_BM_COOKIE_HERE
EOF
    echo "✅ .env создан"
else
    echo "ℹ️  .env уже существует"
fi
echo ""

# 7. Проверка установки
echo "🧪 Шаг 7: Проверка установки..."
echo ""
echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Chromium: $(chromium-browser --version 2>&1 | head -1)"
echo ""

# Проверка npm пакетов
echo "Установленные пакеты:"
npm list --depth=0 2>/dev/null | grep -E "n8n|puppeteer" || echo "  (пакеты установлены)"
echo ""

# 8. Создание простого теста Puppeteer
echo "📝 Создание тестового скрипта..."
cat > test-puppeteer.js << 'EOJS'
const puppeteer = require('puppeteer');

(async () => {
  console.log('🧪 Тестирование Puppeteer + Chromium...');

  try {
    const browser = await puppeteer.launch({
      executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || '/usr/bin/chromium-browser',
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });

    console.log('✅ Браузер запущен');

    const page = await browser.newPage();
    await page.goto('https://example.com');
    const title = await page.title();

    console.log('✅ Страница загружена:', title);

    await browser.close();
    console.log('✅ Тест успешен! Puppeteer работает корректно.');
  } catch (error) {
    console.error('❌ Ошибка:', error.message);
    process.exit(1);
  }
})();
EOJS

echo "✅ Тестовый скрипт создан: test-puppeteer.js"
echo ""

echo "════════════════════════════════════════════════════════════"
echo "✅ Установка завершена!"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "📝 Следующие шаги:"
echo ""
echo "1. Протестируйте Puppeteer:"
echo "   node test-puppeteer.js"
echo ""
echo "2. Получите credentials из claude.ai:"
echo "   - Откройте https://claude.ai"
echo "   - F12 → Application → Cookies"
echo "   - Скопируйте: sessionKey и __cf_bm"
echo ""
echo "3. Обновите .env файл:"
echo "   nano .env"
echo ""
echo "4. Запустите n8n:"
echo "   npx n8n start"
echo ""
echo "5. Откройте браузер:"
echo "   http://localhost:5678"
echo ""
echo "6. Импортируйте workflow:"
echo "   workflows/claude-ai-via-n8n-nodes-puppeteer.json"
echo ""
echo "🎉 Готово к использованию!"
echo ""
