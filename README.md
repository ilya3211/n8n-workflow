# n8n Workflows

Репозиторий для хранения и синхронизации workflows из n8n.

## Структура
- `workflows/` - папка с JSON-файлами workflows

## 🚀 Быстрый импорт workflows

### Google AI Studio Automation (Browserless) ⭐

Автоматизация работы с Google AI Studio через browserless.io и Puppeteer с авторизацией через cookies.

#### ⚠️ Проблемы с импортом?

Если вы видите ошибку `"Problem loading workflow. The URL does not point to valid JSON file!"`:

👉 **См. подробное руководство:** [IMPORT_GUIDE.md](IMPORT_GUIDE.md)

**Краткое решение:** Скачайте JSON файл из папки `workflows/` и импортируйте через **Import from File** в n8n.

---

#### Рекомендуемые workflows:

**1. Полная автоматизация с авторизацией (РЕКОМЕНДУЕТСЯ):**
- Файл: `workflows/google-ai-studio-full-working.json`
- Что делает: Авторизация + отправка промпта + получение ответа + скриншот
- URL для импорта:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-full-working.json
```

**2. Тест авторизации с cookies:**
- Файл: `workflows/google-ai-studio-test-with-cookies.json`
- Что делает: Проверка авторизации через скриншот
- URL для импорта:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-test-with-cookies.json
```

**3. Универсальный workflow с параметрами:**
- Файл: `workflows/google-ai-studio-browserless-with-auth.json`
- Что делает: Передача cookies через параметры запроса
- URL для импорта:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-with-auth.json
```

**4. Базовый workflow без авторизации:**
- Файл: `workflows/google-ai-studio-browserless-correct.json`
- Что делает: Простое открытие страницы и скриншот
- URL для импорта:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-correct.json
```

---

### Как импортировать в n8n:

**Способ 1: Через URL (может не работать)**
1. Откройте n8n
2. Нажмите **Workflows → Import from URL**
3. Вставьте одну из ссылок выше
4. Нажмите **Import**

**Способ 2: Через файл (РЕКОМЕНДУЕТСЯ)**
1. Скачайте нужный `.json` файл из папки `workflows/`
2. Откройте n8n
3. Нажмите **Workflows → Import from File**
4. Выберите скачанный файл
5. Нажмите **Import**

📖 **Подробная инструкция:** [IMPORT_GUIDE.md](IMPORT_GUIDE.md)

### Другие workflows:

- `test-workflow.json` - Тестовый workflow
- `github_repo_workflows_sync.json` - Синхронизация workflows с GitHub
- `google-gemini---no-proxy-(test-first).json` - Gemini API без прокси

---

## 📚 Дополнительная документация

- **[IMPORT_GUIDE.md](IMPORT_GUIDE.md)** ⭐ - Подробное руководство по импорту workflows
- **[HOW_TO_GET_GOOGLE_COOKIES.md](HOW_TO_GET_GOOGLE_COOKIES.md)** - Как получить cookies для авторизации
- **[USAGE_EXAMPLES.md](USAGE_EXAMPLES.md)** - Готовые примеры использования для вашего домена
- **[READY_TO_USE_COMMANDS.sh](READY_TO_USE_COMMANDS.sh)** - Shell скрипт с готовыми командами
- **[TROUBLESHOOTING_PUPPETEER.md](TROUBLESHOOTING_PUPPETEER.md)** - Решение проблем с Puppeteer
- **[IMPORT_URLS.md](IMPORT_URLS.md)** - Подробная инструкция по импорту
- **[workflows-index.json](workflows-index.json)** - Индекс всех workflows с метаданными

---

## 🌐 Ваш n8n инстанс

**Домен:** https://jejopeguki.beget.app/

### Webhook URLs:

**Полная автоматизация (с авторизацией):**
```
https://jejopeguki.beget.app/webhook/ai-studio-full-auth
```

**Универсальный (передача cookies в параметрах):**
```
https://jejopeguki.beget.app/webhook/ai-studio-auth
```

**Базовый (без авторизации):**
```
https://jejopeguki.beget.app/webhook/ai-studio-correct
```

### Быстрый тест:

**Полная автоматизация (требует обновления cookies в workflow):**
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-full-auth \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи кратко о квантовых компьютерах"
  }'
```

**Универсальный (с передачей cookies):**
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-auth \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет!",
    "googleCookies": "[{\"name\":\"session\",\"value\":\"YOUR_SESSION_COOKIE\"}]"
  }'
```

**Базовый тест (без авторизации):**
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-correct \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Test"
  }'
```

📖 Подробные примеры смотрите в [USAGE_EXAMPLES.md](USAGE_EXAMPLES.md)
📖 Как получить cookies: [HOW_TO_GET_GOOGLE_COOKIES.md](HOW_TO_GET_GOOGLE_COOKIES.md)
