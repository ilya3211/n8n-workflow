# 🚀 Быстрый старт - Claude.AI Automation

## 📥 Импорт workflow через URL

### Прямая ссылка на workflow:

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json
```

### Как импортировать в n8n:

1. Откройте n8n
2. Перейдите в **Workflows**
3. Нажмите **"+" → "Import from URL"**
4. Вставьте URL выше
5. Нажмите **"Import"**

## ⚡ Быстрая настройка

### 1. Получите ваши credentials:

Откройте https://claude.ai в браузере и выполните:

```javascript
// Откройте DevTools (F12) → Console
// Вставьте и выполните этот код:

console.log({
  sessionKey: document.cookie.match(/sessionKey=([^;]+)/)?.[1],
  cfBmCookie: document.cookie.match(/__cf_bm=([^;]+)/)?.[1]
});
```

### 2. Настройте workflow:

После импорта откройте workflow и замените в ноде **"Extract Parameters"**:

```
YOUR_SESSION_KEY_HERE → ваш sessionKey
YOUR_CF_BM_COOKIE_HERE → ваш __cf_bm
```

### 3. Тестируйте:

1. Нажмите на ноду **"Manual Trigger"**
2. Нажмите **"Execute Node"**
3. Дождитесь результата

## 🔗 Альтернативные способы импорта

### Способ 1: Прямая загрузка файла

```bash
# Скачайте workflow
curl -o claude-automation.json https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-puppeteer-automation.json

# Импортируйте через n8n UI: Import from File
```

### Способ 2: Git clone

```bash
# Клонируйте репозиторий
git clone -b claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia https://github.com/ilya3211/n8n-workflow.git

# Workflow находится в:
# n8n-workflow/workflows/claude-ai-puppeteer-automation.json
```

## 📚 Документация

- **Полная инструкция**: [CLAUDE_AUTOMATION_GUIDE.md](./CLAUDE_AUTOMATION_GUIDE.md)
- **Примеры использования**: [CLAUDE_EXAMPLES.md](./CLAUDE_EXAMPLES.md)
- **Ваши credentials**: `.env.claude` (локально)

## 🔐 Безопасность

⚠️ **Важно**:
- Куки имеют ограниченный срок действия
- Обновляйте их при получении ошибок авторизации
- Используйте n8n Credentials для безопасного хранения
- Не публикуйте свои sessionKey и cfBmCookie

## 📝 Примеры использования

### Через Webhook (после активации):

```bash
curl -X POST https://your-n8n-instance.com/webhook/claude-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет, Claude! Расскажи шутку про программистов",
    "sessionKey": "YOUR_SESSION_KEY",
    "cfBmCookie": "YOUR_CF_BM_COOKIE"
  }'
```

### Через JavaScript:

```javascript
const response = await fetch('https://your-n8n.com/webhook/claude-automation', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    prompt: 'Напиши хайку про AI',
    sessionKey: 'YOUR_SESSION_KEY',
    cfBmCookie: 'YOUR_CF_BM_COOKIE'
  })
});

const data = await response.json();
console.log(data.claudeResponse);
```

## 🛠️ Требования

1. **n8n** (любая версия)
2. **n8n-nodes-puppeteer** - установите через:
   ```bash
   npm install n8n-nodes-puppeteer
   ```
3. **Chromium** и зависимости:
   ```bash
   # Ubuntu/Debian
   apt-get install -y chromium chromium-browser fonts-liberation libappindicator3-1

   # CentOS/RHEL
   yum install -y chromium
   ```

## 🎯 Что дальше?

1. ✅ Импортируйте workflow через URL
2. ✅ Настройте credentials
3. ✅ Протестируйте через Manual Trigger
4. ✅ Активируйте Webhook
5. ✅ Интегрируйте в ваши приложения

## 💡 Подсказки

- **Таймаут**: По умолчанию 60 секунд. Увеличьте для длинных ответов
- **Ошибки селекторов**: Claude.ai может обновить интерфейс - проверьте селекторы
- **Отладка**: Включите screenshots в error response для диагностики
- **Rate limiting**: Не отправляйте слишком много запросов одновременно

## 📞 Поддержка

Если что-то не работает:
1. Проверьте логи n8n
2. Убедитесь, что куки актуальны
3. Проверьте установку Puppeteer
4. Посмотрите скриншот в error response

---

**Готово к использованию за 5 минут!** 🚀
