# Извлечение Cloudflare Turnstile Sitekey из Claude.AI

## 🎯 Что делает этот workflow

Автоматически извлекает `sitekey` из Cloudflare Turnstile на странице Claude.AI через Browserless.io API.

## 📋 Файлы

- **`extract-sitekey-claude-advanced.json`** - Продвинутая версия с перехватом turnstile.render()

## 🚀 Как использовать

### 1. Импорт в n8n

Импортируйте workflow по URL:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/workflows/extract-sitekey-claude-advanced.json
```

### 2. Что происходит внутри

Workflow делает следующее:

1. **⚙️ Settings** - Настройки:
   - `targetURL`: https://claude.ai/new (можно изменить)
   - `waitTime`: 3000 мс (время ожидания загрузки страницы)

2. **🌐 Browserless Extract** - Извлечение через Browserless.io:
   - Использует `/function` endpoint
   - Запускает Puppeteer скрипт в облаке
   - Перехватывает вызов `window.turnstile.render()`
   - Получает все параметры Cloudflare Turnstile

3. **📊 Final Result** - Результат:
   - `success`: true/false
   - `websiteKey`: Найденный sitekey
   - `websiteURL`: URL страницы
   - `captchaType`: Тип капчи
   - `action`, `cData`, `chlPageData`: Дополнительные параметры
   - `RuCaptcha Request`: Готовый JSON для отправки в RuCaptcha API

### 3. Методы извлечения

Workflow использует 3 метода по порядку:

#### Метод 1: Перехват turnstile.render() ✅ САМЫЙ НАДЕЖНЫЙ
```javascript
window.turnstile.render = function(container, params) {
  // Перехватываем sitekey и все параметры
  window.captchaData = {
    sitekey: params.sitekey,
    action: params.action,
    cData: params.cData,
    chlPageData: params.chlPageData
  };
}
```

Получаем:
- `sitekey` - ключ сайта
- `action` - действие (опционально)
- `cData` - дополнительные данные (опционально)
- `chlPageData` - данные страницы (опционально)

#### Метод 2: Поиск в DOM
```javascript
// Ищем элементы с data-sitekey
document.querySelector('[data-sitekey]')
document.querySelector('[sitekey]')
document.querySelector('div[class*="turnstile"]')
document.querySelector('iframe[src*="challenges.cloudflare.com"]')
```

#### Метод 3: Regex в HTML
```javascript
// Регулярные выражения
/data-sitekey=["']([0-9a-zA-Z_-]{10,100})["']/
/["']sitekey["']\s*:\s*["']([0-9a-zA-Z_-]{10,100})["']/
/["'](0x[0-9a-zA-Z_-]{10,100})["']/
```

### 4. Пример результата

При успешном извлечении:
```json
{
  "✅ success": true,
  "🔑 websiteKey": "0x4AAAAAAAgFKMYKbQ-ShK0x",
  "🌐 websiteURL": "https://claude.ai/new",
  "📋 captchaType": "challenge_page",
  "🔍 searchMethods": "[\"✅ turnstile.render() intercepted\"]",
  "⚡ action": "login",
  "📦 cData": "xyz123...",
  "📄 chlPageData": "abc456...",
  "🤖 RuCaptcha Request": "{
    \"clientKey\": \"YOUR_RUCAPTCHA_API_KEY\",
    \"task\": {
      \"type\": \"TurnstileTaskProxyless\",
      \"websiteURL\": \"https://claude.ai/new\",
      \"websiteKey\": \"0x4AAAAAAAgFKMYKbQ-ShK0x\",
      \"action\": \"login\",
      \"data\": \"xyz123...\",
      \"pagedata\": \"abc456...\"
    }
  }"
}
```

### 5. Использование с RuCaptcha API

Скопируйте значение из поля **🤖 RuCaptcha Request** и отправьте в RuCaptcha API:

```bash
curl -X POST https://api.rucaptcha.com/createTask \
  -H "Content-Type: application/json" \
  -d '{
    "clientKey": "YOUR_RUCAPTCHA_API_KEY",
    "task": {
      "type": "TurnstileTaskProxyless",
      "websiteURL": "https://claude.ai/new",
      "websiteKey": "0x4AAAAAAAgFKMYKbQ-ShK0x",
      "action": "login",
      "data": "xyz123...",
      "pagedata": "abc456..."
    }
  }'
```

## 🔧 Настройки

### Изменить целевой URL

В ноде **⚙️ Settings** измените:
```
targetURL: "https://другой-сайт.com"
```

### Увеличить время ожидания

Если sitekey не находится, увеличьте waitTime:
```
waitTime: 5000  // 5 секунд
```

## ⚠️ Важно

1. **Browserless.io токен** уже настроен: `2TRkln4qk0YySXg802f0c9d35a14b6e4fdedbdc9bff4edaac`
2. **Замените** `YOUR_RUCAPTCHA_API_KEY` на ваш настоящий ключ
3. **Timeout**: Workflow может выполняться до 90 секунд

## 📊 Типы капчи

- `challenge_page` - Полностраничная проверка (перехвачен turnstile.render)
- `standalone` - Виджет на странице (найден в DOM)
- `standalone_iframe` - Виджет в iframe
- `html_extraction` - Найден regex в HTML
- `not_found` - Sitekey не найден

## 🐛 Troubleshooting

### Sitekey не найден
1. Увеличьте `waitTime` до 5000-10000 мс
2. Проверьте что страница действительно использует Cloudflare Turnstile
3. Проверьте логи в поле **🔍 searchMethods**

### Ошибка 401 от Browserless.io
- Проверьте что токен правильный
- Проверьте лимиты на аккаунте Browserless.io

### Timeout
- Увеличьте `timeout` в настройках HTTP Request ноды
- Уменьшите `waitTime` если страница загружается быстро

## 📚 Дополнительно

- [Документация Browserless.io](https://www.browserless.io/docs)
- [Документация RuCaptcha](https://rucaptcha.com/api-rucaptcha)
- [Cloudflare Turnstile](https://developers.cloudflare.com/turnstile/)
