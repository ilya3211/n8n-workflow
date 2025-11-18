# 🔍 Все способы найти Cloudflare Turnstile Sitekey

## Обзор

Cloudflare Turnstile требует `sitekey` для решения капчи. Вот все доступные методы для его извлечения из Claude.ai.

---

## ✅ Метод 1: DevTools (Inspector)

**Сложность:** ⭐ Простой
**Требует:** Только браузер

### Шаги:

1. Откройте https://claude.ai в Chrome/Firefox
2. Нажмите **F12** (открыть DevTools)
3. Перейдите на вкладку **Elements** (или **Inspector**)
4. Нажмите **Ctrl+F** для поиска
5. Ищите: `data-sitekey`
6. Найдите элемент типа:
   ```html
   <div class="cf-turnstile" data-sitekey="0x4AAAAAAAx72oZP84dEhPLj"></div>
   ```

**Что искать:**
- `data-sitekey="..."`
- Элемент с классом `cf-turnstile`
- `<iframe>` от `challenges.cloudflare.com`

---

## ✅ Метод 2: JavaScript Console (Перехват)

**Сложность:** ⭐⭐ Средний
**Требует:** Браузер + JavaScript

### Скрипт для перехвата:

1. Откройте https://claude.ai
2. Откройте Console (F12 → Console)
3. Вставьте и выполните этот код:

```javascript
const i = setInterval(() => {
  if (window.turnstile) {
    clearInterval(i);
    window.turnstile.render = (a, b) => {
      console.log('✅ Turnstile Sitekey:', b.sitekey);
      console.log('📋 Full params:', JSON.stringify(b, null, 2));

      // Для Cloudflare Challenge Page:
      if (b.cData || b.chlPageData || b.action) {
        console.log('🔒 Challenge Page detected!');
        console.log('   cData:', b.cData);
        console.log('   chlPageData:', b.chlPageData);
        console.log('   action:', b.action);
      }

      return 'intercepted';
    }
  }
}, 10);

console.log('🔍 Ожидаем загрузку Turnstile...');
console.log('🔄 Обновите страницу после выполнения этого скрипта');
```

4. **Обновите страницу** (F5)
5. В консоли появится sitekey и все параметры!

---

## ✅ Метод 3: View Page Source

**Сложность:** ⭐ Простой
**Требует:** Только браузер

### Шаги:

1. Откройте https://claude.ai
2. Нажмите **Ctrl+U** (View Page Source)
3. Нажмите **Ctrl+F** для поиска
4. Ищите:
   - `data-sitekey`
   - `sitekey:`
   - `turnstile.render`
   - `challenges.cloudflare.com`

---

## ✅ Метод 4: Network Tab

**Сложность:** ⭐⭐ Средний
**Требует:** Браузер DevTools

### Шаги:

1. Откройте DevTools → **Network** tab
2. Обновите страницу Claude.ai (F5)
3. В фильтре ищите:
   - `api.js` (Cloudflare Turnstile script)
   - `challenges.cloudflare.com`
4. Кликните на запрос
5. Проверьте:
   - **Query Parameters** (может содержать sitekey)
   - **Response** (может содержать sitekey в коде)
   - **Initiator** (скрипт который вызывает Turnstile)

---

## ✅ Метод 5: Bash Script (curl + grep)

**Сложность:** ⭐⭐ Средний
**Требует:** Linux/Mac terminal

### Использование:

```bash
chmod +x scripts/find-turnstile-sitekey.sh
./scripts/find-turnstile-sitekey.sh
```

### Или вручную:

```bash
curl -s -L "https://claude.ai/new" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  | grep -oP 'data-sitekey=["'\'']\K[^"'\'']+'
```

**Ограничение:** Не работает если Turnstile загружается динамически через JavaScript

---

## ✅ Метод 6: Python Script

**Сложность:** ⭐⭐⭐ Сложный
**Требует:** Python + библиотеки

### Установка:

```bash
pip install requests beautifulsoup4
```

### Использование:

```bash
chmod +x scripts/find_sitekey.py
python3 scripts/find_sitekey.py
```

**Возможности:**
- ✅ Ищет data-sitekey в HTML
- ✅ Ищет через regex паттерны
- ✅ Проверяет iframe src
- ✅ Удаляет дубликаты
- ✅ Выводит все найденные sitekey

---

## ✅ Метод 7: n8n Workflow (АВТОМАТИЧЕСКИЙ!)

**Сложность:** ⭐ Простой
**Требует:** n8n + Browserless

### Импортировать workflow:

```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/extract-turnstile-sitekey.json
```

### Что делает:

1. Загружает Claude.ai через Browserless
2. Ищет sitekey через JavaScript на странице
3. Проверяет:
   - `data-sitekey` атрибуты
   - Inline скрипты с sitekey
   - `turnstile.render()` вызовы
   - iframe от Cloudflare
4. Возвращает все найденные sitekey

### Запуск:

Просто нажмите **Execute Workflow** - все автоматически!

**Результат:**
```json
{
  "status": "✅ Sitekey найден!",
  "sitekeys": ["0x4AAAAAAAx72oZP84dEhPLj"],
  "recommendation": "Используйте этот sitekey: 0x4AAAAAAAx72oZP84dEhPLj"
}
```

---

## ✅ Метод 8: Browserless /scrape API

**Сложность:** ⭐⭐ Средний
**Требует:** API токен Browserless

### Использование:

```bash
curl -X POST "https://production-sfo.browserless.io/scrape?token=YOUR_TOKEN&stealth=true" \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://claude.ai/new",
    "elements": [{
      "selector": "[data-sitekey]"
    }],
    "waitForTimeout": 5000
  }'
```

---

## 🎯 Какой метод выбрать?

| Метод | Простота | Надежность | Скорость | Рекомендация |
|-------|----------|------------|----------|--------------|
| DevTools Inspector | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | Если Turnstile виден в HTML |
| Console Перехват | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | **ЛУЧШИЙ для Challenge Page** |
| View Source | ⭐⭐⭐ | ⭐ | ⭐⭐⭐ | Если Turnstile в статичном HTML |
| Network Tab | ⭐⭐ | ⭐⭐ | ⭐⭐ | Для анализа запросов |
| Bash Script | ⭐⭐ | ⭐ | ⭐⭐⭐ | Если нет JavaScript загрузки |
| Python Script | ⭐ | ⭐⭐ | ⭐⭐ | Программный подход |
| n8n Workflow | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | **САМЫЙ ПРОСТОЙ** |
| Browserless API | ⭐ | ⭐⭐⭐ | ⭐⭐ | Для интеграции в automation |

---

## 🔴 Если sitekey не найден?

### Возможные причины:

1. **Turnstile загружается динамически**
   - Решение: Используйте **Метод 2** (Console перехват)

2. **Требуется аутентификация**
   - Решение: Войдите в аккаунт, затем ищите sitekey

3. **Cloudflare Challenge Page**
   - Решение: Используйте перехват + дополнительные параметры (cData, chlPageData, action)

4. **Sitekey меняется динамически**
   - Решение: Извлекайте sitekey при каждом запуске workflow

---

## 📋 Следующие шаги после нахождения sitekey:

1. Скопируйте найденный sitekey
2. Откройте workflow **"Claude.AI with RuCaptcha Turnstile"**
3. В ноде **"Create Turnstile Task"** замените:
   ```json
   "websiteKey": "0x4AAAAAAAx72oZP84dEhPLj"
   ```
   На ваш найденный sitekey
4. Запустите workflow!

---

## 💡 Полезные ссылки:

- **Cloudflare Turnstile Docs:** https://developers.cloudflare.com/turnstile/
- **RuCaptcha Turnstile API:** https://rucaptcha.com/api-docs
- **Turnstile Demo:** https://rucaptcha.com/demo/cloudflare-turnstile
- **Browserless Docs:** https://docs.browserless.io/

---

**Удачи в поиске sitekey! 🚀**
