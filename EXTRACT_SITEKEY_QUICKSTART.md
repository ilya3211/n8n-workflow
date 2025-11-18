# ⚡ Быстрый старт: Извлечение Cloudflare Turnstile Sitekey

## 🎯 Цель

**Вставили** `claude.ai` → **Получили** `sitekey` → **Без капчи!**

---

## 🚀 Установка (5 минут)

```bash
# 1. Убедитесь что n8n запущен
npx n8n start

# 2. Импортируйте workflow
# В n8n UI: Settings → Import from File
# Выберите: workflows/extract-cloudflare-turnstile-webhook.json

# 3. Активируйте workflow
# Нажмите "Active" в правом верхнем углу
```

---

## 💻 Использование

### Вариант 1: Через API (рекомендуется)

```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Content-Type: application/json" \
  -d '{"url": "https://claude.ai/new"}'
```

**Результат:**
```json
{
  "success": true,
  "websiteKey": "0x4AAAAAAA...",
  "websiteURL": "https://claude.ai/new",
  "captchaType": "standalone",
  "userAgent": "Mozilla/5.0..."
}
```

---

### Вариант 2: Через n8n UI

1. Откройте workflow в n8n
2. Измените URL в ноде "Set Target URL"
3. Нажмите "Execute Workflow"
4. Смотрите результат в последней ноде

---

## 🔗 Интеграция с RuCaptcha (полный пример)

### Bash скрипт (копировать и запустить):

```bash
#!/bin/bash

# 1. Извлечь sitekey
RESULT=$(curl -s -X POST http://localhost:5678/webhook/extract-sitekey \
  -H "Content-Type: application/json" \
  -d '{"url": "https://claude.ai/new"}')

SITEKEY=$(echo $RESULT | jq -r '.websiteKey')
URL=$(echo $RESULT | jq -r '.websiteURL')

echo "✅ Sitekey: $SITEKEY"

# 2. Создать задачу в RuCaptcha
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
echo "⏳ Ожидание решения..."
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

**Сохранить как** `extract_and_solve.sh` и запустить:
```bash
chmod +x extract_and_solve.sh
./extract_and_solve.sh
```

---

## 🐍 Python пример

```python
import requests
import time

# 1. Извлечь sitekey
response = requests.post(
    'http://localhost:5678/webhook/extract-sitekey',
    json={'url': 'https://claude.ai/new'}
)

data = response.json()
sitekey = data['websiteKey']
url = data['websiteURL']

print(f"✅ Sitekey: {sitekey}")

# 2. Создать задачу
task_response = requests.post(
    'https://api.rucaptcha.com/createTask',
    json={
        'clientKey': 'YOUR_API_KEY',
        'task': {
            'type': 'TurnstileTaskProxyless',
            'websiteURL': url,
            'websiteKey': sitekey
        }
    }
)

task_id = task_response.json()['taskId']
print(f"📝 Task ID: {task_id}")

# 3. Получить токен
print("⏳ Ожидание решения...")
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
        print(f"✅ Token: {token}")
        break
```

---

## 📊 Что возвращает API

### Успешный ответ:

```json
{
  "success": true,
  "captchaType": "standalone",
  "websiteURL": "https://claude.ai/new",
  "websiteKey": "0x4AAAAAAAAAljKdsKLfj...",
  "userAgent": "Mozilla/5.0 (X11; Linux x86_64)...",
  "action": null,
  "data": null,
  "pagedata": null,
  "rucaptchaPayload": "{\"clientKey\":\"YOUR_API_KEY\",...}",
  "timestamp": "2025-11-18T16:30:00.000Z",
  "error": null
}
```

### Ошибка (sitekey не найден):

```json
{
  "success": false,
  "captchaType": "not_found",
  "websiteURL": "https://example.com",
  "websiteKey": null,
  "error": "Cloudflare Turnstile sitekey not found on page",
  "timestamp": "2025-11-18T16:30:00.000Z"
}
```

---

## 🔥 Реальные примеры сайтов

### Claude.AI
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new"}'
```

### Со временем ожидания (если капча загружается долго)
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new", "waitTime": 5000}'
```

### GET запрос (альтернатива)
```bash
curl "http://localhost:5678/webhook/extract-sitekey?url=https://claude.ai/new"
```

---

## 🛠️ Troubleshooting

### Проблема: "Sitekey not found"

**Решение 1**: Увеличить время ожидания
```bash
curl -X POST http://localhost:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new", "waitTime": 10000}'
```

**Решение 2**: Проверить что Puppeteer работает
```bash
node test-puppeteer.js
```

---

### Проблема: "Connection refused"

**Решение**: Убедитесь что n8n запущен
```bash
npx n8n start

# В другом терминале:
curl http://localhost:5678/webhook/extract-sitekey
```

---

### Проблема: "Webhook not found"

**Решение**: Активируйте workflow
1. Откройте workflow в n8n
2. Нажмите "Active" (переключатель в правом верхнем углу)

---

## 📝 Параметры API

| Параметр | Тип | Обязателен | По умолчанию | Описание |
|----------|-----|------------|--------------|----------|
| `url` | String | Да | - | URL страницы для извлечения sitekey |
| `waitTime` | Number | Нет | 3000 | Время ожидания загрузки капчи (мс) |

---

## 🎯 Типичный workflow

```
1. Вызвать API извлечения sitekey
   ↓
2. Получить websiteKey
   ↓
3. Отправить в RuCaptcha API
   ↓
4. Получить token
   ↓
5. Использовать token на сайте
```

---

## 💡 Pro Tips

### Tip 1: Кэширование

Sitekey редко меняется. Кэшируйте на 24 часа:

```python
import redis
import json

r = redis.Redis()
cache_key = f"sitekey:claude.ai"

# Проверить кэш
cached = r.get(cache_key)
if cached:
    sitekey = json.loads(cached)['websiteKey']
else:
    # Извлечь и сохранить
    response = requests.post(...)
    r.setex(cache_key, 86400, response.text)
```

---

### Tip 2: Обработка ошибок

```python
response = requests.post(...)
data = response.json()

if not data['success']:
    print(f"Ошибка: {data['error']}")
    # Retry с большим waitTime
    response = requests.post(
        ...,
        json={'url': url, 'waitTime': 10000}
    )
```

---

### Tip 3: Webhook на внешнем сервере

Если n8n на сервере 93.189.230.57:

```bash
# Открыть порт 5678
ufw allow 5678/tcp

# Использовать внешний IP
curl -X POST http://93.189.230.57:5678/webhook/extract-sitekey \
  -d '{"url": "https://claude.ai/new"}'
```

---

## ✅ Чек-лист готовности

- [ ] n8n установлен и запущен
- [ ] Workflow импортирован
- [ ] Workflow активирован (Active = ON)
- [ ] Puppeteer работает (test-puppeteer.js выполнен)
- [ ] Chromium установлен
- [ ] Webhook доступен (curl тест выполнен)
- [ ] RuCaptcha API ключ получен (если нужен)

---

## 🎉 Готово!

Теперь вы можете:

1. **Автоматически извлекать sitekey** с любого сайта
2. **Интегрировать с RuCaptcha API** для решения капчи
3. **Использовать через HTTP API** в любом языке программирования
4. **Обходить Cloudflare Turnstile** без ручного ввода

---

**Полная документация**: `CLOUDFLARE_TURNSTILE_EXTRACTION_GUIDE.md`

**Вопросы?** Проверьте troubleshooting раздел или документацию!

**Успехов в автоматизации! 🚀**
