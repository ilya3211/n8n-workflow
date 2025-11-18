# 🔐 Извлечение Cloudflare Turnstile Sitekey - Полное руководство

## 📋 Описание

Эти workflows автоматически извлекают **sitekey** и другие параметры Cloudflare Turnstile капчи с любого сайта, включая **claude.ai**.

**Два типа капчи поддерживаются:**
1. **Standalone Captcha** - виджет капчи на странице
2. **Cloudflare Challenge Page** - страница проверки Cloudflare

---

## 🎯 Что делают workflows

### Вход:
- URL сайта (например: `https://claude.ai/new`)

### Выход:
- `websiteKey` (sitekey) - ключ капчи
- `websiteURL` - URL страницы
- `userAgent` - User-Agent браузера
- `action`, `data`, `pagedata` - дополнительные параметры для Challenge Pages
- `rucaptchaPayload` - готовый JSON для RuCaptcha API

---

## 📦 Два варианта workflow

| Файл | Тип | Использование |
|------|-----|---------------|
| `extract-cloudflare-turnstile-sitekey.json` | Manual Trigger | Ручной запуск через UI |
| `extract-cloudflare-turnstile-webhook.json` | Webhook API | HTTP API доступ |

---

## 🚀 Установка и настройка

### Шаг 1: Импорт workflow

```bash
# В n8n UI:
# Settings → Import from File
# Выберите один из файлов:
workflows/extract-cloudflare-turnstile-sitekey.json
workflows/extract-cloudflare-turnstile-webhook.json
```

### Шаг 2: Активация workflow

1. Откройте импортированный workflow
2. Нажмите **"Active"** в правом верхнем углу

---

## 🎮 Использование: Manual Trigger версия

### 1. Настройка URL

Откройте ноду **"Set Target URL"** и измените:

```javascript
targetURL: "https://claude.ai/new"  // Замените на нужный URL
```

### 2. Запуск

1. Нажмите на ноду **"Manual Trigger"**
2. Нажмите **"Execute Workflow"**
3. Дождитесь завершения (~10-15 секунд)

### 3. Результат

Откройте ноду **"Format Result"** и посмотрите Output:

```json
{
  "success": true,
  "captchaType": "standalone",
  "websiteURL": "https://claude.ai/new",
  "websiteKey": "0x4AAAAAAA...",
  "userAgent": "Mozilla/5.0...",
  "action": "",
  "data": "",
  "pagedata": "",
  "rucaptchaAPIRequest": "{...готовый JSON для API...}",
  "timestamp": "2025-11-18T16:00:00.000Z"
}
```

---

## 🌐 Использование: Webhook API версия

### 1. Получить Webhook URL

После активации workflow:

1. Откройте ноду **"Webhook"**
2. Скопируйте **Production URL**, например:
```
https://your-n8n.com/webhook/extract-sitekey
```

Или локальный:
```
http://localhost:5678/webhook/extract-sitekey
```

### 2. Вызов API

#### Пример запроса (curl):

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://claude.ai/new",
    "waitTime": 3000
  }'
```

#### Параметры:

| Параметр | Тип | Обязателен | Описание |
|----------|-----|------------|----------|
| `url` | String | Да | URL страницы для извлечения sitekey |
| `waitTime` | Number | Нет | Время ожидания загрузки капчи (мс), по умолчанию 3000 |

#### Пример ответа:

```json
{
  "success": true,
  "captchaType": "standalone",
  "websiteURL": "https://claude.ai/new",
  "websiteKey": "0x4AAAAAAAAAljKdsKLfjdslJKSDf",
  "userAgent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36",
  "action": null,
  "data": null,
  "pagedata": null,
  "rucaptchaPayload": "{\"clientKey\":\"YOUR_API_KEY\",\"task\":{...}}",
  "timestamp": "2025-11-18T16:30:45.123Z",
  "error": null
}
```

---

## 🔧 Интеграция с RuCaptcha API

### Шаг 1: Извлечь sitekey

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Content-Type: application/json" \
  -d '{"url": "https://claude.ai/new"}' \
  > sitekey_result.json
```

### Шаг 2: Отправить в RuCaptcha

```bash
# Извлечь websiteKey из результата
SITEKEY=$(cat sitekey_result.json | jq -r '.websiteKey')

# Создать задачу в RuCaptcha
curl -X POST https://api.rucaptcha.com/createTask \
  -H "Content-Type: application/json" \
  -d "{
    \"clientKey\": \"YOUR_RUCAPTCHA_API_KEY\",
    \"task\": {
      \"type\": \"TurnstileTaskProxyless\",
      \"websiteURL\": \"https://claude.ai/new\",
      \"websiteKey\": \"$SITEKEY\"
    }
  }"
```

### Шаг 3: Получить токен

```bash
# Ответ от createTask
{
  "errorId": 0,
  "taskId": 123456789
}

# Получить результат (повторять каждые 3-5 сек)
curl -X POST https://api.rucaptcha.com/getTaskResult \
  -H "Content-Type: application/json" \
  -d "{
    \"clientKey\": \"YOUR_RUCAPTCHA_API_KEY\",
    \"taskId\": 123456789
  }"

# Когда готово:
{
  "errorId": 0,
  "status": "ready",
  "solution": {
    "token": "0.zrSnRHO7h0HwSjSCU8oyzbjEtD8p..."
  }
}
```

---

## 📊 Типы капчи и методы извлечения

### 1. Standalone Captcha

**Описание**: Виджет капчи размещен прямо на странице

**Методы поиска sitekey**:
1. Атрибут `data-sitekey` элемента
2. Поиск в `iframe src`
3. Regex поиск в HTML коде
4. Поиск в JavaScript коде

**Пример HTML**:
```html
<div class="cf-turnstile" data-sitekey="0x4AAAAAAAlj..."></div>
```

**Результат**:
```json
{
  "captchaType": "standalone",
  "websiteKey": "0x4AAAAAAAlj...",
  "action": null,
  "data": null,
  "pagedata": null
}
```

---

### 2. Cloudflare Challenge Page

**Описание**: Капча на странице проверки Cloudflare ("Checking your browser...")

**Методы извлечения**:
1. Перехват вызова `turnstile.render()`
2. Извлечение параметров: `sitekey`, `action`, `cData`, `chlPageData`

**Результат**:
```json
{
  "captchaType": "challenge_page",
  "websiteKey": "0x4AAAAAAAlj...",
  "action": "managed",
  "data": "80001aa1affffc21",
  "pagedata": "3gAFo2l...55NDFPRFE9"
}
```

**Важно**: Для Challenge Pages нужны **все параметры** для RuCaptcha API!

---

## 🔍 Примеры использования

### Пример 1: Извлечь sitekey из claude.ai

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Content-Type: application/json" \
  -d '{"url": "https://claude.ai/new"}'
```

**Результат**:
```json
{
  "success": true,
  "websiteKey": "0x4AAAAAAA...",
  "captchaType": "standalone"
}
```

---

### Пример 2: Полный цикл с RuCaptcha

**Node.js пример**:

```javascript
const axios = require('axios');

// Шаг 1: Извлечь sitekey
const extractResult = await axios.post('http://localhost:5678/webhook/extract-sitekey', {
  url: 'https://claude.ai/new'
});

const { websiteKey, websiteURL, userAgent } = extractResult.data;

if (!websiteKey) {
  throw new Error('Sitekey not found');
}

// Шаг 2: Создать задачу в RuCaptcha
const createTaskResult = await axios.post('https://api.rucaptcha.com/createTask', {
  clientKey: 'YOUR_RUCAPTCHA_API_KEY',
  task: {
    type: 'TurnstileTaskProxyless',
    websiteURL: websiteURL,
    websiteKey: websiteKey
  }
});

const taskId = createTaskResult.data.taskId;

// Шаг 3: Ожидание решения
let token = null;
while (!token) {
  await new Promise(resolve => setTimeout(resolve, 3000));

  const resultResponse = await axios.post('https://api.rucaptcha.com/getTaskResult', {
    clientKey: 'YOUR_RUCAPTCHA_API_KEY',
    taskId: taskId
  });

  if (resultResponse.data.status === 'ready') {
    token = resultResponse.data.solution.token;
  }
}

console.log('Токен получен:', token);

// Шаг 4: Использовать токен на странице
// Вставить в поле cf-turnstile-response или передать в callback
```

---

### Пример 3: Python интеграция

```python
import requests
import time
import json

# 1. Извлечь sitekey
extract_response = requests.post(
    'http://localhost:5678/webhook/extract-sitekey',
    json={'url': 'https://claude.ai/new'}
)

data = extract_response.json()
website_key = data['websiteKey']
website_url = data['websiteURL']

print(f"Sitekey: {website_key}")

# 2. Создать задачу
create_task = requests.post(
    'https://api.rucaptcha.com/createTask',
    json={
        'clientKey': 'YOUR_API_KEY',
        'task': {
            'type': 'TurnstileTaskProxyless',
            'websiteURL': website_url,
            'websiteKey': website_key
        }
    }
)

task_id = create_task.json()['taskId']

# 3. Получить решение
while True:
    time.sleep(3)
    result = requests.post(
        'https://api.rucaptcha.com/getTaskResult',
        json={
            'clientKey': 'YOUR_API_KEY',
            'taskId': task_id
        }
    )

    if result.json()['status'] == 'ready':
        token = result.json()['solution']['token']
        print(f"Token: {token}")
        break
```

---

## 🛠️ Настройка workflow

### Увеличить время ожидания

Если капча загружается долго, увеличьте `waitTime`:

**В ноде "Wait for Captcha"**:
```javascript
timeout: 5000  // 5 секунд вместо 3
```

**Или через API**:
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new", "waitTime": 5000}'
```

---

### Добавить прокси (опционально)

Для использования прокси с Puppeteer, в ноде "Navigate to URL" добавьте:

```javascript
{
  "url": "https://claude.ai/new",
  "waitUntil": "networkidle2",
  "launchOptions": {
    "args": [
      "--proxy-server=http://proxy.example.com:8080"
    ]
  }
}
```

---

## 📝 Структура workflow

```
Manual Trigger / Webhook
    ↓
Set Target URL / Extract Parameters
    ↓
Puppeteer - Navigate (открыть страницу)
    ↓
Puppeteer - Inject Intercept Script (перехват turnstile.render)
    ↓
Puppeteer - Wait for Turnstile (ожидание загрузки)
    ↓
Puppeteer - Extract Sitekey (извлечение данных)
    ↓
[Optional] Puppeteer - Screenshot
    ↓
Format Result / Respond to Webhook (вернуть JSON)
```

---

## ⚡ Оптимизация производительности

### 1. Кэширование sitekey

Sitekey обычно не меняется часто. Можно кэшировать на 24 часа:

```javascript
// Добавить ноду "Redis" или "Set" для кэша
const cacheKey = `sitekey:${url}`;
const cached = await redis.get(cacheKey);

if (cached) {
  return JSON.parse(cached);
}

// ... извлечь sitekey ...

await redis.setex(cacheKey, 86400, JSON.stringify(result));
```

---

### 2. Параллельные запросы

Если нужно извлечь sitekey с нескольких сайтов:

```bash
# Запустить параллельно
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://site1.com"}' &

curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://site2.com"}' &

wait
```

---

## 🔒 Безопасность

### 1. Защита Webhook

Добавьте аутентификацию в ноду "Webhook":

```javascript
// В ноде "Extract Parameters" добавьте проверку:
if ($json.headers.authorization !== 'Bearer YOUR_SECRET_TOKEN') {
  throw new Error('Unauthorized');
}
```

**Использование**:
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Authorization: Bearer YOUR_SECRET_TOKEN" \
  -d '{"url": "https://claude.ai/new"}'
```

---

### 2. Rate Limiting

Ограничьте количество запросов, чтобы не перегружать сервер.

---

## 🐛 Troubleshooting

### Проблема: "Sitekey not found"

**Причины**:
1. Капча еще не загрузилась
2. Сайт использует другой тип капчи
3. Динамическая загрузка требует больше времени

**Решение**:
```bash
# Увеличить waitTime
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new", "waitTime": 10000}'
```

---

### Проблема: "Browser not found"

**Решение**:
```bash
# Установить Chromium
snap install chromium

# Установить переменную окружения
export PUPPETEER_EXECUTABLE_PATH=/snap/bin/chromium

# Перезапустить n8n
npx n8n start
```

---

### Проблема: "Timeout"

**Решение**:
1. Проверьте интернет соединение
2. Увеличьте timeout в ноде "Navigate":
   ```javascript
   timeout: 60000  // 60 секунд
   ```

---

## 📚 Полезные ссылки

- [RuCaptcha API Documentation](https://rucaptcha.com/api-rucaptcha)
- [Cloudflare Turnstile Documentation](https://developers.cloudflare.com/turnstile/)
- [n8n Documentation](https://docs.n8n.io/)
- [Puppeteer API](https://pptr.dev/)

---

## 🎉 Готовые примеры для популярных сайтов

### Claude.AI
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new"}'
```

### ChatGPT
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://chat.openai.com/"}'
```

### Любой другой сайт
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://your-target-site.com"}'
```

---

## 💡 Советы

1. **Тестируйте локально** перед развертыванием в production
2. **Кэшируйте sitekey** - он редко меняется
3. **Используйте webhook версию** для API интеграции
4. **Добавьте обработку ошибок** в свой код
5. **Мониторьте изменения** структуры сайта

---

**Готово! Теперь вы можете автоматически извлекать Cloudflare Turnstile sitekey с любого сайта! 🚀**
