# 🌐 Browserless HTTP API - БЕЗ Puppeteer!

## ✅ Самое простое решение!

Этот метод использует Browserless HTTP API вместо локального Puppeteer. **Никаких зависимостей!**

### Преимущества HTTP API:

| Критерий | HTTP API | Puppeteer + Browserless |
|----------|----------|------------------------|
| **Установка Puppeteer** | ✅ НЕ НУЖНА | ❌ Требуется |
| **Установка Chrome** | ✅ НЕ НУЖНА | ✅ НЕ НУЖНА |
| **Зависимости** | 0️⃣ Ноль | 📦 npm install |
| **Работает в n8n** | ✅ Из коробки | ⚠️ Нужна настройка |
| **Скорость** | ⚡ 3-8 сек | ⚡ 3-8 сек |
| **Сложность** | ⭐ Простая | ⭐⭐ Средняя |

---

## 🚀 Быстрый старт

### 1. Импорт workflow

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-http-api.json
```

**Шаги:**
1. n8n → Workflows → "+" → **Import from URL**
2. Вставьте URL выше
3. Import → Workflow загружен ✅

### 2. Настройка credentials

Откройте ноду **"Set Credentials"** → Edit

**Замените 2 значения:**

```javascript
sessionKey: YOUR_SESSION_KEY_HERE
cfBmCookie: YOUR_CF_BM_COOKIE_HERE
```

**Вставьте ваши данные:**

```javascript
sessionKey: sk-ant-sid01-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
cfBmCookie: YOUR_CF_BM_COOKIE_VALUE_HERE
```

### 3. Готово!

**Никаких установок!** Просто:
1. Execute Workflow → Test!
2. Готово ✅

---

## 🔧 Как это работает?

### Архитектура

```
n8n → HTTP Request → Browserless API → Cloud Browser → Claude.AI → Response → n8n
```

### Код выполняется на стороне Browserless

Ваш n8n отправляет JavaScript код на Browserless через HTTP POST:

```javascript
POST https://chrome.browserless.io/function?token=YOUR_TOKEN
Content-Type: application/json

{
  "code": "module.exports = async ({ page }) => { ... }",
  "context": {}
}
```

Browserless:
1. Получает код
2. Запускает Chrome в облаке
3. Выполняет ваш код
4. Возвращает результат

**Результат:** Вам не нужен ни Chrome, ни Puppeteer локально!

---

## 📊 Структура workflow

### 4 ноды:

1. **Manual Trigger** - запуск вручную
2. **Set Credentials** - ваши credentials
   - `browserlessToken` (уже настроен!)
   - `sessionKey` (замените на ваш)
   - `cfBmCookie` (замените на ваш)
   - `userPrompt` (текст запроса)

3. **Browserless Function** - HTTP Request к Browserless API
   - URL: `https://chrome.browserless.io/function?token=...`
   - Body: JavaScript код для браузера
   - Timeout: 180 секунд (3 минуты)

4. **Format Result** - форматирование ответа
   - `status`: ✅ Success или ⚠️ Partial
   - `prompt`: ваш запрос
   - `response`: ответ Claude
   - `timestamp`: время выполнения

---

## 🎯 Примеры использования

### Простой запрос

```javascript
// Input:
{
  "prompt": "Напиши стих про n8n"
}

// Output:
{
  "status": "✅ Success",
  "prompt": "Напиши стих про n8n",
  "response": "В мире автоматизации n8n...",
  "timestamp": "2024-01-15T10:30:00.000Z",
  "browser": "Browserless HTTP API"
}
```

### Через Webhook

Замените **Manual Trigger** на **Webhook**:

```bash
curl -X POST https://your-n8n.com/webhook/claude \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Объясни квантовую физику простыми словами"
  }'
```

### Через Schedule (крон)

Замените **Manual Trigger** на **Schedule**:

```
Cron: 0 9 * * *  # Каждый день в 9:00

Prompt: "Создай мотивационный пост для LinkedIn про AI"
```

---

## 🆚 Сравнение: HTTP API vs Puppeteer

### Когда использовать HTTP API (этот workflow):
✅ Вы не можете установить Puppeteer
✅ Нужна простота - 0 зависимостей
✅ n8n в облаке (без доступа к npm install)
✅ Быстрый старт за 1 минуту
✅ Стандартные задачи (текст, скриншоты)

### Когда использовать Puppeteer + Browserless:
✅ Нужен полный контроль над браузером
✅ Сложная логика (циклы, условия)
✅ Доступ к большему API Puppeteer
✅ Локальная отладка
✅ Интеграция с другими библиотеками

**Рекомендация:** Начните с HTTP API (проще), переходите на Puppeteer только если нужны продвинутые функции.

---

## 🔧 Продвинутая настройка

### Добавление скриншотов

Измените код в ноде **Browserless Function**:

```javascript
// Добавьте перед return:
const screenshot = await page.screenshot({ encoding: 'base64' });

return {
  success: true,
  response: response,
  screenshot: screenshot,  // Base64 изображение
  timestamp: new Date().toISOString()
};
```

### Изменение timeout

В ноде **Browserless Function** → Options:

```json
{
  "timeout": 300000  // 5 минут
}
```

### Добавление контекста

Browserless поддерживает передачу данных через `context`:

```json
{
  "code": "module.exports = async ({ page, context }) => { ... }",
  "context": {
    "apiKey": "xxx",
    "userData": { ... }
  }
}
```

### Headful mode (видимый браузер)

Добавьте параметр в URL:

```
https://chrome.browserless.io/function?token=XXX&headless=false
```

### Запись видео

Browserless может записывать видео выполнения:

```
https://chrome.browserless.io/function?token=XXX&record=true
```

Видео будет в ответе как base64.

---

## 🐛 Troubleshooting

### Error: "Invalid token"

```
Проверьте токен в ноде "Set Credentials":
browserlessToken: 2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac
```

### Error: "Timeout"

```javascript
// Увеличьте timeout в HTTP Request ноде:
Options → Timeout: 300000  // 5 минут
```

### Error: "Selector not found"

```
Claude.ai изменил интерфейс. Обновите селекторы:

Старый: div[contenteditable="true"]
Новый: textarea[placeholder="Message Claude"]  // пример
```

### Cookies не работают

```javascript
// Проверьте формат cookies в Set Credentials:
sessionKey: sk-ant-sid01-XXXXX  // Должен начинаться с sk-ant-sid01-
cfBmCookie: XXXXX               // Длинная строка из браузера
```

### Response пустой

```javascript
// Увеличьте время ожидания в waitForFunction:
{ timeout: 180000 }  // 3 минуты вместо 2
```

---

## 💡 Best Practices

### 1. Environment Variables

Не храните credentials в workflow. Используйте n8n environment variables:

```javascript
// В Set Credentials ноде:
sessionKey: {{ $env.CLAUDE_SESSION_KEY }}
cfBmCookie: {{ $env.CLAUDE_CF_BM }}
```

### 2. Error Handling

Добавьте Error Trigger:

```
Browserless Function → Error → Send Notification
```

### 3. Retry Logic

В HTTP Request ноде включите retry:

```json
{
  "retry": {
    "maxTries": 3,
    "waitTime": 2000
  }
}
```

### 4. Rate Limiting

Browserless имеет лимиты. Добавьте задержку между запросами:

```
Schedule → Wait 5sec → Browserless Function
```

### 5. Мониторинг

Логируйте метрики:

```javascript
{
  "timestamp": new Date().toISOString(),
  "duration": Date.now() - startTime,
  "success": true,
  "response_length": response.length
}
```

---

## 📈 Стоимость

### Browserless тарифы:

| План | Цена/мес | Минут | Запросов (~) |
|------|----------|-------|-------------|
| Hobby | $29 | 6,000 | 12,000-36,000 |
| Startup | $99 | 25,000 | 50,000-150,000 |
| Business | $299 | 100,000 | 200,000-600,000 |

**Расчет:**
- 1 запрос к Claude ≈ 10-30 секунд
- $29/мес = 6000 минут = ~18,000 запросов
- **$0.0016 за запрос** 💚

---

## 🆚 Сравнение всех методов

| Метод | Скорость | Стоимость | Сложность | Зависимости |
|-------|----------|-----------|-----------|-------------|
| **Browserless HTTP API** | ⭐⭐⭐⭐ | $ | ⭐ | 0️⃣ |
| Browserless + Puppeteer | ⭐⭐⭐⭐ | $ | ⭐⭐ | npm |
| Claude API | ⭐⭐⭐⭐⭐ | $$ | ⭐ | 0️⃣ |
| Локальный Chrome | ⭐⭐⭐ | Free | ⭐⭐⭐ | Chrome + npm |

---

## 🎓 Дополнительные ресурсы

- [Browserless Function API Docs](https://docs.browserless.io/docs/function)
- [Browserless Examples](https://github.com/browserless/chrome/tree/master/examples)
- [n8n HTTP Request Docs](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.httprequest/)

---

## ✅ Чеклист запуска

- [ ] Workflow импортирован из URL
- [ ] Browserless токен настроен (уже готов!)
- [ ] Claude credentials добавлены (sessionKey, cfBmCookie)
- [ ] Тестовый запрос выполнен
- [ ] Ответ получен успешно
- [ ] Error handling настроен
- [ ] Интеграция работает

---

## 🎉 Готово!

**Самое простое решение для Claude + n8n!**

### Преимущества:
- ✅ **0 зависимостей** - не нужен Puppeteer
- ✅ **0 установок** - работает сразу
- ✅ **Облачный браузер** - ничего локально
- ✅ **HTTP API** - стандартная n8n нода
- ✅ **2 минуты** - от импорта до работы

### Время на настройку: 2 минуты! ⚡

```bash
# Импортируйте:
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-http-api.json

# Добавьте credentials → Execute → Готово! ✅
```
