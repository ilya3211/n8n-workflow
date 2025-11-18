#!/bin/bash

# Скрипт для извлечения Cloudflare Turnstile sitekey из Claude.ai

echo "🔍 Загружаем страницу Claude.ai..."
HTML=$(curl -s -L "https://claude.ai/new" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8")

echo "📄 HTML загружен, ищем sitekey..."

# Метод 1: Поиск data-sitekey в атрибутах
SITEKEY1=$(echo "$HTML" | grep -oP 'data-sitekey=["'\'']\K[^"'\'']+')

# Метод 2: Поиск в скриптах
SITEKEY2=$(echo "$HTML" | grep -oP 'sitekey["\s:]+["'\'']\K[^"'\'']+')

# Метод 3: Поиск turnstile.render вызовов
SITEKEY3=$(echo "$HTML" | grep -oP 'turnstile\.render.*?sitekey.*?["'\'']\K[0-9A-Za-z_-]{30,}')

echo ""
echo "========================================"
echo "🔑 Найденные sitekey:"
echo "========================================"

if [ -n "$SITEKEY1" ]; then
  echo "✅ Метод 1 (data-sitekey): $SITEKEY1"
fi

if [ -n "$SITEKEY2" ]; then
  echo "✅ Метод 2 (sitekey в скрипте): $SITEKEY2"
fi

if [ -n "$SITEKEY3" ]; then
  echo "✅ Метод 3 (turnstile.render): $SITEKEY3"
fi

if [ -z "$SITEKEY1" ] && [ -z "$SITEKEY2" ] && [ -z "$SITEKEY3" ]; then
  echo "❌ Sitekey не найден автоматически"
  echo ""
  echo "💡 Возможные причины:"
  echo "   - Cloudflare загружается динамически через JavaScript"
  echo "   - Требуется аутентификация"
  echo "   - Sitekey загружается через отдельный API запрос"
  echo ""
  echo "📝 Попробуйте другие методы (через браузер)"
fi

echo "========================================"
