# 🎭 Puppeteer Code для Claude.AI Automation

## 📋 Инструкция

После установки `n8n-nodes-puppeteer`, добавьте Puppeteer node в workflow между нодами:
- **Extract Parameters** → **Puppeteer** → **Respond to Webhook**

## 🔧 Настройки Puppeteer Node

### Browser Options:
```json
{
  "headless": true,
  "args": [
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--disable-dev-shm-usage",
    "--disable-gpu"
  ]
}
```

### Page Options:
```json
{
  "timeout": 120000,
  "waitUntil": "networkidle2"
}
```

## 💻 Код для Puppeteer Node

Скопируйте и вставьте этот код в поле **Code** Puppeteer node:

```javascript
// Получение параметров из предыдущей ноды
const userPrompt = $json.userPrompt;
const sessionKey = $json.sessionKey;
const cfBmCookie = $json.cfBmCookie;

try {
  // Установка куков для аутентификации
  await page.setCookie(
    {
      name: 'sessionKey',
      value: sessionKey,
      domain: '.claude.ai',
      path: '/',
      httpOnly: true,
      secure: true,
      sameSite: 'None'
    },
    {
      name: '__cf_bm',
      value: cfBmCookie,
      domain: '.claude.ai',
      path: '/',
      httpOnly: true,
      secure: true,
      sameSite: 'None'
    }
  );

  console.log('✅ Куки установлены успешно');

  // Переход на страницу Claude
  await page.goto('https://claude.ai/new', {
    waitUntil: 'networkidle2',
    timeout: 30000
  });

  console.log('✅ Страница загружена');

  // Ожидание загрузки интерфейса чата
  await page.waitForSelector('div[contenteditable="true"]', {
    timeout: 10000
  });

  console.log('✅ Поле ввода найдено');

  // Клик по полю ввода и ввод текста
  await page.click('div[contenteditable="true"]');
  await page.type('div[contenteditable="true"]', userPrompt, {
    delay: 50
  });

  console.log('✅ Текст введен');

  // Поиск и клик по кнопке отправки
  await page.waitForSelector('button[aria-label="Send Message"], button[type="submit"]', {
    timeout: 5000
  });
  await page.click('button[aria-label="Send Message"], button[type="submit"]');

  console.log('✅ Сообщение отправлено');

  // Ожидание появления ответа (минимум 2 сообщения)
  await page.waitForFunction(
    () => {
      const messages = document.querySelectorAll('[data-testid="message"]');
      return messages.length >= 2;
    },
    { timeout: 60000 }
  );

  console.log('✅ Ответ получен');

  // Ожидание завершения генерации (исчезновение кнопки Stop)
  await page.waitForFunction(
    () => {
      const stopButton = document.querySelector('button[aria-label="Stop generating"]');
      return !stopButton || stopButton.disabled;
    },
    { timeout: 120000 }
  );

  console.log('✅ Генерация завершена');

  // Извлечение текста последнего сообщения
  const response = await page.evaluate(() => {
    const messages = document.querySelectorAll('[data-testid="message"]');
    if (messages.length < 2) return null;

    const lastMessage = messages[messages.length - 1];
    return lastMessage.innerText || lastMessage.textContent;
  });

  console.log('✅ Ответ извлечен:', response ? response.substring(0, 100) + '...' : 'null');

  // Возврат успешного результата
  return {
    success: true,
    prompt: userPrompt,
    response: response,
    timestamp: new Date().toISOString(),
    cookiesUsed: {
      sessionKey: sessionKey.substring(0, 20) + '...',
      cfBmCookie: cfBmCookie.substring(0, 20) + '...'
    }
  };

} catch (error) {
  console.error('❌ Ошибка:', error.message);

  // Создание скриншота для отладки
  let screenshot = null;
  try {
    screenshot = await page.screenshot({
      encoding: 'base64',
      fullPage: true
    });
  } catch (screenshotError) {
    console.error('❌ Не удалось создать скриншот:', screenshotError.message);
  }

  // Возврат ошибки
  return {
    success: false,
    error: error.message,
    errorStack: error.stack,
    timestamp: new Date().toISOString(),
    screenshot: screenshot,
    debugInfo: {
      url: await page.url(),
      title: await page.title()
    }
  };
}
```

## 🎯 Альтернативный код (упрощенный)

Если основной код не работает, попробуйте этот упрощенный вариант:

```javascript
const userPrompt = $json.userPrompt;
const sessionKey = $json.sessionKey;
const cfBmCookie = $json.cfBmCookie;

// Установка куков
await page.setCookie(
  { name: 'sessionKey', value: sessionKey, domain: '.claude.ai' },
  { name: '__cf_bm', value: cfBmCookie, domain: '.claude.ai' }
);

// Переход на страницу
await page.goto('https://claude.ai/new', { waitUntil: 'networkidle2' });

// Ввод текста
await page.waitForSelector('div[contenteditable="true"]');
await page.type('div[contenteditable="true"]', userPrompt);

// Отправка
await page.keyboard.press('Enter');

// Ожидание ответа
await page.waitForTimeout(5000);

// Извлечение
const response = await page.evaluate(() => {
  const messages = document.querySelectorAll('[data-testid="message"]');
  return messages[messages.length - 1]?.innerText || 'No response';
});

return { success: true, response: response };
```

## 🔍 Отладка

### Если селекторы не работают:

1. Откройте https://claude.ai/new в браузере
2. DevTools (F12) → Elements
3. Найдите элементы:
   - Поле ввода: `div[contenteditable="true"]`
   - Кнопка отправки: `button[aria-label="Send Message"]`
   - Сообщения: `[data-testid="message"]`
4. Обновите селекторы в коде если они изменились

### Включить headless: false для визуальной отладки:

В Browser Options измените:
```json
{
  "headless": false
}
```

### Увеличить таймауты:

Если Claude медленно отвечает:
```javascript
await page.waitForFunction(..., { timeout: 180000 }); // 3 минуты
```

## 📊 Формат вывода

### Успешный ответ:
```json
{
  "success": true,
  "prompt": "Привет! Как дела?",
  "response": "Привет! У меня всё отлично...",
  "timestamp": "2025-11-15T13:30:00.000Z",
  "cookiesUsed": {
    "sessionKey": "sk-ant-sid01-ITi3It...",
    "cfBmCookie": "1y.RWS8nkXHpLAogpDL..."
  }
}
```

### Ответ с ошибкой:
```json
{
  "success": false,
  "error": "Navigation timeout exceeded",
  "errorStack": "Error: Navigation timeout...",
  "timestamp": "2025-11-15T13:30:00.000Z",
  "screenshot": "base64_encoded_screenshot",
  "debugInfo": {
    "url": "https://claude.ai/new",
    "title": "Claude"
  }
}
```

## 🚨 Частые проблемы

### 1. "Selector not found"
**Решение**: Обновите селекторы (Claude.ai изменил интерфейс)

### 2. "Navigation timeout"
**Решение**: Увеличьте timeout или проверьте интернет

### 3. "Authentication failed"
**Решение**: Обновите куки (sessionKey и __cf_bm)

### 4. "Screenshot failed"
**Решение**: Добавьте try-catch вокруг page.screenshot()

## 💡 Советы

1. **Кэшируйте результаты** - не отправляйте одинаковые запросы
2. **Rate limiting** - ограничьте количество запросов в минуту
3. **Мониторинг** - логируйте все запросы и ошибки
4. **Обновление куков** - автоматизируйте через отдельный workflow

## 🔗 Полезные ссылки

- [Puppeteer Documentation](https://pptr.dev/)
- [n8n-nodes-puppeteer](https://www.npmjs.com/package/n8n-nodes-puppeteer)
- [Claude.ai](https://claude.ai)

---

**Готово к копированию!** 🚀
