# 🤖 n8n Claude.AI Automation Workflows

Коллекция рабочих workflows для автоматизации с Claude.ai через n8n и Puppeteer.

## 🚀 Быстрый импорт

### Claude.AI Puppeteer Automation - ПОЛНАЯ ВЕРСИЯ ⭐

**Импорт FULL VERSION (готов к использованию):**

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation-full.json
```

**Как использовать:**
1. **Установите Puppeteer** (если еще не установлен): `npm install puppeteer`
2. n8n → Workflows → "+" → **Import from URL**
3. Вставьте URL выше
4. Import → Workflow загружен ✅ **Полностью рабочий!**
5. Откройте ноду "Extract Parameters"
6. Замените `YOUR_SESSION_KEY_HERE` и `YOUR_CF_BM_COOKIE_HERE` на ваши значения
7. Execute Node → Test!

### Базовая версия (требует ручной настройки)

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json
```

Эта версия требует установки `n8n-nodes-puppeteer` и ручного добавления Puppeteer node.

📖 [Подробная инструкция](./QUICK_START.md)

## 📦 Что внутри

### 1. Claude.AI Puppeteer Automation
- ✅ Автоматическая отправка запросов к Claude.ai
- ✅ Cookie-based аутентификация
- ✅ Webhook и Manual Trigger
- ✅ Обработка ошибок со скриншотами
- ✅ Настраиваемые таймауты

### 2. Google Gemini - Production Ready
- ✅ Прямое API взаимодействие
- ✅ Proxy support
- ✅ Structured analysis
- ✅ Error handling

## 📚 Документация

| Файл | Описание |
|------|----------|
| [QUICK_START.md](./QUICK_START.md) | Быстрый старт за 5 минут |
| [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md) | Полное руководство (480+ строк) |
| [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md) | 10 практических примеров |

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
# n8n-nodes-puppeteer
npm install n8n-nodes-puppeteer

# Системные зависимости (Ubuntu/Debian)
apt-get install -y chromium fonts-liberation libappindicator3-1
```

## 🔐 Настройка Credentials

1. Откройте https://claude.ai
2. Авторизуйтесь
3. DevTools (F12) → Application → Cookies
4. Скопируйте:
   - `sessionKey`
   - `__cf_bm`
5. Вставьте в workflow или n8n Credentials

## 🔗 Прямые ссылки на workflows

### Для импорта через URL:

**Claude.AI Automation:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json
```

**Google Gemini:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/google-gemini---no-proxy-(test-first).json
```

### Для прямой загрузки:

```bash
# Claude Automation
curl -O https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json

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

---

**Создано с ❤️ для автоматизации AI workflows**

⭐ Поставьте звезду, если проект полезен!
