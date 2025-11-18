# 🔧 Решение проблемы: "Unrecognized node type: n8n-nodes-base.puppeteer"

## Проблема

При импорте workflow вы получаете ошибку:
```
Unrecognized node type: n8n-nodes-base.puppeteer
```

Это означает, что в вашем инстансе n8n отсутствует нода Puppeteer.

---

## ✅ Решение: Используйте версию без Puppeteer ноды

Мы создали альтернативную версию workflow, которая использует только **стандартные ноды n8n** (HTTP Request + Code) и работает напрямую с Browserless API.

### 🔗 Импорт альтернативной версии:

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-http-api.json
```

### Webhook URL:
```
https://jejopeguki.beget.app/webhook/ai-studio-http
```

### Быстрый тест:
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-http \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи о квантовых компьютерах",
    "browserlessUrl": "http://localhost:3000"
  }'
```

---

## 📋 Сравнение версий

| Версия | Использует | Требования | Рекомендуется для |
|--------|-----------|------------|-------------------|
| **HTTP API** ✅ | HTTP Request + Code | Только стандартные ноды n8n | **Большинство пользователей** |
| Базовая | Puppeteer ноды | Puppeteer нода установлена | Если нода доступна |
| Продвинутая | Puppeteer ноды + Code | Puppeteer нода установлена | Если нода доступна |

---

## 🔍 Как работает HTTP API версия

Вместо использования Puppeteer нод, эта версия:

1. **Code нода** создает Puppeteer скрипт в виде JavaScript кода
2. **HTTP Request** отправляет скрипт в Browserless `/function` endpoint
3. **Browserless** выполняет скрипт и возвращает результат
4. **Set нода** форматирует ответ

### Преимущества HTTP API версии:
- ✅ Работает на любом n8n инстансе
- ✅ Не требует дополнительных нод
- ✅ Та же функциональность
- ✅ Полный контроль через код

---

## 🛠️ Установка Puppeteer ноды (опционально)

Если вы хотите использовать оригинальные версии с Puppeteer нодами, установите ноду:

### Вариант 1: Через n8n Community Nodes (если доступно)

1. Откройте n8n
2. **Settings → Community Nodes**
3. Найдите `n8n-nodes-puppeteer`
4. Нажмите **Install**

### Вариант 2: Через npm (self-hosted)

```bash
# Перейдите в директорию n8n
cd ~/.n8n

# Установите Puppeteer ноду
npm install n8n-nodes-puppeteer

# Перезапустите n8n
# Если через systemd
sudo systemctl restart n8n

# Если через pm2
pm2 restart n8n

# Если через docker
docker restart n8n
```

### Вариант 3: Docker с Puppeteer

Используйте Docker образ с предустановленными инструментами:

```dockerfile
FROM n8nio/n8n:latest

USER root

# Установка зависимостей для Puppeteer
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

# Установка Puppeteer ноды
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install n8n-nodes-puppeteer

USER node

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
```

---

## 📦 Доступные версии workflows

### 1. **HTTP API версия** (Рекомендуется - Работает везде)
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-http-api.json
```

**Webhook:** `/webhook/ai-studio-http`

**Использует:**
- ✅ HTTP Request
- ✅ Code
- ✅ Set
- ✅ If

**Требует:** Только Browserless

---

### 2. Базовая версия (Требует Puppeteer ноду)
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-automation.json
```

**Webhook:** `/webhook/ai-studio-automation`

**Использует:**
- ⚠️ Puppeteer ноды
- ✅ Set

**Требует:** Browserless + Puppeteer нода

---

### 3. Продвинутая версия (Требует Puppeteer ноду)
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-advanced.json
```

**Webhook:** `/webhook/ai-studio-advanced`

**Использует:**
- ⚠️ Puppeteer ноды
- ✅ Code
- ✅ Set
- ✅ If

**Требует:** Browserless + Puppeteer нода

---

## 🚀 Рекомендации

### Для большинства пользователей:
👉 **Используйте HTTP API версию** - она работает на любом n8n инстансе без дополнительных нод.

### Если Puppeteer нода уже установлена:
👉 Можете использовать любую версию, включая продвинутую с дополнительными функциями.

---

## 💡 Параметры для HTTP API версии

```json
{
  "prompt": "Ваш запрос к AI",
  "browserlessUrl": "http://localhost:3000",
  "timeout": 90000
}
```

### Параметры:

| Параметр | Тип | По умолчанию | Описание |
|----------|-----|--------------|----------|
| `prompt` | string | *обязательный* | Текст запроса |
| `browserlessUrl` | string | `http://localhost:3000` | URL Browserless |
| `timeout` | number | `90000` | Timeout в миллисекундах |

---

## 📊 Примеры использования HTTP API версии

### Базовый запрос:
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-http \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи о последних новостях в AI"
  }'
```

### С кастомным Browserless:
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-http \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай план статьи о нейросетях",
    "browserlessUrl": "http://my-browserless:3000",
    "timeout": 120000
  }'
```

### Python пример:
```python
import requests

url = "https://jejopeguki.beget.app/webhook/ai-studio-http"
payload = {
    "prompt": "Расскажи о квантовых компьютерах",
    "browserlessUrl": "http://localhost:3000",
    "timeout": 90000
}

response = requests.post(url, json=payload, timeout=180)
data = response.json()

if data.get('success'):
    print(f"Response: {data['response']}")
    print(f"Request ID: {data['request_id']}")
else:
    print(f"Error: {data.get('error')}")
```

### JavaScript пример:
```javascript
async function askAI(prompt) {
  const url = 'https://jejopeguki.beget.app/webhook/ai-studio-http';

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      prompt: prompt,
      browserlessUrl: 'http://localhost:3000'
    })
  });

  const data = await response.json();

  if (data.success) {
    console.log('Response:', data.response);
    return data;
  } else {
    console.error('Error:', data.error);
    return null;
  }
}

askAI('Расскажи о квантовых компьютерах');
```

---

## 🔍 Дебаг и диагностика

### Проверка Browserless:
```bash
curl http://localhost:3000/
```

### Проверка /function endpoint:
```bash
curl -X POST http://localhost:3000/function \
  -H "Content-Type: application/json" \
  -d '{
    "code": "module.exports = async ({ page }) => { return { test: true }; }"
  }'
```

### Проверка workflow:
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-http \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"}' \
  -v
```

---

## 🆘 Частые проблемы

### 1. "Connection refused" к Browserless
**Решение:**
- Проверьте что Browserless запущен: `docker ps | grep browserless`
- Проверьте URL в параметрах workflow
- Если Browserless в Docker, используйте правильный network

### 2. Timeout при выполнении
**Решение:**
- Увеличьте timeout параметр (по умолчанию 90 секунд)
- Проверьте скорость интернета
- Проверьте что Google AI Studio доступен

### 3. "Response not found"
**Решение:**
- Google AI Studio может изменить интерфейс
- Проверьте скриншот в ответе для диагностики
- Обновите селекторы в Code ноде

---

## 📞 Поддержка

Если проблема сохраняется:
1. Проверьте логи n8n
2. Проверьте логи Browserless
3. Попробуйте HTTP API версию workflow
4. Создайте issue с деталями ошибки

---

**Обновлено:** 2025-11-18
**Версия:** 1.0.0
**Рекомендуемый workflow:** HTTP API версия (без Puppeteer ноды)
