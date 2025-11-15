# 🎭 n8n-nodes-puppeteer - Готовое решение для Claude.AI

## ✅ Преимущества n8n-nodes-puppeteer

**n8n-nodes-puppeteer** - это community node, который предоставляет готовую интеграцию Puppeteer прямо в n8n UI!

### Плюсы:
- ✅ **Визуальный интерфейс** - настройка через UI, не нужно писать код
- ✅ **Готовые ноды** - для каждого действия отдельная нода
- ✅ **Проще отлаживать** - видно каждый шаг в workflow
- ✅ **Переиспользуемость** - скопируйте ноды в другие workflows
- ✅ **Community support** - активная поддержка сообщества

### Минусы:
- ⚠️ Требует установки community node
- ⚠️ Больше нод в workflow (10 вместо 6)

## 🚀 Установка

### Шаг 1: Установка n8n-nodes-puppeteer

```bash
# В директории проекта
npm install n8n-nodes-puppeteer

# Или глобально (если n8n установлен глобально)
npm install -g n8n-nodes-puppeteer
```

### Шаг 2: Перезапуск n8n

```bash
# Перезапустите n8n чтобы загрузить community node
pkill -f n8n
n8n start

# Или в Docker
docker-compose restart
```

### Шаг 3: Импорт workflow

**URL для импорта:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json
```

## 📋 Структура workflow

```
Manual Trigger
    ↓
Set Credentials
    ↓
Puppeteer - Navigate (claude.ai/new)
    ↓
Puppeteer - Set Cookies (sessionKey, __cf_bm)
    ↓
Puppeteer - Wait Input (ждем поле ввода)
    ↓
Puppeteer - Type Prompt (вводим текст)
    ↓
Puppeteer - Submit (отправляем)
    ↓
Puppeteer - Wait Response (ждем ответ)
    ↓
Puppeteer - Extract Response (извлекаем текст)
    ↓
Format Result (форматируем JSON)
```

**Всего: 10 нод**

## ⚙️ Настройка credentials

После импорта:

1. Откройте ноду **"Set Credentials"**
2. Измените значения:
   ```
   sessionKey: YOUR_SESSION_KEY_HERE → ваш ключ
   cfBmCookie: YOUR_CF_BM_COOKIE_HERE → ваш cookie
   prompt: можно изменить дефолтный промпт
   ```
3. Save

## 🧪 Тестирование

1. Нажмите на **"Manual Trigger"**
2. **Execute Node**
3. Наблюдайте выполнение каждой ноды
4. Результат появится в **"Format Result"**

## 🔧 Настройка отдельных нод

### Puppeteer - Navigate
```
URL: https://claude.ai/new
Wait Until: networkidle2
Timeout: 30000
```

### Puppeteer - Set Cookies
```javascript
Cookies: [
  {
    name: 'sessionKey',
    value: {{ $('Set Credentials').item.json.sessionKey }},
    domain: '.claude.ai',
    httpOnly: true,
    secure: true
  },
  {
    name: '__cf_bm',
    value: {{ $('Set Credentials').item.json.cfBmCookie }},
    domain: '.claude.ai',
    httpOnly: true,
    secure: true
  }
]
```

### Puppeteer - Wait Input
```
Selector: div[contenteditable="true"]
Timeout: 10000
```

### Puppeteer - Type Prompt
```
Selector: div[contenteditable="true"]
Text: {{ $('Set Credentials').item.json.prompt }}
Delay: 50
```

### Puppeteer - Submit
```
Selector: button[aria-label="Send Message"], button[type="submit"]
Action: click
```

### Puppeteer - Wait Response
```javascript
Function: () => document.querySelectorAll('[data-testid="message"]').length >= 2
Timeout: 60000
```

### Puppeteer - Extract Response
```javascript
Function: () => {
  const messages = document.querySelectorAll('[data-testid="message"]');
  if (messages.length < 2) return null;
  const lastMessage = messages[messages.length - 1];
  return lastMessage.innerText || lastMessage.textContent;
}
```

## 🎯 Добавление Webhook

Чтобы сделать workflow доступным через API:

1. Добавьте ноду **Webhook** перед "Set Credentials"
2. Настройте:
   ```
   Path: claude-automation
   Method: POST
   ```
3. В ноде "Set Credentials" замените значения на:
   ```javascript
   prompt: {{ $json.body.prompt || "Привет!" }}
   sessionKey: {{ $json.body.sessionKey || "YOUR_DEFAULT" }}
   cfBmCookie: {{ $json.body.cfBmCookie || "YOUR_DEFAULT" }}
   ```
4. Добавьте **Respond to Webhook** в конце

## 📊 Сравнение подходов

| Подход | Нод | Код | Отладка | Сложность |
|--------|-----|-----|---------|-----------|
| **n8n-nodes-puppeteer** | 10 | Нет | Легко | ⭐ Простая |
| **Code node (FULL READY)** | 6 | Да | Средне | ⭐⭐ Средняя |
| **FULL (Extract Params)** | 8 | Да | Сложно | ⭐⭐⭐ Сложная |

## 🛠️ Troubleshooting

### Ошибка: "Puppeteer node not found"

```bash
# Убедитесь что n8n-nodes-puppeteer установлен
npm list n8n-nodes-puppeteer

# Если нет - установите
npm install n8n-nodes-puppeteer

# Перезапустите n8n
```

### Ошибка: "Browser not found"

n8n-nodes-puppeteer использует системный Chromium. Установите:

```bash
# Ubuntu/Debian
apt-get install chromium-browser

# macOS
brew install chromium

# Или укажите путь к Chrome в настройках n8n
```

### Ошибка: "Selector not found"

Claude.ai изменил интерфейс. Обновите селекторы в нодах:
1. Откройте claude.ai в браузере
2. DevTools → Elements
3. Найдите правильные селекторы
4. Обновите в workflow

## 💡 Советы

### 1. Модульность

Каждая нода делает одно действие - легко модифицировать отдельные шаги

### 2. Переиспользование

Скопируйте готовые ноды в другие workflows:
- Navigate → для других сайтов
- Set Cookies → для других аутентификаций
- Extract Response → для других данных

### 3. Отладка

Выполняйте по одной ноде за раз для отладки:
1. Выберите ноду
2. Execute Node
3. Проверьте результат
4. Переходите к следующей

### 4. Screenshot на ошибке

Добавьте ноду "Puppeteer - Screenshot" после проблемной ноды для отладки

## 🔄 Обновление credentials

Когда куки устареют:

1. Получите новые из браузера
2. Откройте ноду "Set Credentials"
3. Обновите значения
4. Save

Или используйте n8n Credentials для автоматической ротации.

## 🌟 Расширения

### Добавьте обработку ошибок:

```
Puppeteer - Extract Response
    ↓
IF (проверка успеха)
    ├─→ Success → Format Result
    └─→ Error → Error Handler
```

### Добавьте retry логику:

```
Puppeteer - Wait Response
    ↓
IF (timeout)
    ├─→ Success → Continue
    └─→ Error → Wait → Retry (loop back)
```

### Добавьте кэширование:

```
Set Credentials
    ↓
Check Cache (database/redis)
    ├─→ Hit → Return cached
    └─→ Miss → Puppeteer workflow → Save to cache
```

## 📚 Дополнительные ресурсы

- [n8n-nodes-puppeteer на GitHub](https://github.com/drudge/n8n-nodes-puppeteer)
- [n8n Community Nodes](https://docs.n8n.io/integrations/community-nodes/)
- [Puppeteer Documentation](https://pptr.dev/)

---

**Готово! Используйте n8n-nodes-puppeteer для упрощенной работы с Claude.AI через визуальный интерфейс!** 🚀
