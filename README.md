# 🤖 n8n Claude.AI Automation Workflows

Коллекция рабочих workflows для автоматизации с Claude.ai через n8n и Puppeteer.

## 🚀 Быстрый импорт

### 🌟 FULL VERSION - READY (со вшитыми credentials) - РЕКОМЕНДУЕТСЯ!

**Локальный файл с вашими credentials уже вставленными:**

```
workflows/claude-ai-puppeteer-automation-full-ready.json
```

**Как использовать:**
1. **Установите Puppeteer**: `npm install puppeteer`
2. n8n → Workflows → "+" → **Import from File**
3. Выберите файл `claude-ai-puppeteer-automation-full-ready.json`
4. Import → **ГОТОВО!** Просто нажмите Execute Workflow ✅
5. Никакой настройки - credentials уже вшиты в код!

**Преимущества:**
- ✅ Работает сразу после импорта - 0 настройки!
- ✅ Credentials из `.env.claude` уже вставлены в код
- ✅ Не требует изменения через UI
- ✅ Полная версия с обработкой ошибок и скриншотами
- ✅ Детальное логирование каждого шага
- ✅ 6 нод - упрощенная структура

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
| [QUICK_START.md](./QUICK_START.md) | Быстрый старт за 5 минут |
| [INSTALLATION.md](./INSTALLATION.md) | Подробная инструкция по установке |
| [READY_TO_USE.md](./READY_TO_USE.md) | Гайд по FULL READY версии |
| [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md) | Полное руководство (480+ строк) |
| [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md) | 10 практических примеров |
| [PUPPETEER_CODE.md](./PUPPETEER_CODE.md) | Код для Puppeteer node |

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
