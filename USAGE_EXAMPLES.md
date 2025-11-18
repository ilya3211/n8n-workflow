# 🚀 Готовые примеры использования для jejopeguki.beget.app

## 📍 Ваш n8n инстанс
**URL:** https://jejopeguki.beget.app/

---

## 🔷 Базовая версия - Примеры запросов

### Webhook URL:
```
https://jejopeguki.beget.app/webhook/ai-studio-automation
```

### Пример 1: Простой запрос
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи о квантовых компьютерах простым языком"
  }'
```

### Пример 2: С настройками модели
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай краткий план статьи о нейросетях",
    "model": "gemini-pro",
    "maxTokens": 2048
  }'
```

### JavaScript пример:
```javascript
fetch('https://jejopeguki.beget.app/webhook/ai-studio-automation', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    prompt: 'Расскажи о квантовых компьютерах простым языком'
  })
})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('Error:', error));
```

### Python пример:
```python
import requests

url = "https://jejopeguki.beget.app/webhook/ai-studio-automation"
payload = {
    "prompt": "Расскажи о квантовых компьютерах простым языком"
}

response = requests.post(url, json=payload)
print(response.json())
```

---

## 🔶 Продвинутая версия - Примеры запросов

### Webhook URL:
```
https://jejopeguki.beget.app/webhook/ai-studio-advanced
```

### Пример 1: Полный запрос со всеми параметрами
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай детальный план статьи о машинном обучении",
    "model": "gemini-2.0-flash-exp",
    "temperature": 0.7,
    "maxTokens": 4096,
    "useAuthentication": true,
    "saveHistory": true
  }'
```

### Пример 2: Творческая генерация (высокая температура)
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Напиши креативную историю о роботе",
    "model": "gemini-2.0-flash-exp",
    "temperature": 0.9,
    "maxTokens": 8192,
    "saveHistory": true
  }'
```

### Пример 3: Точные ответы (низкая температура)
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Дай точное определение квантовой запутанности",
    "model": "gemini-pro",
    "temperature": 0.1,
    "maxTokens": 2048
  }'
```

### JavaScript пример (продвинутый):
```javascript
async function askGoogleAI(prompt, options = {}) {
  const url = 'https://jejopeguki.beget.app/webhook/ai-studio-advanced';

  const payload = {
    prompt: prompt,
    model: options.model || 'gemini-2.0-flash-exp',
    temperature: options.temperature || 0.7,
    maxTokens: options.maxTokens || 4096,
    saveHistory: options.saveHistory !== false
  };

  try {
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(payload)
    });

    const data = await response.json();

    if (data.success) {
      console.log('Response:', data.response);
      console.log('Request ID:', data.request_id);
      return data;
    } else {
      console.error('Error:', data.error);
      return null;
    }
  } catch (error) {
    console.error('Request failed:', error);
    return null;
  }
}

// Использование
askGoogleAI('Расскажи о последних новостях в AI', {
  temperature: 0.7,
  maxTokens: 4096
});
```

### Python пример (продвинутый):
```python
import requests
import json

def ask_google_ai(prompt, model='gemini-2.0-flash-exp', temperature=0.7, max_tokens=4096):
    url = "https://jejopeguki.beget.app/webhook/ai-studio-advanced"

    payload = {
        "prompt": prompt,
        "model": model,
        "temperature": temperature,
        "maxTokens": max_tokens,
        "saveHistory": True
    }

    try:
        response = requests.post(url, json=payload, timeout=120)
        response.raise_for_status()

        data = response.json()

        if data.get('success'):
            print(f"Response: {data['response']}")
            print(f"Request ID: {data['request_id']}")
            print(f"Timestamp: {data['timestamp']}")
            return data
        else:
            print(f"Error: {data.get('error')}")
            return None

    except requests.exceptions.RequestException as e:
        print(f"Request failed: {e}")
        return None

# Использование
result = ask_google_ai(
    prompt="Создай план статьи о нейросетях",
    temperature=0.7,
    max_tokens=4096
)
```

---

## 📊 Формат ответа

### Success Response:
```json
{
  "success": true,
  "response": "Текст ответа от AI...",
  "request_id": "1234567890-abc123",
  "timestamp": "2025-11-18T12:00:00.000Z",
  "metadata": {
    "prompt": "Ваш запрос",
    "model": "gemini-2.0-flash-exp",
    "temperature": 0.7,
    "maxTokens": 4096
  },
  "screenshot_base64": "iVBORw0KGgoAAAANS...",
  "automation_method": "browserless-puppeteer"
}
```

### Error Response:
```json
{
  "success": false,
  "error": "Описание ошибки",
  "error_stack": "Стек ошибки...",
  "request_id": "1234567890-abc123",
  "timestamp": "2025-11-18T12:00:00.000Z"
}
```

---

## 🔧 Примеры использования в различных сценариях

### 1. Анализ текста
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Проанализируй следующий текст и выдели ключевые моменты: [ваш текст]",
    "temperature": 0.3,
    "maxTokens": 2048
  }'
```

### 2. Генерация контента
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Напиши пост для соцсетей о преимуществах AI",
    "temperature": 0.8,
    "maxTokens": 1024
  }'
```

### 3. Техническая документация
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай техническую документацию для API endpoint",
    "temperature": 0.2,
    "maxTokens": 4096
  }'
```

### 4. Перевод и локализация
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Переведи следующий текст на английский, сохраняя стиль: [текст]",
    "temperature": 0.3,
    "maxTokens": 2048
  }'
```

---

## 🔐 Безопасность

### Рекомендации:
1. **Не передавайте** API ключи и секреты в промптах
2. **Используйте HTTPS** для всех запросов (уже настроено)
3. **Настройте IP whitelist** в n8n для ограничения доступа
4. **Мониторьте** использование через логи n8n
5. **Установите rate limiting** если нужно

### Пример с аутентификацией (если настроена):
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{
    "prompt": "Ваш запрос"
  }'
```

---

## 📈 Мониторинг и отладка

### Проверка доступности:
```bash
curl -I https://jejopeguki.beget.app/
```

### Тест базового workflow:
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"}' \
  -v
```

### Проверка времени ответа:
```bash
time curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет, это тест"
  }'
```

---

## 💡 Полезные советы

1. **Temperature:**
   - `0.0-0.3` - Точные, фактические ответы
   - `0.4-0.7` - Сбалансированные ответы (рекомендуется)
   - `0.8-1.0` - Креативные, разнообразные ответы

2. **MaxTokens:**
   - `512-1024` - Короткие ответы
   - `2048-4096` - Средние ответы (рекомендуется)
   - `4096-8192` - Длинные детальные ответы

3. **Models:**
   - `gemini-pro` - Стабильная версия
   - `gemini-2.0-flash-exp` - Быстрая экспериментальная

---

## 🆘 Troubleshooting

### Проблема: Timeout
```bash
# Увеличьте timeout в curl
curl --max-time 180 -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{"prompt": "ваш запрос"}'
```

### Проблема: Connection refused
- Проверьте что n8n запущен
- Проверьте что workflow активирован
- Проверьте URL webhook в n8n

### Проблема: 502 Bad Gateway
- Проверьте что Browserless запущен
- Проверьте credentials в n8n
- Проверьте логи n8n

---

**Обновлено:** 2025-11-18
**Домен:** https://jejopeguki.beget.app/
**Версия workflows:** 1.0.0
