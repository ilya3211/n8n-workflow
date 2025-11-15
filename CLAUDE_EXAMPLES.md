# 📚 Примеры использования Claude.AI Automation

## 🎯 Практические сценарии

### 1. Интеграция с Telegram Bot

Создайте автоматического бота в Telegram, который отвечает через Claude:

```javascript
// n8n Workflow: Telegram → Claude → Telegram

// Node 1: Telegram Trigger
// Получение сообщения от пользователя

// Node 2: HTTP Request к Claude Automation
{
  "prompt": "{{ $json.message.text }}",
  "sessionKey": "{{ $credentials.claude.sessionKey }}",
  "cfBmCookie": "{{ $credentials.claude.cfBmCookie }}"
}

// Node 3: Telegram Send Message
// Отправка ответа пользователю
```

### 2. Автоматический анализ email

Обрабатывайте входящие письма через Claude:

```javascript
// n8n Workflow: Email → Claude → Database

// Node 1: Email Trigger (IMAP)
// Получение нового письма

// Node 2: Extract Email Content
{
  "subject": "{{ $json.subject }}",
  "body": "{{ $json.text }}",
  "from": "{{ $json.from }}"
}

// Node 3: Claude Automation
{
  "prompt": "Проанализируй это письмо и определи: тип (жалоба/вопрос/предложение), приоритет (низкий/средний/высокий), основная тема. Email: {{ $json.body }}",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Save to Database
// Сохранение результата анализа
```

### 3. Генерация контента для соцсетей

Автоматическое создание постов:

```javascript
// n8n Workflow: Schedule → Claude → Social Media

// Node 1: Schedule Trigger
// Запуск каждый день в 9:00

// Node 2: Get Topic from Database
// Получение темы для поста

// Node 3: Claude Automation
{
  "prompt": "Создай увлекательный пост для соцсетей на тему: {{ $json.topic }}. Требования: до 280 символов, с эмодзи, хештеги",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Post to Twitter/Facebook
// Публикация созданного контента
```

### 4. Обработка документов

Извлечение данных из документов:

```javascript
// n8n Workflow: File Upload → OCR → Claude → Structured Data

// Node 1: Webhook (File Upload)
// Получение загруженного документа

// Node 2: OCR Processing
// Извлечение текста из изображения/PDF

// Node 3: Claude Automation
{
  "prompt": "Извлеки из этого текста: имя, адрес, телефон, email, дату рождения в JSON формате. Текст: {{ $json.ocrText }}",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Parse JSON & Save
// Парсинг и сохранение структурированных данных
```

### 5. Чат-бот для поддержки клиентов

Автоматические ответы на вопросы:

```javascript
// n8n Workflow: Website Chat → Knowledge Base → Claude → Response

// Node 1: Webhook (Chat Message)
{
  "userId": "user123",
  "message": "Как вернуть товар?",
  "sessionId": "abc-xyz"
}

// Node 2: Search Knowledge Base
// Поиск релевантной информации в базе знаний

// Node 3: Claude Automation
{
  "prompt": "Используя эту информацию из базы знаний: {{ $json.knowledgeBase }}, ответь на вопрос клиента: {{ $json.message }}. Ответ должен быть вежливым и конкретным.",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Save to Chat History
// Сохранение истории переписки

// Node 5: Send Response to User
// Отправка ответа пользователю
```

### 6. Автоматическое резюмирование статей

Создание кратких выжимок из длинных текстов:

```javascript
// n8n Workflow: RSS → Claude → Newsletter

// Node 1: RSS Feed Trigger
// Получение новых статей

// Node 2: HTTP Request
// Загрузка полного текста статьи

// Node 3: Claude Automation
{
  "prompt": "Создай краткое резюме (3-5 предложений) этой статьи: {{ $json.articleText }}",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Aggregate Summaries
// Сбор всех резюме

// Node 5: Send Newsletter
// Отправка дайджеста подписчикам
```

### 7. Проверка кода

Автоматический code review:

```javascript
// n8n Workflow: GitHub Webhook → Claude → Comment

// Node 1: GitHub Trigger (Pull Request)
// Новый PR создан

// Node 2: Get PR Files
// Получение измененных файлов

// Node 3: Claude Automation
{
  "prompt": "Проверь этот код на наличие проблем, багов и улучшений: {{ $json.code }}. Предоставь конструктивный feedback.",
  "sessionKey": "...",
  "cfBmCookie": "...",
  "timeout": 90000
}

// Node 4: Post Comment to PR
// Добавление комментария с review
```

### 8. Перевод контента

Автоматический перевод на несколько языков:

```javascript
// n8n Workflow: New Article → Claude → Multi-language Publishing

// Node 1: Database Trigger
// Новая статья добавлена

// Node 2: Loop Over Languages
const languages = ['English', 'Spanish', 'French', 'German'];

// Node 3: Claude Automation (в цикле)
{
  "prompt": "Переведи этот текст на {{ $json.language }}, сохраняя стиль и тон: {{ $json.article }}",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Save Translations
// Сохранение переводов в базу
```

### 9. Сентимент-анализ отзывов

Анализ тональности отзывов клиентов:

```javascript
// n8n Workflow: Reviews → Claude → Analytics Dashboard

// Node 1: Database Query
// Получение новых отзывов

// Node 2: Claude Automation
{
  "prompt": "Проанализируй этот отзыв и определи: сентимент (позитивный/нейтральный/негативный), основные темы, упомянутые проблемы. Отзыв: {{ $json.review }}. Верни результат в JSON.",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 3: Parse & Store Results
// Парсинг JSON и сохранение

// Node 4: Update Dashboard
// Обновление аналитической панели
```

### 10. Генерация SEO-метаданных

Автоматическое создание SEO-оптимизированных описаний:

```javascript
// n8n Workflow: New Product → Claude → Update SEO

// Node 1: Product Added Trigger
{
  "productName": "Беспроводные наушники XYZ",
  "description": "...",
  "category": "Электроника"
}

// Node 2: Claude Automation
{
  "prompt": "Создай SEO-оптимизированные метаданные для этого товара: название: {{ $json.productName }}, описание: {{ $json.description }}. Нужны: meta title (до 60 символов), meta description (до 160 символов), ключевые слова (10 шт). Формат: JSON.",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 3: Update Product SEO Fields
// Обновление SEO-полей товара
```

## 🔗 Интеграции с другими сервисами

### Slack Integration

```javascript
// Slack Command → Claude → Slack Response

{
  "workflow": "slack-claude-integration",
  "trigger": "Slack Command: /ask",
  "steps": [
    {
      "name": "Receive Slack Command",
      "params": {
        "command": "/ask",
        "text": "{{ event.text }}"
      }
    },
    {
      "name": "Claude Automation",
      "params": {
        "prompt": "{{ $json.text }}",
        "sessionKey": "...",
        "cfBmCookie": "..."
      }
    },
    {
      "name": "Send to Slack",
      "params": {
        "channel": "{{ event.channel_id }}",
        "text": "{{ $json.claudeResponse }}"
      }
    }
  ]
}
```

### Google Sheets Integration

```javascript
// Google Sheets → Claude → Update Sheet

// Сценарий: Автоматическое заполнение таблицы
// Sheet columns: A=Question, B=Answer (пусто), C=Status

{
  "trigger": "Google Sheets Row Added",
  "process": {
    "prompt": "{{ $json.A }}",
    "sessionKey": "...",
    "cfBmCookie": "..."
  },
  "update": {
    "column_B": "{{ $json.claudeResponse }}",
    "column_C": "Processed"
  }
}
```

### Notion Integration

```javascript
// Notion Page → Claude → Summary

{
  "trigger": "New Notion Page",
  "steps": [
    {
      "name": "Get Page Content",
      "notion_page_id": "{{ event.page_id }}"
    },
    {
      "name": "Claude Automation",
      "params": {
        "prompt": "Создай краткое резюме и выдели ключевые пункты из этого документа: {{ $json.content }}",
        "sessionKey": "...",
        "cfBmCookie": "..."
      }
    },
    {
      "name": "Update Notion Page",
      "update_property": "Summary",
      "value": "{{ $json.claudeResponse }}"
    }
  ]
}
```

## 🎨 Продвинутые паттерны

### Pattern 1: Многоступенчатый диалог

Поддержка контекста беседы:

```javascript
// Используйте n8n Memory или Database для хранения контекста

// Node 1: Get Conversation History
const history = await getFromDatabase(conversationId);

// Node 2: Build Contextual Prompt
const fullPrompt = `
Предыдущий контекст:
${history.map(h => `User: ${h.user}\nClaude: ${h.claude}`).join('\n')}

Новый вопрос пользователя: ${currentMessage}
`;

// Node 3: Claude Automation
{
  "prompt": fullPrompt,
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 4: Save to History
await saveToDatabase(conversationId, {
  user: currentMessage,
  claude: response
});
```

### Pattern 2: Параллельная обработка

Отправка нескольких запросов одновременно:

```javascript
// Node 1: Split Into Batches
const prompts = [
  "Вопрос 1",
  "Вопрос 2",
  "Вопрос 3"
];

// Node 2: Loop (параллельно)
// Настройте n8n для параллельного выполнения

// Node 3: Merge Results
// Объединение всех ответов
```

### Pattern 3: Retry Logic с экспоненциальной задержкой

Обработка временных ошибок:

```javascript
// Node 1: Try Claude Automation

// Node 2: Error Handler
{
  "if": "{{ $json.success === false }}",
  "then": {
    "wait": "{{ Math.pow(2, $json.retryCount) * 1000 }}ms",
    "retry": true,
    "maxRetries": 3
  }
}

// Node 3: Fallback Response
{
  "if": "{{ $json.retryCount >= 3 }}",
  "then": {
    "response": "Извините, сервис временно недоступен"
  }
}
```

### Pattern 4: Кэширование ответов

Экономия запросов к Claude:

```javascript
// Node 1: Check Cache
const cacheKey = hashPrompt(prompt);
const cached = await redis.get(cacheKey);

if (cached) {
  return cached;
}

// Node 2: Claude Automation (если нет в кэше)
{
  "prompt": "...",
  "sessionKey": "...",
  "cfBmCookie": "..."
}

// Node 3: Save to Cache
await redis.set(cacheKey, response, 'EX', 3600); // 1 hour TTL
```

## 📊 Мониторинг и логирование

### Логирование всех запросов

```javascript
// Node: Save Request Log
{
  "timestamp": "{{ $now.toISO() }}",
  "prompt": "{{ $json.prompt }}",
  "response": "{{ $json.claudeResponse }}",
  "success": "{{ $json.success }}",
  "processingTime": "{{ $json.processingTime }}",
  "userId": "{{ $json.userId }}"
}
```

### Метрики производительности

```javascript
// Отслеживайте:
- Среднее время ответа
- Процент успешных запросов
- Количество запросов в час
- Топ популярных промптов
```

### Алерты при ошибках

```javascript
// Node: Error Alert
{
  "if": "{{ $json.success === false }}",
  "then": {
    "sendEmail": {
      "to": "admin@example.com",
      "subject": "Claude Automation Error",
      "body": "Error: {{ $json.error }}\nTimestamp: {{ $now.toISO() }}"
    }
  }
}
```

## 🔐 Best Practices

### 1. Управление куками

```javascript
// Используйте n8n Credentials вместо hardcode
const sessionKey = $credentials.claude.sessionKey;
const cfBmCookie = $credentials.claude.cfBmCookie;
```

### 2. Rate Limiting

```javascript
// Ограничение запросов
const requestsPerMinute = 10;
await rateLimiter.checkLimit(userId, requestsPerMinute);
```

### 3. Валидация входных данных

```javascript
// Проверка промпта перед отправкой
if (!prompt || prompt.length < 1 || prompt.length > 10000) {
  throw new Error('Invalid prompt length');
}
```

### 4. Graceful Degradation

```javascript
// Запасной вариант при недоступности Claude
if (claudeError) {
  return {
    response: "Извините, я временно недоступен. Попробуйте позже.",
    source: "fallback"
  };
}
```

## 💡 Советы по оптимизации промптов

### 1. Структурированные запросы

```javascript
// Плохо
"расскажи про товар"

// Хорошо
"Создай описание товара в формате:\n1. Заголовок (до 60 символов)\n2. Краткое описание (2-3 предложения)\n3. Ключевые характеристики (список)\n4. Призыв к действию"
```

### 2. Форматирование вывода

```javascript
// Запрос JSON ответа
"Верни результат в формате JSON: {sentiment: '', topics: [], priority: ''}"
```

### 3. Контекстная информация

```javascript
// Предоставьте контекст
`Ты - эксперт по российскому законодательству.
Пользователь спрашивает: ${question}
Дай точный ответ со ссылками на законы.`
```

---

**🚀 Теперь вы готовы создавать мощные автоматизации с Claude.AI!**
