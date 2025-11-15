# 🚀 Установка и быстрый старт

## ⚡ Самый быстрый способ (рекомендуется)

### Шаг 1: Установка Puppeteer

```bash
# В директории n8n выполните:
npm install puppeteer
```

### Шаг 2: Импорт FULL VERSION workflow

1. Откройте **n8n**
2. Перейдите в **Workflows**
3. Нажмите **"+" → "Import from URL"**
4. Вставьте ссылку:

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full.json
```

5. Нажмите **"Import"**

✅ Workflow полностью готов к работе!

### Шаг 3: Получение credentials

1. Откройте https://claude.ai в браузере
2. Авторизуйтесь
3. Откройте **DevTools** (F12)
4. Перейдите **Application → Cookies → https://claude.ai**
5. Скопируйте значения:
   - **sessionKey** (начинается с `sk-ant-sid01-...`)
   - **__cf_bm** (Cloudflare cookie)

### Шаг 4: Настройка workflow

1. Откройте импортированный workflow
2. Найдите ноду **"Extract Parameters"**
3. Замените:
   - `YOUR_SESSION_KEY_HERE` → ваш **sessionKey**
   - `YOUR_CF_BM_COOKIE_HERE` → ваш **__cf_bm**
4. Сохраните (Ctrl+S)

### Шаг 5: Тестирование

1. Нажмите на ноду **"Manual Trigger"**
2. Нажмите **"Execute Node"** (или "Test workflow")
3. Дождитесь выполнения (30-60 секунд)
4. Проверьте результат в ноде **"Respond to Webhook"**

✅ **Готово!** Вы получите ответ от Claude.ai

## 📋 Что включено в FULL VERSION

Workflow содержит 8 нод:

```
1. Webhook ─────────────────┐
                             ├──→ 3. Extract Parameters
2. Manual Trigger ──────────┘         ↓
                                4. Puppeteer - Claude Interaction
                                      ↓
                                5. Check Success
                                ┌─────┴─────┐
                                ↓           ↓
                        6. Success    7. Error
                           Response      Response
                                └─────┬─────┘
                                      ↓
                              8. Respond to Webhook
```

### Ноды:

1. **Webhook** - Прием HTTP POST запросов
2. **Manual Trigger** - Ручной запуск для тестирования
3. **Extract Parameters** - Извлечение промпта и credentials
4. **Puppeteer - Claude Interaction** - Автоматизация браузера (Code node)
5. **Check Success** - Проверка успешности выполнения
6. **Format Success Response** - Форматирование успешного ответа
7. **Format Error Response** - Форматирование ошибки с деталями
8. **Respond to Webhook** - Возврат JSON ответа

## 🔧 Системные требования

### Node.js и npm
```bash
node --version  # v18+ рекомендуется
npm --version   # v8+
```

### Системные пакеты для Puppeteer

#### Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install -y \
  chromium-browser \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils
```

#### CentOS/RHEL:
```bash
sudo yum install -y \
  chromium \
  alsa-lib \
  atk \
  cups-libs \
  gtk3 \
  libXcomposite \
  libXdamage \
  libXrandr \
  libgbm \
  libxkbcommon \
  nss \
  pango
```

#### macOS:
```bash
# Chromium устанавливается автоматически с Puppeteer
brew install --cask google-chrome  # опционально
```

#### Windows:
```bash
# Puppeteer автоматически скачает Chromium
# Дополнительные пакеты не требуются
```

### Docker (если используете n8n в контейнере)

Добавьте в Dockerfile:

```dockerfile
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
RUN npm install -g puppeteer

# Переменные окружения для Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

USER node
```

## 🧪 Тестирование через Webhook

После активации workflow:

### cURL:
```bash
curl -X POST https://your-n8n-instance.com/webhook/claude-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет! Расскажи короткую шутку про разработчиков",
    "sessionKey": "YOUR_SESSION_KEY",
    "cfBmCookie": "YOUR_CF_BM_COOKIE"
  }'
```

### JavaScript:
```javascript
const response = await fetch('https://your-n8n.com/webhook/claude-automation', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    prompt: 'Объясни квантовую запутанность простым языком',
    sessionKey: 'YOUR_SESSION_KEY',
    cfBmCookie: 'YOUR_CF_BM_COOKIE',
    timeout: 90000
  })
});

const data = await response.json();
console.log('Claude ответил:', data.claudeResponse);
```

### Python:
```python
import requests

response = requests.post(
    'https://your-n8n.com/webhook/claude-automation',
    json={
        'prompt': 'Напиши хайку про искусственный интеллект',
        'sessionKey': 'YOUR_SESSION_KEY',
        'cfBmCookie': 'YOUR_CF_BM_COOKIE'
    }
)

data = response.json()
if data['success']:
    print(f"Ответ: {data['claudeResponse']}")
else:
    print(f"Ошибка: {data['error']}")
```

## 📊 Формат ответа

### Успешный:
```json
{
  "success": true,
  "prompt": "Привет! Как дела?",
  "claudeResponse": "Привет! У меня всё отлично, спасибо...",
  "timestamp": "2025-11-15T14:00:00.000Z",
  "responseLength": 150,
  "cookiesInfo": {
    "sessionKey": "sk-ant-sid01-ITi3It...",
    "cfBmCookie": "1y.RWS8nkXHpLAogpDL..."
  }
}
```

### С ошибкой:
```json
{
  "success": false,
  "error": "Navigation timeout exceeded",
  "errorStack": "Error: Navigation timeout...",
  "timestamp": "2025-11-15T14:00:00.000Z",
  "screenshot": "base64_encoded_screenshot_data",
  "help": "Проверьте: 1) Актуальность куков, 2) Доступность claude.ai, 3) Селекторы в коде"
}
```

## 🔍 Отладка

### Проблема: "Cannot find module 'puppeteer'"

**Решение:**
```bash
cd ~/.n8n  # или ваша директория n8n
npm install puppeteer
```

### Проблема: "Chromium not found"

**Решение:**
```bash
# Linux
sudo apt-get install chromium-browser

# macOS
brew install chromium

# Или укажите путь к Chrome:
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome
```

### Проблема: "Selector not found: div[contenteditable]"

**Решение:** Claude.ai изменил интерфейс

1. Откройте workflow
2. Найдите ноду **"Puppeteer - Claude Interaction"**
3. Откройте код (двойной клик)
4. Обновите селекторы:

```javascript
// Найдите строки с селекторами:
await page.waitForSelector('div[contenteditable="true"]');  // ← проверьте актуальность
await page.click('button[aria-label="Send Message"]');      // ← проверьте актуальность
```

5. Откройте https://claude.ai/new в браузере
6. DevTools (F12) → Elements
7. Найдите правильные селекторы
8. Обновите в коде

### Проблема: "Authentication failed"

**Решение:** Куки устарели

1. Удалите старые куки из браузера (claude.ai)
2. Выполните logout → login
3. Получите новые значения sessionKey и __cf_bm
4. Обновите в ноде "Extract Parameters"

### Включить визуальный режим (для отладки):

В ноде "Puppeteer - Claude Interaction" найдите:
```javascript
headless: true,  // ← измените на false
```

Теперь браузер будет открываться визуально.

## 📈 Производительность

### Типичное время выполнения:
- Короткий промпт: **30-45 секунд**
- Средний промпт: **45-60 секунд**
- Длинный промпт: **60-90 секунд**

### Оптимизация:

1. **Кэширование** - сохраняйте частые ответы в базе
2. **Queue** - используйте очередь для множественных запросов
3. **Timeout** - увеличьте для сложных промптов:
   ```javascript
   timeout: 120000  // 2 минуты
   ```

## 🔒 Безопасность

### 1. Используйте n8n Credentials

Вместо хардкода в workflow:

1. Settings → Credentials → Add Credential
2. Тип: **Generic Credential**
3. Добавьте:
   - `claude_session_key`
   - `claude_cf_bm`
4. В workflow используйте:
   ```javascript
   $credentials.claude_session_key
   $credentials.claude_cf_bm
   ```

### 2. Ограничьте доступ к Webhook

В ноде Webhook добавьте аутентификацию:
- Basic Auth
- Header Auth
- IP Whitelist

### 3. Обновляйте куки регулярно

Создайте отдельный workflow для автоматического обновления.

## 📚 Дополнительные материалы

- [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md) - Полное руководство
- [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md) - 10 практических примеров
- [PUPPETEER_CODE.md](./PUPPETEER_CODE.md) - Альтернативный код Puppeteer
- [README.md](./README.md) - Главная страница

## 💡 Частые вопросы

**Q: Можно ли использовать без Puppeteer?**
A: Нет, Puppeteer необходим для автоматизации браузера. Claude.ai пока не имеет публичного API.

**Q: Как долго действуют куки?**
A: Обычно 12-24 часа. Зависит от настроек Claude.ai.

**Q: Можно ли запускать параллельно?**
A: Да, но рекомендуется ограничить до 3-5 одновременных запросов.

**Q: Работает ли на Windows?**
A: Да, Puppeteer работает на всех платформах.

**Q: Нужен ли headless режим?**
A: Для продакшена - да. Для отладки можно использовать `headless: false`.

---

**Готово к использованию за 5 минут!** 🚀

Если возникли проблемы - проверьте раздел "Отладка" выше.
