# 🤖 n8n Claude.AI Automation Workflows

Коллекция рабочих workflows для автоматизации с Claude.ai через n8n.

## 🚀 Быстрый импорт

### ⚡ Claude API (БЕЗ БРАУЗЕРА) - САМЫЙ ПРОСТОЙ! 🔥

**Импорт через URL:**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-api-direct.json
```

**Как использовать:**
1. n8n → Workflows → "+" → **Import from URL**
2. Вставьте URL выше
3. Import → Workflow загружен ✅
4. Откройте ноду **"Claude API Request"**
5. Замените `YOUR_CLAUDE_API_KEY_HERE` на ваш API ключ
6. Execute Workflow → Test!

**Преимущества:**
- ✅ **НЕ НУЖЕН Chrome/Chromium!**
- ✅ Скорость: **1-3 сек** vs 10-30 сек с браузером
- ✅ Надежность: официальный API
- ✅ Минимум ресурсов
- ✅ Работает всегда

📖 [Полное руководство по Claude API](./CLAUDE_API_WITHOUT_BROWSER.md)

---

### 🌐 Browserless HTTP API (ОБЛАЧНЫЙ БРАУЗЕР) - 0 ЗАВИСИМОСТЕЙ! 🔥

**Импорт через URL:**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-http-api.json
```

**Как использовать:**
1. n8n → Workflows → "+" → **Import from URL**
2. Вставьте URL выше
3. Import → Workflow загружен ✅
4. Откройте ноду **"Set Credentials"**
5. Замените `sessionKey` и `cfBmCookie`
6. Execute Workflow → Test!

**Преимущества:**
- ✅ **НЕ НУЖЕН Chrome!**
- ✅ **НЕ НУЖЕН Puppeteer!** (0 зависимостей)
- ✅ Облачный браузер Browserless
- ✅ Работает через HTTP API
- ✅ Поддержка cookies и sessions
- ✅ Стабильно и быстро (3-8 сек)
- ✅ Токен уже настроен!

📖 [Полное руководство Browserless HTTP API](./BROWSERLESS_HTTP_API.md)

---

### 🌐 Browserless + Puppeteer (альтернатива, требует npm)

**Импорт через URL:**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-automation.json
```

**Требования:** `npm install puppeteer`

📖 [Руководство Puppeteer + Browserless](./BROWSERLESS_GUIDE.md)

---

### 🌟 n8n-nodes-puppeteer (визуальный подход с браузером)

**Импорт через URL:**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json
```

**Как использовать:**
1. **Установите n8n-nodes-puppeteer**: `npm install n8n-nodes-puppeteer`
2. **Перезапустите n8n**
3. n8n → Workflows → "+" → **Import from URL**
4. Вставьте URL выше
5. Import → Workflow загружен ✅
6. Откройте ноду **"Set Credentials"**
7. Замените `YOUR_SESSION_KEY_HERE` и `YOUR_CF_BM_COOKIE_HERE`
8. Execute Workflow → Test!

**Преимущества:**
- ✅ Визуальный интерфейс - настройка через UI!
- ✅ Нет написания кода - все через готовые ноды
- ✅ Легко отлаживать - видно каждый шаг
- ✅ Модульность - копируйте ноды в другие workflows
- ✅ 10 готовых нод для каждого действия

📖 [Подробная инструкция по n8n-nodes-puppeteer](./N8N_NODES_PUPPETEER_GUIDE.md)

---

### 🎯 FULL VERSION - READY (упрощенная, credentials в коде)

**Импорт через URL:**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full-ready-public.json
```

**Как использовать:**
1. **Установите Puppeteer**: `npm install puppeteer`
2. n8n → Workflows → "+" → **Import from URL**
3. Вставьте URL выше
4. Import → Workflow загружен ✅
5. Откройте ноду **"Claude AI Automation"** → Edit
6. В начале кода (строки 4-5) замените:
   ```javascript
   const SESSION_KEY = 'YOUR_SESSION_KEY_HERE';
   const CF_BM_COOKIE = 'YOUR_CF_BM_COOKIE_HERE';
   ```
7. Вставьте ваши реальные значения → Save
8. Execute Workflow → Test!

**Преимущества:**
- ✅ Упрощенная структура - всего 6 нод!
- ✅ Все в одном месте - credentials в начале кода
- ✅ Не нужны отдельные ноды для параметров
- ✅ Полная версия с обработкой ошибок и скриншотами
- ✅ Детальное логирование каждого шага
- ✅ Легко обновлять credentials

---

### ⭐ FULL VERSION (для GitHub/публичных репозиториев)

**Импорт через URL (требует настройки credentials):**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full.json
```

**Как использовать:**
1. **Установите Puppeteer**: `npm install puppeteer`
2. n8n → Workflows → "+" → **Import from URL**
3. Вставьте URL выше
4. Import → Workflow загружен ✅
5. Откройте ноду "Extract Parameters"
6. Замените `YOUR_SESSION_KEY_HERE` и `YOUR_CF_BM_COOKIE_HERE` на ваши значения
7. Execute Node → Test!

---

### Базовая версия (требует ручной настройки)

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json
```

Эта версия требует установки `n8n-nodes-puppeteer` и ручного добавления Puppeteer node.

📖 [Подробная инструкция](./QUICK_START.md)

---

## 📦 Что внутри

### 1. Claude.AI Puppeteer Automation - FULL READY 🌟
- ✅ Credentials вшиты в код - работает сразу!
- ✅ Автоматическая отправка запросов к Claude.ai
- ✅ Cookie-based аутентификация
- ✅ Webhook и Manual Trigger
- ✅ Обработка ошибок со скриншотами
- ✅ Настраиваемые таймауты
- ✅ Детальное логирование

### 2. Claude.AI Puppeteer Automation - FULL
- ✅ Автоматическая отправка запросов к Claude.ai
- ✅ Cookie-based аутентификация
- ✅ Webhook и Manual Trigger
- ✅ Обработка ошибок со скриншотами
- ✅ Настраиваемые таймауты
- ⚙️ Требует настройки credentials через UI

### 3. Google Gemini - Production Ready
- ✅ Прямое API взаимодействие
- ✅ Proxy support
- ✅ Structured analysis
- ✅ Error handling

## 📚 Документация

| Файл | Описание |
|------|----------|
| [CLAUDE_API_WITHOUT_BROWSER.md](./CLAUDE_API_WITHOUT_BROWSER.md) | 🔥 **API без браузера - самый простой способ!** |
| [BROWSERLESS_HTTP_API.md](./BROWSERLESS_HTTP_API.md) | 🌐 **Browserless HTTP API - 0 зависимостей!** |
| [BROWSERLESS_GUIDE.md](./BROWSERLESS_GUIDE.md) | 🌐 Browserless + Puppeteer (требует npm) |
| [QUICK_START.md](./QUICK_START.md) | Быстрый старт за 5 минут |
| [INSTALLATION.md](./INSTALLATION.md) | Подробная инструкция по установке |
| [READY_TO_USE.md](./READY_TO_USE.md) | Гайд по FULL READY версии |
| [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md) | Полное руководство (480+ строк) |
| [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md) | 10 практических примеров |
| [PUPPETEER_CODE.md](./PUPPETEER_CODE.md) | Код для Puppeteer node |
| [CHROME_INSTALL_FIX.md](./CHROME_INSTALL_FIX.md) | Решение проблемы Chrome not found |

## 🎯 Примеры использования

### Telegram Bot
```javascript
Telegram → Claude Automation → Response
```

### Email Analysis
```javascript
IMAP → Extract → Claude → Database → Notification
```

### Content Generation
```javascript
Schedule → Get Topic → Claude → Social Media Post
```

### Document Processing
```javascript
File Upload → OCR → Claude → Structured Data
```

### Customer Support
```javascript
Chat → Knowledge Base → Claude → Auto Response
```

[Больше примеров →](./CLAUDE_EXAMPLES.md)

## ⚙️ Требования

```bash
# Puppeteer (обязательно)
npm install puppeteer

# Системные зависимости (Ubuntu/Debian)
apt-get install -y chromium fonts-liberation libappindicator3-1
```

## 🔐 Настройка Credentials

### Вариант 1: FULL READY (рекомендуется) - уже настроено!

Credentials уже вшиты в файл `claude-ai-puppeteer-automation-full-ready.json`

### Вариант 2: Ручная настройка

1. Откройте https://claude.ai
2. Авторизуйтесь
3. DevTools (F12) → Application → Cookies
4. Скопируйте:
   - `sessionKey`
   - `__cf_bm`
5. Вставьте в workflow или n8n Credentials

## 🔗 Прямые ссылки на workflows

### Для локального импорта (с credentials):

**FULL READY VERSION (рекомендуется):**
```
workflows/claude-ai-puppeteer-automation-full-ready.json
```

### Для импорта через URL (без credentials):

**Claude.AI FULL:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full.json
```

**Google Gemini:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/google-gemini---no-proxy-(test-first).json
```

### Для прямой загрузки:

```bash
# Claude FULL (без credentials)
curl -O https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full.json

# Google Gemini
curl -O https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/google-gemini---no-proxy-(test-first).json
```

## 📊 Архитектура

```
┌──────────────┐
│   Trigger    │  Webhook / Manual / Schedule / IMAP / etc.
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Processing  │  Extract params, validate, transform
└──────┬───────┘
       │
       ▼
┌──────────────┐
│   Claude/    │  Puppeteer automation or API call
│   Gemini     │
└──────┬───────┘
       │
   ────┴────
   │       │
   ▼       ▼
Success  Error
   │       │
   └───┬───┘
       ▼
┌──────────────┐
│   Response   │  Format and return JSON
└──────────────┘
```

## 🌟 Возможности

- **Автоматизация Claude.ai** через Puppeteer
- **API интеграция** с Google Gemini
- **Webhook endpoints** для внешних вызовов
- **Error handling** с детальными логами
- **Screenshot capture** при ошибках
- **Configurable timeouts** для разных задач
- **Multi-language** примеры (curl, JS, Python)
- **Ready-to-use** версия с вшитыми credentials

## 🛠️ Troubleshooting

### Chrome/Chromium not found
```
Could not find Chrome (ver. 142.0.7444.162)
```
📖 **Решение**: [CHROME_INSTALL_FIX.md](./CHROME_INSTALL_FIX.md) - подробное руководство по установке Chrome/Chromium

### Puppeteer не запускается
```bash
# Установите зависимости
apt-get install -y chromium chromium-browser
```

### Ошибки аутентификации Claude
```
Обновите куки - они имеют ограниченный срок действия
```

### Timeout errors
```javascript
// Увеличьте timeout в параметрах
{
  "timeout": 120000  // 2 минуты
}
```

### Selector not found
```
Claude.ai обновил интерфейс - проверьте селекторы в коде
```

## 📈 Roadmap

- [ ] OAuth аутентификация для Claude
- [ ] Streaming responses
- [ ] Conversation history management
- [ ] Multi-model support
- [ ] Rate limiting
- [ ] Caching layer

## 🤝 Contributing

Форкните репозиторий и создавайте Pull Request с вашими улучшениями!

## 📄 Лицензия

MIT License - используйте свободно

## 📞 Поддержка

- **Issues**: GitHub Issues
- **Документация**: [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md)
- **Примеры**: [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md)
- **FULL READY**: [READY_TO_USE.md](./READY_TO_USE.md)

---

**Создано с ❤️ для автоматизации AI workflows**

⭐ Поставьте звезду, если проект полезен!
