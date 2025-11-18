# 🔓 Claude.AI Automation с RuCaptcha Turnstile

## 📖 Обзор

Этот workflow использует **RuCaptcha API** для автоматического решения Cloudflare Turnstile капчи и последующего взаимодействия с Claude.AI.

## 🎯 Как это работает

```
1. Отправка задачи → RuCaptcha API
2. Ожидание решения → Получение токена (3-15 сек)
3. Инжект токена → Страница Claude.AI
4. Обход Cloudflare → Взаимодействие с Claude
5. Отправка промпта → Получение ответа
```

## 🔑 Настройка ключей

Вам понадобятся следующие ключи (уже настроены в workflow):

**RuCaptcha API key:** Получите на https://rucaptcha.com

**Browserless token:** Получите на https://browserless.io

**Claude.AI куки:**
- sessionKey: `YOUR_SESSION_KEY_HERE`
- __cf_bm: `YOUR_CF_BM_COOKIE_HERE`

## 📥 Установка

### Импортировать workflow:

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-rucaptcha-automation.json
```

### Настройка:

1. Откройте ноду **"Set Credentials"**
2. Вставьте ваши куки (замените YOUR_SESSION_KEY_HERE и YOUR_CF_BM_COOKIE_HERE):
```javascript
const sessionKey = 'YOUR_SESSION_KEY_HERE';
const cfBmCookie = 'YOUR_CF_BM_COOKIE_HERE';
```

3. **ВАЖНО:** Нужно найти правильный **Cloudflare Turnstile sitekey** для Claude.ai

## 🔍 Как найти Turnstile sitekey

### Вариант 1: Через DevTools

1. Откройте https://claude.ai в браузере
2. Откройте DevTools (F12)
3. Перейдите на вкладку **Elements** (или **Инспектор**)
4. Найдите элемент с Cloudflare Turnstile (обычно `<div>` или `<iframe>`)
5. Ищите атрибут `data-sitekey`

Пример:
```html
<div class="cf-turnstile" data-sitekey="0x4AAAAAAAx72oZP84dEhPLj"></div>
```

### Вариант 2: Через Console

1. Откройте https://claude.ai
2. Откройте Console (F12 → Console)
3. Вставьте и выполните этот код:

```javascript
const i = setInterval(() => {
  if (window.turnstile) {
    clearInterval(i);
    window.turnstile.render = (a, b) => {
      console.log('Turnstile sitekey:', b.sitekey);
      console.log('Full params:', JSON.stringify(b, null, 2));
      return 'intercepted';
    }
  }
}, 10);

// Обновите страницу после выполнения этого кода
```

4. Обновите страницу (F5)
5. В консоли появится sitekey и другие параметры

### Вариант 3: Через Network

1. Откройте DevTools → Network
2. Обновите страницу Claude.ai
3. Найдите запрос к `challenges.cloudflare.com` или `api.js`
4. Проверьте Query Parameters или Response

## ⚙️ Обновление sitekey в workflow

После того как нашли sitekey, обновите его в ноде **"Create Turnstile Task"**:

```json
{
  "clientKey": "YOUR_RUCAPTCHA_API_KEY",
  "task": {
    "type": "TurnstileTaskProxyless",
    "websiteURL": "https://claude.ai/new",
    "websiteKey": "ВАШ_НАЙДЕННЫЙ_SITEKEY_ЗДЕСЬ"
  }
}
```

## 📊 Структура workflow

### Ноды:

1. **Manual Trigger** - запуск workflow
2. **Set Credentials** - настройка ключей и кук
3. **Create Turnstile Task** - отправка задачи на RuCaptcha
4. **Check Task Created** - проверка успешного создания задачи
5. **Wait 3s** - ожидание решения (с retry loop)
6. **Get Task Result** - получение результата
7. **Check if Ready** - проверка статуса (ready/processing)
8. **Prepare Browserless Request** - подготовка кода с токеном
9. **Execute on Browserless** - выполнение на Browserless
10. **Format Result** - форматирование ответа

### Логика цикла ожидания:

```
Create Task → Wait 3s → Get Result → Ready?
                ↑                        ↓ No
                └────────────────────────┘
                                         ↓ Yes
                                  Execute Automation
```

## 💰 Стоимость RuCaptcha

- **Turnstile решение:** ~$0.0015 за капчу
- **Время решения:** 3-15 секунд
- **Проверьте баланс:** https://rucaptcha.com/account

## 🐛 Troubleshooting

### Error: "Invalid sitekey"

```
Причина: Неправильный websiteKey в запросе

Решение: Найдите правильный sitekey для Claude.ai (см. выше)
```

### Error: "Task timeout"

```
Причина: RuCaptcha не смог решить капчу вовремя

Решение:
- Проверьте баланс на RuCaptcha
- Увеличьте количество retry (добавьте больше циклов)
```

### Error: "Turnstile not bypassed"

```
Причина: Токен получен, но не применился на странице

Решение:
- Проверьте правильность sitekey
- Возможно нужны дополнительные параметры (action, data, pagedata)
- Используйте метод перехвата для Cloudflare Challenge page
```

### Error: "Auth failed"

```
Причина: Куки устарели или неверные

Решение: Получите свежие куки из браузера
```

## 📚 Дополнительные параметры

Если базовый метод не работает, возможно Claude.ai использует **Cloudflare Challenge page** с дополнительными параметрами:

```json
{
  "clientKey": "YOUR_RUCAPTCHA_API_KEY",
  "task": {
    "type": "TurnstileTaskProxyless",
    "websiteURL": "https://claude.ai/new",
    "websiteKey": "SITEKEY",
    "action": "managed",
    "data": "DATA_VALUE",
    "pagedata": "PAGEDATA_VALUE"
  }
}
```

Эти параметры можно получить с помощью скрипта перехвата (см. выше "Вариант 2: Через Console").

## 🎉 Успешный запуск

Если все настроено правильно, вы увидите:

```json
{
  "status": "✅ Success",
  "prompt": "Привет! Как дела?",
  "response": "Привет! У меня всё хорошо, спасибо...",
  "timestamp": "2024-01-15T12:34:56.789Z"
}
```

## 🔗 Полезные ссылки

- **RuCaptcha Dashboard:** https://rucaptcha.com/account
- **RuCaptcha API Docs:** https://rucaptcha.com/api-docs
- **Turnstile Demo:** https://rucaptcha.com/demo/cloudflare-turnstile
- **2Captcha PHP Library:** https://github.com/2captcha/2captcha-php
- **2Captcha Python Library:** https://github.com/2captcha/2captcha-python

## ⚠️ Важные замечания

1. **Баланс RuCaptcha:** Убедитесь что на счету есть средства
2. **Sitekey:** Обязательно найдите правильный sitekey для Claude.ai
3. **Куки:** Регулярно обновляйте куки (они истекают)
4. **Лимиты:** RuCaptcha может иметь rate limits
5. **Browserless:** Убедитесь что токен Browserless активен

---

**Удачи с автоматизацией! 🚀**
