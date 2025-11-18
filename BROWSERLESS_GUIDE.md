# 🌐 Извлечение Cloudflare Turnstile Sitekey через Browserless.io

## 🎯 Преимущества Browserless.io

✅ **Не нужно устанавливать Chromium** - браузер в облаке
✅ **Работает сразу** - нет проблем с зависимостями
✅ **Обход Cloudflare** - лучшая совместимость
✅ **Масштабируемость** - неограниченное количество запросов
✅ **Простота** - один API ключ и всё работает

---

## 📦 Два workflow

| Файл | Тип | Использование |
|------|-----|---------------|
| `extract-sitekey-browserless.json` | Manual | Ручной запуск в n8n UI |
| `extract-sitekey-browserless-webhook.json` | API | HTTP запросы |

---

## 🔑 Ваш API ключ уже настроен

```
Token: 2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac
```

**Уже вшит в workflow!** Ничего не нужно настраивать.

---

## 🚀 Быстрый старт

### Шаг 1: Импорт workflow

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/workflows/extract-sitekey-browserless.json
```

1. В n8n: **"..." → "Import from URL"**
2. Вставьте ссылку выше
3. **Import**

### Шаг 2: Настройка (опционально)

Откройте ноду **"⚙️ Settings"**

По умолчанию:
```javascript
targetURL: "https://claude.ai/new"
browserlessToken: "2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac"
waitTime: 5000
```

**Можно изменить только `targetURL`** на нужный сайт.

### Шаг 3: Запуск

1. Нажмите **"Execute Workflow"**
2. Ждите ~10-15 секунд
3. Смотрите результат в **"📊 Final Result"**

---

## 📊 Результат

```json
{
  "✅ success": true,
  "🔑 websiteKey (SITEKEY)": "0x4AAAAAAAAAljKdsKLfj...",
  "🌐 websiteURL": "https://claude.ai/new",
  "📋 captchaType": "standalone",
  "🖥️ userAgent": "Mozilla/5.0...",
  "🔍 methods": "[\"✅ selector: [data-sitekey]\"]",
  "🤖 RuCaptcha API Request": "{\n  \"clientKey\": \"YOUR_API_KEY\",\n  \"task\": {...}\n}",
  "⏰ timestamp": "2025-11-18T17:30:00.000Z"
}
```

---

## 🌐 Webhook API версия

### Импорт

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/workflows/extract-sitekey-browserless-webhook.json
```

### Использование

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://claude.ai/new"
  }'
```

### Параметры (опционально)

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -d '{
    "url": "https://claude.ai/new",
    "waitTime": 7000,
    "browserlessToken": "your-token-here"
  }'
```

| Параметр | Тип | Обязателен | По умолчанию | Описание |
|----------|-----|------------|--------------|----------|
| `url` | String | Да | - | URL страницы |
| `waitTime` | Number | Нет | 5000 | Время ожидания (мс) |
| `browserlessToken` | String | Нет | Встроенный | Ваш Browserless.io токен |

---

## 🔗 Интеграция с RuCaptcha

### Python пример

```python
import requests
import time

# 1. Извлечь sitekey через Browserless.io
response = requests.post(
    'http://localhost:5678/webhook/extract-sitekey-browserless',
    json={'url': 'https://claude.ai/new'}
)

data = response.json()
sitekey = data['websiteKey']
url = data['websiteURL']

print(f"✅ Sitekey: {sitekey}")

# 2. Отправить в RuCaptcha
task = requests.post(
    'https://api.rucaptcha.com/createTask',
    json={
        'clientKey': 'YOUR_RUCAPTCHA_API_KEY',
        'task': {
            'type': 'TurnstileTaskProxyless',
            'websiteURL': url,
            'websiteKey': sitekey
        }
    }
)

task_id = task.json()['taskId']
print(f"📝 Task ID: {task_id}")

# 3. Получить токен
while True:
    time.sleep(3)
    result = requests.post(
        'https://api.rucaptcha.com/getTaskResult',
        json={
            'clientKey': 'YOUR_RUCAPTCHA_API_KEY',
            'taskId': task_id
        }
    )
    if result.json()['status'] == 'ready':
        token = result.json()['solution']['token']
        print(f"✅ Token: {token}")
        break

# 4. Используйте токен!
```

---

### Bash скрипт (полный цикл)

```bash
#!/bin/bash

# 1. Извлечь sitekey
RESULT=$(curl -s -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -H "Content-Type: application/json" \
  -d '{"url": "https://claude.ai/new"}')

SITEKEY=$(echo $RESULT | jq -r '.websiteKey')
URL=$(echo $RESULT | jq -r '.websiteURL')

echo "✅ Sitekey: $SITEKEY"

# 2. Создать задачу RuCaptcha
TASK=$(curl -s -X POST https://api.rucaptcha.com/createTask \
  -H "Content-Type: application/json" \
  -d "{
    \"clientKey\": \"YOUR_RUCAPTCHA_API_KEY\",
    \"task\": {
      \"type\": \"TurnstileTaskProxyless\",
      \"websiteURL\": \"$URL\",
      \"websiteKey\": \"$SITEKEY\"
    }
  }")

TASK_ID=$(echo $TASK | jq -r '.taskId')
echo "📝 Task ID: $TASK_ID"

# 3. Ожидание решения
echo "⏳ Ждем решения..."
while true; do
  sleep 3

  SOLUTION=$(curl -s -X POST https://api.rucaptcha.com/getTaskResult \
    -H "Content-Type: application/json" \
    -d "{
      \"clientKey\": \"YOUR_RUCAPTCHA_API_KEY\",
      \"taskId\": $TASK_ID
    }")

  STATUS=$(echo $SOLUTION | jq -r '.status')

  if [ "$STATUS" = "ready" ]; then
    TOKEN=$(echo $SOLUTION | jq -r '.solution.token')
    echo "✅ Token: $TOKEN"
    break
  fi
done
```

---

## 🔍 Методы поиска sitekey

Browserless.io workflow использует **4 метода**:

### 1. Перехват turnstile.render()
Для Challenge Pages - перехватывает вызов и извлекает все параметры

### 2. DOM селекторы
```javascript
[data-sitekey]
[sitekey]
div[class*="turnstile"]
iframe[src*="challenges.cloudflare.com"]
```

### 3. HTML Regex
```javascript
/data-sitekey=["']([0-9a-zA-Z_-]{10,100})["']/
/["']sitekey["']\s*:\s*["']([0-9a-zA-Z_-]{10,100})["']/
```

### 4. Script tags
Поиск в `<script>` тегах с паттерном `0x...`

---

## ⚙️ Настройки Browserless.io

### Изменить URL

**Нода**: `⚙️ Settings`
```javascript
targetURL: "https://your-site.com"
```

### Увеличить время ожидания

Если капча загружается долго:
```javascript
waitTime: 10000  // 10 секунд
```

### Использовать свой токен

```javascript
browserlessToken: "your-token-here"
```

---

## 💰 Лимиты Browserless.io

Проверьте ваш план на https://www.browserless.io/

Ваш токен: `2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac`

**Бесплатный план**:
- 6 часов/месяц
- 1 одновременный запрос

**Paid планы**:
- От $49/месяц
- 50+ часов
- Больше одновременных запросов

---

## 🎬 Примеры использования

### Пример 1: Claude.AI

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -d '{"url": "https://claude.ai/new"}'
```

### Пример 2: ChatGPT

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -d '{"url": "https://chat.openai.com/"}'
```

### Пример 3: Любой сайт с Turnstile

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -d '{"url": "https://example.com/protected-page"}'
```

### Пример 4: С увеличенным временем ожидания

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey-browserless \
  -d '{
    "url": "https://slow-site.com",
    "waitTime": 10000
  }'
```

---

## 🐛 Troubleshooting

### Проблема: "Request timeout"

**Решение**: Увеличьте waitTime
```bash
curl -X POST ... -d '{"url": "...", "waitTime": 15000}'
```

---

### Проблема: "Sitekey not found"

**Причины**:
1. Сайт не использует Cloudflare Turnstile
2. Капча загружается очень долго
3. Динамический контент требует действий пользователя

**Решение**: Проверьте `searchMethods` в результате:
```json
{
  "searchMethods": [
    "❌ turnstile.render() not found",
    "❌ selectors not found",
    "❌ html regex not found",
    "❌ script tags not found"
  ]
}
```

Если все методы ❌ - сайт не использует Turnstile или требует дополнительной настройки.

---

### Проблема: "Invalid token"

**Решение**: Проверьте токен на https://www.browserless.io/account

Или получите новый токен и обновите в workflow.

---

### Проблема: "Rate limit exceeded"

**Решение**:
1. Проверьте использование на Browserless.io dashboard
2. Апгрейдите план
3. Или ждите сброса лимитов (начало месяца)

---

## 📊 Сравнение: Browserless vs Локальный Puppeteer

| Параметр | Browserless.io | Локальный Puppeteer |
|----------|----------------|---------------------|
| Установка Chromium | ❌ Не нужна | ✅ Обязательна |
| Зависимости | ❌ Нет | ✅ Много библиотек |
| Настройка | ⚡ 1 минута | ⏰ 10-30 минут |
| Стоимость | 💰 Платная (от $49) | 🆓 Бесплатно |
| Масштабируемость | ✅ Отличная | ⚠️ Ограничена сервером |
| Обход Cloudflare | ✅ Лучше | ⚠️ Хуже |
| Проблемы с правами | ❌ Нет | ✅ Могут быть |

**Рекомендация**:
- **Browserless.io** - для production, быстрого старта, обхода Cloudflare
- **Локальный Puppeteer** - для разработки, если нет бюджета

---

## 🎯 Workflow процесс

```
1. HTTP POST запрос с URL
   ↓
2. Отправка в Browserless.io API
   ↓
3. Browserless.io запускает Chrome
   ↓
4. Открывает страницу
   ↓
5. Перехватывает turnstile.render()
   ↓
6. Ищет sitekey 4 методами
   ↓
7. Возвращает результат
   ↓
8. Форматирование JSON
   ↓
9. Ответ клиенту
```

**Время выполнения**: 10-20 секунд

---

## 💡 Pro Tips

### Tip 1: Кэширование результатов

Sitekey редко меняется. Кэшируйте на 24 часа:

```python
import redis
r = redis.Redis()

cache_key = f"sitekey:{url}"
cached = r.get(cache_key)

if cached:
    return json.loads(cached)

# Извлечь через Browserless...
result = requests.post(...)
r.setex(cache_key, 86400, result.text)
```

### Tip 2: Пул токенов

Если один токен медленный, используйте несколько:

```python
tokens = [
    "token1",
    "token2",
    "token3"
]

import random
token = random.choice(tokens)

requests.post(..., json={
    'url': url,
    'browserlessToken': token
})
```

### Tip 3: Retry логика

```python
import time

max_retries = 3
for attempt in range(max_retries):
    try:
        result = requests.post(...)
        if result.json()['success']:
            break
    except Exception as e:
        if attempt == max_retries - 1:
            raise
        time.sleep(2 ** attempt)  # Exponential backoff
```

---

## ✅ Чек-лист готовности

- [ ] n8n установлен и запущен
- [ ] Workflow импортирован
- [ ] Workflow активирован (для Webhook версии)
- [ ] Browserless.io токен проверен
- [ ] Тестовый запрос выполнен успешно

---

## 🎉 Готово!

Вы можете:

1. ✅ **Извлекать sitekey БЕЗ установки Chromium**
2. ✅ **Обходить Cloudflare Turnstile**
3. ✅ **Использовать через HTTP API**
4. ✅ **Интегрировать с RuCaptcha**
5. ✅ **Масштабировать неограниченно**

**URL для импорта (Manual)**:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/workflows/extract-sitekey-browserless.json
```

**URL для импорта (Webhook API)**:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/workflows/extract-sitekey-browserless-webhook.json
```

**Начните прямо сейчас! Никаких установок - просто импортируйте и используйте! 🚀**
