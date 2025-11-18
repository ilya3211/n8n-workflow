# 🔗 Прямые ссылки для импорта workflows в n8n

## Google AI Studio Automation (Browserless)

### Базовая версия
**Описание:** Простая автоматизация с основными функциями
**URL для импорта:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-automation.json
```

### Продвинутая версия
**Описание:** Расширенные возможности с валидацией и сохранением истории
**URL для импорта:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-advanced.json
```

### Документация
**URL:**
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/GOOGLE_AI_STUDIO_AUTOMATION_README.md
```

---

## 📝 Как импортировать в n8n через URL

### Способ 1: Import from URL (рекомендуется)
1. Откройте n8n
2. Перейдите в раздел **Workflows**
3. Нажмите кнопку **"+"** → **Import from URL**
4. Скопируйте и вставьте одну из ссылок выше
5. Нажмите **Import**
6. Настройте credentials для Browserless
7. Активируйте workflow

### Способ 2: Curl + Import from File
```bash
# Скачать базовую версию
curl -o google-ai-studio-basic.json "https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-automation.json"

# Скачать продвинутую версию
curl -o google-ai-studio-advanced.json "https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-advanced.json"

# Затем импортируйте файл через n8n UI
```

### Способ 3: Wget + Import from File
```bash
# Скачать базовую версию
wget "https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-automation.json" -O google-ai-studio-basic.json

# Скачать продвинутую версию
wget "https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/google-ai-studio-browserless-advanced.json" -O google-ai-studio-advanced.json
```

---

## 🔧 Быстрая настройка после импорта

### 1. Установите Browserless (Docker)
```bash
# Запуск без токена (для локального тестирования)
docker run -p 3000:3000 browserless/chrome

# Запуск с токеном (для продакшена)
docker run -p 3000:3000 -e "TOKEN=your-secure-token" browserless/chrome
```

### 2. Настройте Credentials в n8n
1. **Settings → Credentials → Add Credential**
2. Выберите **"Browserless API"**
3. Заполните:
   - **Name:** `Browserless API`
   - **Base URL:** `ws://localhost:3000` (или ваш URL)
   - **API Token:** ваш токен (если используется)
4. Сохраните

### 3. Проверьте настройки в Workflow
Откройте импортированный workflow и проверьте:
- ✅ Все узлы используют правильный Browserless credential
- ✅ URL Browserless корректен
- ✅ Timeout настроен правильно (по умолчанию 60-90 секунд)

### 4. Тестирование
1. Откройте workflow
2. Нажмите **"Execute Workflow"** на Manual Trigger
3. Проверьте результат в последнем узле
4. Если есть ошибки, проверьте логи и скриншоты

---

## 🌐 Альтернативные ссылки (после мерджа в main)

После того как PR будет смержен в main, используйте эти короткие ссылки:

### Базовая версия
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/main/workflows/google-ai-studio-browserless-automation.json
```

### Продвинутая версия
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/main/workflows/google-ai-studio-browserless-advanced.json
```

### Документация
```
https://raw.githubusercontent.com/ilya3211/n8n-workflow/main/workflows/GOOGLE_AI_STUDIO_AUTOMATION_README.md
```

---

## 📞 Поддержка

Если у вас возникли проблемы с импортом:
1. Убедитесь, что URL скопирован полностью
2. Проверьте доступ к GitHub (если за корпоративным firewall)
3. Попробуйте скачать файл вручную через браузер
4. Проверьте версию n8n (требуется 1.0+)

---

## 📚 Дополнительные ресурсы

- [GitHub Repository](https://github.com/ilya3211/n8n-workflow)
- [n8n Documentation](https://docs.n8n.io/)
- [Browserless Documentation](https://www.browserless.io/docs)
- [Полная документация по автоматизации](https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/automate-google-ai-studio-01MvGTwwZs9rKG6a5jgs9gkK/workflows/GOOGLE_AI_STUDIO_AUTOMATION_README.md)

---

**Последнее обновление:** 2025-11-18
**Версия workflows:** 1.0.0
**Совместимость:** n8n 1.0+, Browserless 2.0+
