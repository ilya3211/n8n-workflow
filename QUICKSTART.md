# ⚡ Быстрый старт - 5 минут до первого запуска

## 🎯 Самый быстрый способ

```bash
# 1. Запустите автоматическую установку
./setup.sh

# 2. Получите credentials (см. ниже)

# 3. Запустите n8n
npx n8n start

# 4. Откройте http://localhost:5678 и импортируйте workflow
```

---

## 🔑 Как получить credentials за 30 секунд

### Метод 1: Копирование из DevTools (самый простой)

1. **Откройте**: https://claude.ai (залогиньтесь)
2. **Нажмите**: `F12` (DevTools)
3. **Перейдите**: вкладка `Application` → `Cookies` → `https://claude.ai`
4. **Скопируйте**:
   - `sessionKey` (строка вида `sk-ant-sid01-...`)
   - `__cf_bm` (строка вида `abc123...`)

### Метод 2: JavaScript в Console (быстрее)

1. Откройте https://claude.ai
2. Нажмите `Ctrl+Shift+J` (Console)
3. Вставьте и выполните:

```javascript
// Копировать sessionKey
copy(document.cookie.split(';').find(c=>c.includes('sessionKey')).split('=')[1])
// Результат скопирован в буфер обмена!

// Копировать __cf_bm
copy(document.cookie.split(';').find(c=>c.includes('__cf_bm')).split('=')[1])
// Результат скопирован в буфер обмена!
```

---

## 🚀 Три способа настройки credentials

### Способ 1: Через .env файл (рекомендуется)

Отредактируйте `.env`:
```bash
CLAUDE_SESSION_KEY=sk-ant-sid01-ваш-ключ-здесь
CLAUDE_CF_BM_COOKIE=ваш-cf-bm-здесь
```

### Способ 2: Через n8n UI (визуально)

1. Откройте n8n: http://localhost:5678
2. Импортируйте workflow
3. Откройте ноду "Set Credentials"
4. Замените значения:
   - `sessionKey: "ВАШ_КЛЮЧ"`
   - `cfBmCookie: "ВАШ_COOKIE"`
5. Save

### Способ 3: Через командную строку (для автоматизации)

```bash
# Замените значения в workflow файле
sed -i 's/YOUR_SESSION_KEY_HERE/sk-ant-sid01-ваш-ключ/g' \
  workflows/claude-ai-via-n8n-nodes-puppeteer.json

sed -i 's/YOUR_CF_BM_COOKIE_HERE/ваш-cf-bm/g' \
  workflows/claude-ai-via-n8n-nodes-puppeteer.json
```

---

## 🧪 Тестирование (1 минута)

```bash
# 1. Запустите n8n (если ещё не запущен)
npx n8n start

# 2. В другом терминале - проверка готовности
curl http://localhost:5678 | grep "n8n"

# 3. Откройте браузер
# http://localhost:5678

# 4. В n8n UI:
#    - Import workflow из workflows/claude-ai-via-n8n-nodes-puppeteer.json
#    - Кликните на "Manual Trigger"
#    - Execute Workflow
#    - Проверьте результат в последней ноде "Format Result"
```

---

## 📦 Одна команда - полная установка

**Ubuntu/Debian:**
```bash
curl -fsSL https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw/setup.sh | bash
```

**Или клонируйте репозиторий:**
```bash
git clone https://github.com/ilya3211/n8n-workflow.git
cd n8n-workflow
git checkout claude/n8n-puppeteer-workflow-011u6QHGKL3JawyaecQLDwFw
./setup.sh
```

---

## 🎬 Пример первого запуска

```bash
# Терминал 1: Запуск n8n
cd /home/user/n8n-workflow
npx n8n start

# Вывод:
# ✅ n8n ready on http://localhost:5678
```

```bash
# Терминал 2: Проверка
curl http://localhost:5678/healthz
# Вывод: {"status":"ok"}
```

**Браузер:**
1. Откройте: http://localhost:5678
2. Create account (первый раз) или Login
3. `+` → Import from File → `workflows/claude-ai-via-n8n-nodes-puppeteer.json`
4. Обновите credentials в "Set Credentials"
5. Кликните "Manual Trigger" → Execute Workflow
6. Ждите ~10-30 секунд
7. Проверьте результат! ✅

---

## 🔥 Pro Tips

### Tip 1: Запуск n8n в фоне

```bash
# С логами в файл
nohup npx n8n start > n8n.log 2>&1 &

# Проверка процесса
ps aux | grep n8n

# Остановка
pkill -f n8n
```

### Tip 2: Автозапуск workflow через Webhook

Добавьте в начало workflow ноду "Webhook":
```
Webhook (POST /claude) → Set Credentials → ...
```

Затем вызывайте через API:
```bash
curl -X POST http://localhost:5678/webhook/claude \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи шутку про программистов",
    "sessionKey": "sk-ant-sid01-...",
    "cfBmCookie": "..."
  }'
```

### Tip 3: Docker одной командой

```bash
# Создайте docker-compose.yml (уже есть в репо)
docker-compose up -d

# Проверка
docker-compose logs -f

# Остановка
docker-compose down
```

### Tip 4: Мониторинг выполнения

```bash
# Следить за логами n8n в реальном времени
tail -f n8n.log | grep -E "Workflow|Error|Success"
```

### Tip 5: Обновление credentials без перезапуска

Используйте n8n Credentials:
1. Settings → Credentials → Add Credential
2. Создайте "Generic Credential" с полями:
   - `sessionKey`
   - `cfBmCookie`
3. В workflow используйте: `{{ $credentials.ClaudeAuth.sessionKey }}`

---

## 🛠️ Решение частых проблем

### Проблема: "Port 5678 already in use"

```bash
# Найти процесс
lsof -i :5678

# Убить процесс
kill -9 <PID>

# Или использовать другой порт
N8N_PORT=5679 npx n8n start
```

### Проблема: "Puppeteer node not found"

```bash
# Переустановить community node
npm uninstall n8n-nodes-puppeteer
npm install n8n-nodes-puppeteer

# Перезапустить n8n
pkill -f n8n
npx n8n start
```

### Проблема: "Browser not found"

```bash
# Установить Chromium
sudo apt-get install chromium-browser

# Или указать путь к Chrome
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome
npx n8n start
```

### Проблема: "Invalid sessionKey"

```bash
# Cookies устарели - получите новые
# 1. Откройте claude.ai в браузере
# 2. F12 → Application → Cookies
# 3. Скопируйте новые значения
# 4. Обновите в workflow
```

---

## 📊 Чек-лист готовности

Перед первым запуском проверьте:

- [ ] ✅ Node.js >= v18.0.0 установлен (`node --version`)
- [ ] ✅ npm установлен (`npm --version`)
- [ ] ✅ n8n установлен (`npm list n8n`)
- [ ] ✅ n8n-nodes-puppeteer установлен (`npm list n8n-nodes-puppeteer`)
- [ ] ✅ Chromium установлен (`which chromium-browser`)
- [ ] ✅ Workflow файл существует (`ls workflows/claude-ai-via-n8n-nodes-puppeteer.json`)
- [ ] ✅ sessionKey получен из claude.ai
- [ ] ✅ __cf_bm получен из claude.ai
- [ ] ✅ Credentials обновлены в workflow или .env
- [ ] ✅ n8n запущен (`curl http://localhost:5678/healthz`)

---

## 🎉 Готово!

Если всё прошло успешно, вы должны увидеть:

```json
{
  "success": true,
  "prompt": "Привет! Расскажи короткую шутку про программистов",
  "claudeResponse": "Почему программисты не любят природу? \nСлишком много багов и нет stack trace! 😄",
  "timestamp": "2025-11-18T12:34:56.789Z"
}
```

**Поздравляем! Автоматизация Claude.AI работает! 🚀**

---

## 📚 Дополнительно

- **Полная инструкция**: `SETUP_GUIDE.md`
- **Документация Puppeteer**: `N8N_NODES_PUPPETEER_GUIDE.md` (на другой ветке)
- **n8n Docs**: https://docs.n8n.io/
- **Puppeteer API**: https://pptr.dev/

**Вопросы?** Создайте Issue в репозитории!
