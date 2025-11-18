#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════════
# ГОТОВЫЕ КОМАНДЫ ДЛЯ ИСПОЛЬЗОВАНИЯ - jejopeguki.beget.app
# ═══════════════════════════════════════════════════════════════════════════════

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# БАЗОВАЯ ВЕРСИЯ
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Простой запрос
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи о квантовых компьютерах простым языком"
  }'

# С настройками модели
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай краткий план статьи о нейросетях",
    "model": "gemini-pro",
    "maxTokens": 2048
  }'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ПРОДВИНУТАЯ ВЕРСИЯ
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Полный запрос
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай детальный план статьи о машинном обучении",
    "model": "gemini-2.0-flash-exp",
    "temperature": 0.7,
    "maxTokens": 4096,
    "saveHistory": true
  }'

# Творческая генерация (высокая temperature)
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Напиши креативную историю о роботе",
    "temperature": 0.9,
    "maxTokens": 8192
  }'

# Точные ответы (низкая temperature)
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Дай точное определение квантовой запутанности",
    "temperature": 0.1,
    "maxTokens": 2048
  }'

# Анализ текста
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Проанализируй следующий текст и выдели ключевые моменты: [ваш текст]",
    "temperature": 0.3,
    "maxTokens": 2048
  }'

# Генерация контента для соцсетей
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Напиши пост для соцсетей о преимуществах AI",
    "temperature": 0.8,
    "maxTokens": 1024
  }'

# Техническая документация
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Создай техническую документацию для REST API endpoint",
    "temperature": 0.2,
    "maxTokens": 4096
  }'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ТЕСТИРОВАНИЕ И ДИАГНОСТИКА
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Тест базового workflow
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-automation \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"}' \
  -v

# Тест продвинутого workflow
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{"prompt": "test"}' \
  -v

# Проверка времени ответа
time curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет, это тест"
  }'

# С увеличенным timeout (180 секунд)
curl --max-time 180 -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Длинный запрос, который может занять время"
  }'

# Сохранить ответ в файл
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Расскажи о последних новостях в AI"
  }' \
  -o response.json

# Красивый вывод JSON (требует jq)
curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Привет!"
  }' | jq '.'

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# ПРИМЕРЫ ДЛЯ РАЗНЫХ ЯЗЫКОВ ПРОГРАММИРОВАНИЯ
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Python пример (сохраните как test.py)
cat > test.py << 'PYTHON'
import requests

url = "https://jejopeguki.beget.app/webhook/ai-studio-advanced"
payload = {
    "prompt": "Расскажи о последних новостях в AI",
    "temperature": 0.7,
    "maxTokens": 4096
}

response = requests.post(url, json=payload)
data = response.json()

if data.get('success'):
    print(f"Response: {data['response']}")
    print(f"Request ID: {data['request_id']}")
else:
    print(f"Error: {data.get('error')}")
PYTHON

# Node.js пример (сохраните как test.js)
cat > test.js << 'JAVASCRIPT'
const fetch = require('node-fetch');

async function askAI(prompt) {
  const url = 'https://jejopeguki.beget.app/webhook/ai-studio-advanced';

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      prompt: prompt,
      temperature: 0.7,
      maxTokens: 4096
    })
  });

  const data = await response.json();

  if (data.success) {
    console.log('Response:', data.response);
    console.log('Request ID:', data.request_id);
  } else {
    console.error('Error:', data.error);
  }
}

askAI('Расскажи о последних новостях в AI');
JAVASCRIPT

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# МАССОВЫЕ ЗАПРОСЫ (осторожно с rate limiting!)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Массовый запрос с задержкой
for i in {1..5}; do
  echo "Request $i..."
  curl -X POST https://jejopeguki.beget.app/webhook/ai-studio-advanced \
    -H "Content-Type: application/json" \
    -d "{
      \"prompt\": \"Вопрос номер $i: расскажи что-нибудь интересное\"
    }"
  echo ""
  sleep 5  # Задержка 5 секунд между запросами
done

# ═══════════════════════════════════════════════════════════════════════════════
# ИНФОРМАЦИЯ
# ═══════════════════════════════════════════════════════════════════════════════
#
# Домен: https://jejopeguki.beget.app/
# Базовый webhook: /webhook/ai-studio-automation
# Продвинутый webhook: /webhook/ai-studio-advanced
#
# Temperature:
#   0.0-0.3 = Точные, фактические ответы
#   0.4-0.7 = Сбалансированные (рекомендуется)
#   0.8-1.0 = Креативные, разнообразные
#
# MaxTokens:
#   512-1024   = Короткие ответы
#   2048-4096  = Средние (рекомендуется)
#   4096-8192  = Длинные детальные
#
# ═══════════════════════════════════════════════════════════════════════════════
