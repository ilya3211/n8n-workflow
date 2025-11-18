# 🌐 Browserless + Puppeteer для Claude.AI

## ✅ Идеальное решение без локального Chrome!

Browserless - это облачный сервис для запуска браузеров. Puppeteer подключается к удаленному браузеру через WebSocket.

### Преимущества:

| Критерий | Browserless | Локальный Chrome | Claude API |
|----------|-------------|------------------|------------|
| **Установка Chrome** | ✅ Не нужна | ❌ Обязательна | ✅ Не нужна |
| **Работает везде** | ✅ Да | ⚠️ Нужны ресурсы | ✅ Да |
| **Cookies/Sessions** | ✅ Да | ✅ Да | ❌ Только API ключ |
| **Скорость** | ⚡⚡ 3-8 сек | ⚡⚡ 10-30 сек | ⚡⚡⚡ 1-3 сек |
| **Стоимость** | $ ~$50/мес | 💚 Бесплатно | $$ Pay-as-go |
| **Надежность** | ✅ 99.9% | ⚠️ Зависит | ✅ 99.9% |

## 🚀 Быстрый старт

### 1. Импорт workflow

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-automation.json
```

**Шаги:**
1. n8n → Workflows → "+" → **Import from URL**
2. Вставьте URL выше
3. Import → Workflow загружен ✅

### 2. Настройка credentials

Откройте ноду **"Claude via Browserless"** → Edit

**Замените 3 значения:**

```javascript
// Строка 7 - уже установлен ваш токен:
const BROWSERLESS_TOKEN = '2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac';

// Строка 8 - ваш sessionKey от Claude:
const SESSION_KEY = 'YOUR_SESSION_KEY_HERE';

// Строка 9 - ваш __cf_bm cookie от Claude:
const CF_BM_COOKIE = 'YOUR_CF_BM_COOKIE_HERE';
```

### 3. Установка Puppeteer (если еще не установлен)

```bash
cd /home/user/n8n-workflow
npm install puppeteer
```

**Важно:** При использовании Browserless Chromium не скачивается локально! Используйте:

```bash
PUPPETEER_SKIP_DOWNLOAD=true npm install puppeteer
```

### 4. Тест

1. Нажмите **"Execute Workflow"**
2. Workflow подключится к Browserless
3. Откроет Claude.ai через удаленный браузер
4. Отправит prompt и получит ответ
5. Результат появится в выводе

## 📊 Browserless тарифы

### Ваш токен (проверьте на https://www.browserless.io/):

```
2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac
```

### Популярные планы:

| План | Цена/мес | Concurrent sessions | Минут/мес | Лучше для |
|------|----------|-------------------|-----------|-----------|
| **Hobby** | $29 | 2 | 6,000 | Тесты, прототипы |
| **Startup** | $99 | 5 | 25,000 | Малый бизнес |
| **Business** | $299 | 10 | 100,000 | Средний бизнес |
| **Enterprise** | Custom | Unlimited | Unlimited | Большие проекты |

**Рассчитать стоимость:**
- 1 запрос к Claude ≈ 10-30 секунд
- 6000 минут = 12,000-36,000 запросов/месяц
- $29/мес ≈ $0.001 за запрос

## 🔧 Продвинутая настройка

### Timeout и retry

```javascript
browser = await puppeteer.connect({
  browserWSEndpoint: `wss://chrome.browserless.io?token=${BROWSERLESS_TOKEN}`,
  timeout: 60000, // 60 секунд на подключение
  slowMo: 50      // Замедление для стабильности
});
```

### Скриншоты для дебага

```javascript
// После получения ответа:
const screenshot = await page.screenshot({ encoding: 'base64' });

return [{
  json: {
    response: response,
    screenshot: screenshot  // Base64 изображение
  }
}];
```

### Headful mode (видимый браузер)

```javascript
// Browserless поддерживает headful:
const browser = await puppeteer.connect({
  browserWSEndpoint: `wss://chrome.browserless.io?token=${BROWSERLESS_TOKEN}&headless=false`
});
```

### Stealth mode (обход детекции)

```javascript
// Добавьте puppeteer-extra для stealth:
const puppeteer = require('puppeteer-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');
puppeteer.use(StealthPlugin());

// Затем подключитесь к Browserless
const browser = await puppeteer.connect({...});
```

### Proxy через Browserless

```javascript
// Browserless поддерживает proxy:
const browser = await puppeteer.connect({
  browserWSEndpoint: `wss://chrome.browserless.io?token=${BROWSERLESS_TOKEN}&--proxy-server=http://proxy:8080`
});
```

### Custom User Agent

```javascript
await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
```

## 🎯 Use Cases

### 1. Telegram Bot с Claude

```
Telegram Webhook → n8n → Browserless + Claude → Telegram Response
```

```javascript
// Input от Telegram:
{
  "prompt": "{{ $json.message.text }}"
}

// Output в Telegram:
{
  "chat_id": "{{ $json.message.chat.id }}",
  "text": "{{ $json.response }}"
}
```

### 2. Slack Bot

```javascript
// Slack slash command → n8n → Browserless → Slack
app.post('/slack/claude', async (req, res) => {
  const prompt = req.body.text;

  // Trigger n8n workflow
  const response = await fetch('https://your-n8n.com/webhook/claude', {
    method: 'POST',
    body: JSON.stringify({ prompt })
  });

  return res.json({
    response_type: 'in_channel',
    text: response.data.response
  });
});
```

### 3. Email Auto-responder

```
Email received → n8n → Browserless + Claude → Send Email
```

```javascript
{
  "prompt": `Ответь на этот email профессионально:

От: {{ $json.from }}
Тема: {{ $json.subject }}
Текст: {{ $json.body }}

Ответь в деловом стиле.`
}
```

### 4. Discord Bot

```javascript
// Discord.js + n8n webhook
client.on('messageCreate', async message => {
  if (message.content.startsWith('!claude ')) {
    const prompt = message.content.slice(8);

    const response = await fetch('https://n8n.com/webhook/claude', {
      method: 'POST',
      body: JSON.stringify({ prompt })
    });

    message.reply(response.response);
  }
});
```

### 5. Scheduled Content Generation

```javascript
// Cron trigger → Browserless → Post to social
Schedule: "0 9 * * *"  // Каждый день в 9:00

{
  "prompt": "Напиши мотивационный пост для LinkedIn про AI. 200 символов."
}

// → Post to LinkedIn API
```

## 🐛 Troubleshooting

### Error: "WebSocket connection failed"

```javascript
// Проверьте токен:
console.log('Token:', BROWSERLESS_TOKEN);

// Проверьте подключение:
curl "https://chrome.browserless.io/json/version?token=YOUR_TOKEN"
```

### Error: "Session limit reached"

```
Превышен лимит concurrent sessions.

Решение:
1. Подождите завершения других сессий
2. Увеличьте план на Browserless
3. Добавьте queue в n8n для последовательного выполнения
```

### Error: "Timeout waiting for selector"

```javascript
// Увеличьте timeout:
await page.waitForSelector('div[contenteditable="true"]', {
  timeout: 30000  // 30 секунд
});

// Или сделайте скриншот для дебага:
await page.screenshot({ path: '/tmp/debug.png' });
```

### Cookies не работают

```javascript
// Проверьте формат cookies:
console.log('Cookies set:', await page.cookies());

// Убедитесь, что домен правильный:
domain: '.claude.ai'  // ✅ С точкой
domain: 'claude.ai'   // ❌ Без точки может не работать
```

### Browserless медленно работает

```javascript
// 1. Используйте региональный endpoint (если доступно):
wss://us-west.browserless.io?token=...

// 2. Отключите загрузку изображений:
await page.setRequestInterception(true);
page.on('request', (req) => {
  if (req.resourceType() === 'image') {
    req.abort();
  } else {
    req.continue();
  }
});

// 3. Используйте waitUntil: 'domcontentloaded' вместо 'networkidle2'
await page.goto(url, { waitUntil: 'domcontentloaded' });
```

## 🔒 Безопасность

### Хранение токенов

**Вариант 1: Environment Variables**

```bash
# .env
BROWSERLESS_TOKEN=2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac
CLAUDE_SESSION_KEY=sk-ant-sid01-...
CLAUDE_CF_BM=...

# В n8n Code node:
const BROWSERLESS_TOKEN = $env.BROWSERLESS_TOKEN;
const SESSION_KEY = $env.CLAUDE_SESSION_KEY;
const CF_BM_COOKIE = $env.CLAUDE_CF_BM;
```

**Вариант 2: n8n Credentials**

1. Settings → Credentials → Create New
2. Type: Generic Credential
3. Add fields: browserless_token, session_key, cf_bm

```javascript
// В Code node:
const credentials = await this.getCredentials('browserlessAuth');
const BROWSERLESS_TOKEN = credentials.browserless_token;
```

**Вариант 3: .gitignore (для локальных файлов)**

```bash
# .gitignore
.env
.env.local
credentials.json
```

### Rotation cookies

```javascript
// Claude cookies имеют ограниченный срок действия
// Автоматическое обновление:

const COOKIES = [
  {
    sessionKey: 'sk-ant-sid01-xxx',
    cf_bm: 'xxx',
    expires: '2024-01-20'
  },
  {
    sessionKey: 'sk-ant-sid01-yyy',
    cf_bm: 'yyy',
    expires: '2024-01-25'
  }
];

// Выбираем валидный cookie:
const validCookie = COOKIES.find(c => new Date(c.expires) > new Date());
```

## 📈 Мониторинг

### Логирование метрик

```javascript
const startTime = Date.now();

// ... ваш код ...

const duration = Date.now() - startTime;

return [{
  json: {
    response: response,
    metrics: {
      duration_ms: duration,
      duration_sec: duration / 1000,
      response_length: response.length,
      timestamp: new Date().toISOString(),
      browserless_session: 'used'
    }
  }
}];
```

### Dashboard для аналитики

```javascript
// Сохраняйте логи в базу данных:
await db.insert('claude_requests', {
  prompt: userPrompt,
  response_length: response.length,
  duration: duration,
  success: true,
  timestamp: new Date()
});

// Затем визуализируйте в Grafana/Metabase:
// - Запросы в день
// - Средняя длительность
// - Success rate
// - Стоимость (по usage)
```

## 🆚 Сравнение всех методов

| Метод | Скорость | Стоимость | Сложность | Надежность | Когда использовать |
|-------|----------|-----------|-----------|------------|-------------------|
| **Claude API** | ⭐⭐⭐⭐⭐ | $$ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Продакшн, высокая нагрузка |
| **Browserless** | ⭐⭐⭐⭐ | $ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Нет Chrome локально, нужны cookies |
| **Локальный Chrome** | ⭐⭐⭐ | Free | ⭐⭐ | ⭐⭐⭐ | Есть ресурсы, тестирование |
| **n8n-nodes-puppeteer** | ⭐⭐⭐ | Free | ⭐⭐⭐⭐ | ⭐⭐⭐ | Визуальный подход, обучение |

## 🎓 Дополнительные ресурсы

- [Browserless Documentation](https://docs.browserless.io/)
- [Puppeteer API](https://pptr.dev/)
- [n8n Documentation](https://docs.n8n.io/)
- [Claude.AI](https://claude.ai/)

## ✅ Чеклист запуска

- [ ] Аккаунт Browserless создан
- [ ] Токен получен: `2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac`
- [ ] Puppeteer установлен: `npm install puppeteer`
- [ ] Workflow импортирован в n8n
- [ ] Credentials (SESSION_KEY, CF_BM) добавлены
- [ ] Тестовый запрос выполнен успешно
- [ ] Error handling настроен
- [ ] Логирование работает
- [ ] Интеграция с вашим сервисом готова

---

## 🎉 Готово!

Теперь у вас есть **полностью облачное решение**:
- ✅ n8n (облако или self-hosted)
- ✅ Browserless (облачный браузер)
- ✅ Claude.AI (облачный AI)

**Никакого локального Chrome не требуется!** 🚀

### Быстрый тест:

```bash
# Импортируйте workflow по URL:
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-browserless-automation.json

# Добавьте ваши credentials
# Execute Workflow → Success! ✅
```

**Время на настройку: 2 минуты!**
