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
