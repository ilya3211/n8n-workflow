# 🔐 Как получить cookies для авторизации в Google AI Studio

## Способ 1: Через расширение браузера (Рекомендуется)

### Chrome/Edge:
1. Установите расширение **"EditThisCookie"** или **"Cookie-Editor"**
2. Откройте https://aistudio.google.com и **авторизуйтесь**
3. Нажмите на иконку расширения
4. Нажмите **"Export"** → **"JSON"**
5. Скопируйте JSON массив cookies

### Firefox:
1. Установите расширение **"Cookie Quick Manager"**
2. Откройте https://aistudio.google.com и **авторизуйтесь**
3. Откройте расширение
4. Выберите домен `aistudio.google.com`
5. Экспортируйте cookies в JSON формате

---

## Способ 2: Через DevTools (Chrome/Edge)

1. Откройте https://aistudio.google.com и **авторизуйтесь**
2. Нажмите **F12** (открыть DevTools)
3. Перейдите на вкладку **"Application"** (или "Storage")
4. В боковой панели выберите **"Cookies"** → `https://aistudio.google.com`
5. Откройте **Console** и выполните:

```javascript
// Скопируйте этот код в консоль браузера
copy(JSON.stringify(document.cookie.split('; ').map(c => {
  const [name, ...value] = c.split('=');
  return {
    name: name,
    value: value.join('='),
    domain: '.google.com',
    path: '/',
    secure: true,
    httpOnly: false
  };
})));
```

6. Cookies скопированы в буфер обмена!

---

## Способ 3: Экспорт всех cookies (автоматически)

Вставьте в консоль браузера (F12 → Console):

```javascript
// Получить все cookies для Google AI Studio
const cookies = await cookieStore.getAll();
const formatted = cookies.map(c => ({
  name: c.name,
  value: c.value,
  domain: c.domain,
  path: c.path,
  secure: c.secure,
  httpOnly: c.httpOnly || false,
  sameSite: c.sameSite || 'Lax',
  expires: c.expires ? Math.floor(c.expires / 1000) : -1
}));
console.log(JSON.stringify(formatted, null, 2));
copy(JSON.stringify(formatted));
```

---

## Формат cookies для n8n:

### JSON формат (рекомендуется):
```json
[
  {
    "name": "SID",
    "value": "g.a000...",
    "domain": ".google.com",
    "path": "/",
    "secure": true,
    "httpOnly": true
  },
  {
    "name": "HSID",
    "value": "A...",
    "domain": ".google.com",
    "path": "/",
    "secure": true,
    "httpOnly": true
  }
]
```

---

## Использование в n8n workflow:

### Вариант 1: Через Manual Trigger
1. Откройте workflow в n8n
2. В ноде **"Manual Trigger"** найдите поле `googleCookies`
3. Вставьте JSON массив cookies
4. Нажмите **"Execute Workflow"**

### Вариант 2: Через Webhook
```bash
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-auth \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет!",
    "googleCookies": "[{\"name\":\"SID\",\"value\":\"...\"}]"
  }'
```

### Вариант 3: Сохранить в переменных n8n
1. Settings → Variables
2. Создайте переменную `GOOGLE_COOKIES`
3. Вставьте JSON cookies
4. В workflow используйте: `{{ $env.GOOGLE_COOKIES }}`

---

## Важные cookies для Google:

Обязательно нужны эти cookies:
- ✅ `SID` - Session ID
- ✅ `HSID` - Host Session ID
- ✅ `SSID` - Secure Session ID
- ✅ `APISID` - API Session ID
- ✅ `SAPISID` - Secure API Session ID
- ✅ `__Secure-1PSID` - Secure session
- ✅ `__Secure-3PSID` - Another secure session

---

## Проверка авторизации:

После добавления cookies:
1. Запустите workflow
2. Проверьте скриншот
3. Если видите свой профиль/аватар - авторизация работает! ✅
4. Если видите "Sign in" - нужно обновить cookies

---

## Срок действия cookies:

- Google cookies обычно действуют **2 недели - 1 месяц**
- После истечения нужно заново экспортировать
- Можно настроить автоматическое обновление через скрипт

---

## Безопасность:

⚠️ **Важно:**
- Cookies дают полный доступ к вашему Google аккаунту!
- Не делитесь ими с другими
- Храните в безопасном месте (переменные окружения n8n)
- Используйте отдельный Google аккаунт для автоматизации

---

## Альтернативы:

Если не хотите использовать cookies:
1. **API ключ Google AI** - прямой доступ через API (без браузера)
2. **OAuth 2.0** - программная авторизация
3. **Service Account** - для серверных приложений

---

**Последнее обновление:** 2025-11-18
