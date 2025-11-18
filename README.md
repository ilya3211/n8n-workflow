# n8n Workflows

Репозиторий для хранения и синхронизации workflows из n8n.

## Структура
- `workflows/` - папка с JSON-файлами workflows

## 🚀 Быстрый импорт workflows

### Google AI Studio Automation (Browserless)

Автоматизация работы с Google AI Studio через browserless и Puppeteer.

#### Импорт через URL в n8n:

**Базовая версия:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-automation.json
```

**Продвинутая версия:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-advanced.json
```

#### Документация:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/GOOGLE_AI_STUDIO_AUTOMATION_README.md
```

### Как импортировать в n8n:

1. Откройте n8n
2. Нажмите **Workflows → Import from URL**
3. Вставьте одну из ссылок выше
4. Нажмите **Import**
5. Активируйте workflow

### Другие workflows:

- `test-workflow.json` - Тестовый workflow
- `github_repo_workflows_sync.json` - Синхронизация workflows с GitHub
- `google-gemini---no-proxy-(test-first).json` - Gemini API без прокси

---

## 📚 Дополнительная документация

- **[USAGE_EXAMPLES.md](USAGE_EXAMPLES.md)** - Готовые примеры использования для вашего домена
- **[READY_TO_USE_COMMANDS.sh](READY_TO_USE_COMMANDS.sh)** - Shell скрипт с готовыми командами
- **[IMPORT_URLS.md](IMPORT_URLS.md)** - Подробная инструкция по импорту
- **[workflows-index.json](workflows-index.json)** - Индекс всех workflows с метаданными

---

## 🌐 Ваш n8n инстанс

**Домен:** https://jejopeguki.beget.app/

### Webhook URLs:

**Базовая версия:**
```
https://jejopeguki.beget.app/webhook/ai-studio-automation
```

**Продвинутая версия:**
```
https://jejopeguki.beget.app/webhook/ai-studio-advanced
```

### Быстрый тест:

```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет! Расскажи о себе",
    "temperature": 0.7,
    "maxTokens": 2048
  }'
```

Подробные примеры смотрите в [USAGE_EXAMPLES.md](USAGE_EXAMPLES.md)
