# 🚀 Полная инструкция по установке и запуску workflow

## 📋 Текущее состояние вашего сервера

✅ **Node.js**: v22.21.1 (установлен)
✅ **npm**: 10.9.4 (установлен)
⚠️ **n8n**: требуется установка или настройка
❌ **n8n-nodes-puppeteer**: не установлен
❌ **Chromium/Chrome**: не установлен

---

## 🛠️ Установка: Пошаговое руководство

### Вариант 1: Локальная установка n8n (рекомендуется для тестирования)

#### Шаг 1: Установка n8n

```bash
# В директории проекта
cd /home/user/n8n-workflow

# Установка n8n локально
npm install n8n

# Или глобально (если нужен доступ из любой директории)
npm install -g n8n
```

#### Шаг 2: Установка Chromium/Chrome

**Ubuntu/Debian:**
```bash
# Установка Chromium
sudo apt-get update
sudo apt-get install -y chromium-browser

# Проверка установки
which chromium-browser
```

**Или Google Chrome:**
```bash
# Скачать и установить Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
```

**CentOS/RHEL:**
```bash
sudo yum install -y chromium
```

**macOS:**
```bash
brew install chromium
```

**Docker (если используете):**
```dockerfile
FROM n8nio/n8n:latest

# Установка Chromium в Docker
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
```

#### Шаг 3: Установка n8n-nodes-puppeteer

```bash
# В директории проекта
cd /home/user/n8n-workflow

# Установка community node
npm install n8n-nodes-puppeteer

# Проверка установки
npm list n8n-nodes-puppeteer
```

**Важно**: После установки community node необходимо перезапустить n8n!

#### Шаг 4: Установка Puppeteer (если требуется)

```bash
# Puppeteer с автоматической загрузкой Chromium
npm install puppeteer

# Или puppeteer-core (без загрузки браузера)
npm install puppeteer-core
```

---

### Вариант 2: Docker setup (для production)

#### docker-compose.yml

```yaml
version: '3.8'

services:
  n8n:
    image: n8nio/n8n:latest
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=your_password
      - PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
    volumes:
      - ./n8n_data:/home/node/.n8n
      - ./workflows:/workflows
    command: >
      sh -c "
        apk add --no-cache chromium nss freetype harfbuzz ca-certificates ttf-freefont &&
        npm install -g n8n-nodes-puppeteer &&
        n8n start
      "
    restart: unless-stopped
```

Запуск:
```bash
docker-compose up -d
```

---

## 🔑 Получение Credentials (sessionKey и cfBmCookie)

### Метод 1: Chrome DevTools (рекомендуется)

1. **Откройте claude.ai в браузере Chrome**
2. **Залогиньтесь в свой аккаунт**
3. **Откройте DevTools**: `F12` или `Ctrl+Shift+I` (Windows/Linux) / `Cmd+Option+I` (Mac)
4. **Перейдите на вкладку "Application"** (или "Приложение")
5. **В левой панели**: Storage → Cookies → https://claude.ai
6. **Найдите и скопируйте**:
   - `sessionKey` - основной токен аутентификации
   - `__cf_bm` - Cloudflare Bot Management cookie

**Скриншот структуры:**
```
Application
  └── Storage
      └── Cookies
          └── https://claude.ai
              ├── sessionKey: "sk-ant-sid01-..." ← СКОПИРУЙТЕ
              └── __cf_bm: "abc123def456..." ← СКОПИРУЙТЕ
```

### Метод 2: JavaScript в Console

1. Откройте Console в DevTools (`Ctrl+Shift+J`)
2. Выполните:

```javascript
// Получить все cookies
const cookies = document.cookie.split(';').reduce((acc, cookie) => {
  const [key, value] = cookie.trim().split('=');
  acc[key] = value;
  return acc;
}, {});

console.log('sessionKey:', cookies.sessionKey);
console.log('__cf_bm:', cookies.__cf_bm);
```

3. Скопируйте значения из консоли

### Метод 3: Network tab

1. Откройте **Network** tab в DevTools
2. Перезагрузите страницу claude.ai
3. Найдите любой запрос к `api.claude.ai`
4. В разделе **Request Headers** найдите `Cookie:`
5. Скопируйте значения `sessionKey` и `__cf_bm`

---

## 📥 Импорт workflow в n8n

### Метод 1: Import from URL

1. Запустите n8n:
```bash
n8n start
```

2. Откройте в браузере: `http://localhost:5678`

3. В интерфейсе n8n:
   - Нажмите **"+"** (New workflow)
   - Нажмите **"..." menu** → **"Import from URL"**
   - Вставьте URL:
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json
```
   - Нажмите **Import**

### Метод 2: Import from file

1. Скачайте workflow локально:
```bash
cd /home/user/n8n-workflow/workflows
curl -O https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json
```

2. В n8n:
   - **"..." menu** → **"Import from File"**
   - Выберите `claude-ai-via-n8n-nodes-puppeteer.json`

---

## ⚙️ Настройка workflow

### 1. Обновление credentials

После импорта:

1. **Откройте ноду "Set Credentials"** (вторая нода)
2. **Замените значения**:
   ```javascript
   prompt: "Привет! Расскажи короткую шутку про программистов"
   sessionKey: "ВАШ_SESSION_KEY_ЗДЕСЬ"  // из шага "Получение Credentials"
   cfBmCookie: "ВАШ_CF_BM_COOKIE_ЗДЕСЬ" // из шага "Получение Credentials"
   ```
3. **Save**

### 2. Проверка установки n8n-nodes-puppeteer

В n8n UI:
- Если ноды **"Puppeteer - Navigate"**, **"Puppeteer - Set Cookies"** и т.д. отображаются с иконкой **⚠️** (warning)
- Это значит `n8n-nodes-puppeteer` не установлен

**Решение:**
```bash
# Остановите n8n
pkill -f n8n

# Установите community node
npm install n8n-nodes-puppeteer

# Запустите n8n заново
n8n start
```

---

## 🧪 Тестирование

### Запуск workflow

1. **В n8n UI откройте workflow**
2. **Нажмите на ноду "Manual Trigger"** (первая нода)
3. **Нажмите "Execute Node"** (или "Execute Workflow")
4. **Наблюдайте выполнение**:
   - Каждая нода будет выполняться последовательно
   - Зелёная галочка ✅ = успех
   - Красный крестик ❌ = ошибка

5. **Проверьте результат**:
   - Откройте последнюю ноду **"Format Result"**
   - В Output должен быть JSON:
   ```json
   {
     "success": true,
     "prompt": "Привет! Расскажи короткую шутку про программистов",
     "claudeResponse": "Ответ от Claude...",
     "timestamp": "2025-11-18T12:34:56.789Z"
   }
   ```

---

## 🐛 Troubleshooting

### Ошибка: "Puppeteer node not found"

**Причина**: n8n-nodes-puppeteer не установлен

**Решение**:
```bash
npm install n8n-nodes-puppeteer
# Перезапустите n8n
```

---

### Ошибка: "Browser not found" или "Chromium revision is not downloaded"

**Причина**: Chromium не установлен в системе

**Решение Ubuntu/Debian**:
```bash
sudo apt-get install chromium-browser
```

**Или укажите путь вручную**:
```bash
# Найдите путь к браузеру
which chromium-browser  # или google-chrome

# Установите переменную окружения
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Запустите n8n
n8n start
```

**В Docker**:
```yaml
environment:
  - PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
```

---

### Ошибка: "Timeout waiting for selector"

**Причина**: Селектор изменился на claude.ai или страница загружается слишком долго

**Решение**:
1. Откройте claude.ai в браузере
2. DevTools → Elements
3. Найдите актуальный селектор для поля ввода
4. Обновите в ноде "Puppeteer - Wait Input":
   ```javascript
   // Старый селектор
   div[contenteditable="true"]

   // Попробуйте альтернативный
   .ProseMirror[contenteditable="true"]
   ```

---

### Ошибка: "Invalid sessionKey" или 401 Unauthorized

**Причина**: Cookies устарели

**Решение**:
1. Получите новые cookies (см. раздел "Получение Credentials")
2. Обновите в ноде "Set Credentials"
3. Save и повторите запуск

---

### Ошибка: "Cannot extract response"

**Причина**: Структура HTML изменилась

**Решение**:
1. Откройте claude.ai → DevTools → Elements
2. Найдите элементы с ответами Claude
3. Проверьте актуальный атрибут `data-testid`:
   ```javascript
   // В ноде "Puppeteer - Extract Response"
   document.querySelectorAll('[data-testid="message"]')

   // Или попробуйте
   document.querySelectorAll('[data-testid="conversation-message"]')
   ```

---

## 🚀 Быстрый старт (все команды сразу)

```bash
# 1. Установка всех зависимостей
cd /home/user/n8n-workflow
npm install n8n n8n-nodes-puppeteer puppeteer

# 2. Установка Chromium (Ubuntu/Debian)
sudo apt-get update && sudo apt-get install -y chromium-browser

# 3. Скачивание workflow
mkdir -p workflows
cd workflows
curl -O https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json
cd ..

# 4. Запуск n8n
npx n8n start

# 5. Откройте в браузере
# http://localhost:5678

# 6. Импортируйте workflow из файла:
# workflows/claude-ai-via-n8n-nodes-puppeteer.json

# 7. Обновите credentials в ноде "Set Credentials"

# 8. Запустите workflow!
```

---

## 📊 Проверка установки

Выполните для проверки:

```bash
# Проверка Node.js
node --version  # должно быть >= v18.0.0

# Проверка npm
npm --version

# Проверка n8n
npx n8n --version

# Проверка n8n-nodes-puppeteer
npm list n8n-nodes-puppeteer

# Проверка Chromium
which chromium-browser || which google-chrome

# Тест Puppeteer
node -e "const puppeteer = require('puppeteer'); console.log('Puppeteer OK')"
```

---

## 🌐 Доступ к n8n

После запуска `n8n start`:

- **Локальный**: http://localhost:5678
- **Сетевой**: http://ВАШ_IP:5678

**Для доступа извне:**
```bash
# Запуск с привязкой к внешнему IP
n8n start --tunnel
```

Или настройте nginx reverse proxy:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:5678;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

---

## 📚 Дополнительные ресурсы

- [n8n Documentation](https://docs.n8n.io/)
- [n8n-nodes-puppeteer GitHub](https://github.com/drudge/n8n-nodes-puppeteer)
- [Puppeteer Documentation](https://pptr.dev/)
- [Community Nodes Guide](https://docs.n8n.io/integrations/community-nodes/)

---

## ✅ Чек-лист готовности

- [ ] Node.js >= v18.0.0 установлен
- [ ] npm установлен
- [ ] n8n установлен
- [ ] n8n-nodes-puppeteer установлен
- [ ] Chromium/Chrome установлен
- [ ] Workflow импортирован в n8n
- [ ] sessionKey получен из claude.ai
- [ ] __cf_bm получен из claude.ai
- [ ] Credentials обновлены в workflow
- [ ] n8n запущен
- [ ] Workflow успешно выполнился

---

**Готово! Теперь вы можете тестировать автоматизацию Claude.AI через n8n! 🎉**
