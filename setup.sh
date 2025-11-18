#!/bin/bash

# 🚀 Автоматическая установка n8n workflow для Claude.AI
# Скрипт устанавливает все зависимости и настраивает окружение

set -e  # Останавливаться при ошибках

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}  🚀 n8n Workflow Setup для Claude.AI с Puppeteer${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"

# Функция для логирования
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 1. Проверка Node.js
log_info "Проверка Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    log_success "Node.js установлен: $NODE_VERSION"

    # Проверка версии (должен быть >= 18)
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1 | sed 's/v//')
    if [ "$NODE_MAJOR" -lt 18 ]; then
        log_warning "Рекомендуется Node.js >= v18.0.0"
        log_info "Текущая версия: $NODE_VERSION"
    fi
else
    log_error "Node.js не установлен!"
    log_info "Установите Node.js: https://nodejs.org/"
    exit 1
fi

# 2. Проверка npm
log_info "Проверка npm..."
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    log_success "npm установлен: v$NPM_VERSION"
else
    log_error "npm не установлен!"
    exit 1
fi

# 3. Определение ОС
log_info "Определение операционной системы..."
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="Linux"
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$NAME
        log_success "ОС: $DISTRO"
    else
        log_warning "Не удалось определить дистрибутив Linux"
        OS="Unknown"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macOS"
    log_success "ОС: macOS"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    OS="Windows"
    log_success "ОС: Windows (через Git Bash/Cygwin)"
else
    OS="Unknown"
    log_warning "Неизвестная ОС: $OSTYPE"
fi

# 4. Установка Chromium/Chrome
log_info "Проверка браузера (Chromium/Chrome)..."

if command -v chromium &> /dev/null || command -v chromium-browser &> /dev/null || command -v google-chrome &> /dev/null; then
    BROWSER_PATH=$(command -v chromium || command -v chromium-browser || command -v google-chrome)
    log_success "Браузер найден: $BROWSER_PATH"
else
    log_warning "Chromium/Chrome не найден. Начинаем установку..."

    if [[ "$OS" == "Linux" ]]; then
        if command -v apt-get &> /dev/null; then
            log_info "Установка через apt-get..."
            sudo apt-get update
            sudo apt-get install -y chromium-browser
            log_success "Chromium установлен"
        elif command -v yum &> /dev/null; then
            log_info "Установка через yum..."
            sudo yum install -y chromium
            log_success "Chromium установлен"
        elif command -v dnf &> /dev/null; then
            log_info "Установка через dnf..."
            sudo dnf install -y chromium
            log_success "Chromium установлен"
        else
            log_warning "Не удалось автоматически установить Chromium"
            log_info "Установите вручную: sudo apt-get install chromium-browser"
        fi
    elif [[ "$OS" == "macOS" ]]; then
        if command -v brew &> /dev/null; then
            log_info "Установка через Homebrew..."
            brew install chromium
            log_success "Chromium установлен"
        else
            log_warning "Homebrew не найден. Установите вручную: brew install chromium"
        fi
    else
        log_warning "Автоматическая установка недоступна для вашей ОС"
        log_info "Установите Chromium/Chrome вручную"
    fi
fi

# 5. Установка n8n
log_info "Проверка n8n..."
if npm list n8n &> /dev/null || npm list -g n8n &> /dev/null; then
    log_success "n8n уже установлен"
else
    log_info "Установка n8n локально..."
    npm install n8n
    log_success "n8n установлен"
fi

# 6. Установка n8n-nodes-puppeteer
log_info "Проверка n8n-nodes-puppeteer..."
if npm list n8n-nodes-puppeteer &> /dev/null; then
    log_success "n8n-nodes-puppeteer уже установлен"
else
    log_info "Установка n8n-nodes-puppeteer..."
    npm install n8n-nodes-puppeteer
    log_success "n8n-nodes-puppeteer установлен"
fi

# 7. Установка Puppeteer
log_info "Проверка Puppeteer..."
if npm list puppeteer &> /dev/null; then
    log_success "Puppeteer уже установлен"
else
    log_info "Установка Puppeteer..."
    npm install puppeteer
    log_success "Puppeteer установлен"
fi

# 8. Проверка workflow файла
log_info "Проверка workflow файла..."
WORKFLOW_FILE="workflows/claude-ai-via-n8n-nodes-puppeteer.json"
if [ -f "$WORKFLOW_FILE" ]; then
    log_success "Workflow файл найден: $WORKFLOW_FILE"

    # Проверка количества нод
    if command -v jq &> /dev/null; then
        NODE_COUNT=$(jq '.nodes | length' "$WORKFLOW_FILE")
        log_info "Количество нод в workflow: $NODE_COUNT"
    fi
else
    log_warning "Workflow файл не найден"
    log_info "Скачивание с GitHub..."
    mkdir -p workflows
    curl -fsSL -o "$WORKFLOW_FILE" \
        "https://raw.githubusercontent.com/ilya3211/n8n-workflow/claude/claude-n8n-automation-workflow-019ZyGaGbj3EVNbpj2hqt8ia/workflows/claude-ai-via-n8n-nodes-puppeteer.json"

    if [ -f "$WORKFLOW_FILE" ]; then
        log_success "Workflow успешно скачан"
    else
        log_error "Не удалось скачать workflow"
    fi
fi

# 9. Создание .env файла (если не существует)
log_info "Проверка .env файла..."
if [ ! -f ".env" ]; then
    log_info "Создание .env файла..."
    cat > .env << 'EOF'
# n8n Configuration
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_HOST=localhost

# Puppeteer Configuration
PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Claude.AI Credentials (ОБНОВИТЕ ЗНАЧЕНИЯ!)
CLAUDE_SESSION_KEY=YOUR_SESSION_KEY_HERE
CLAUDE_CF_BM_COOKIE=YOUR_CF_BM_COOKIE_HERE

# n8n Basic Auth (опционально)
# N8N_BASIC_AUTH_ACTIVE=true
# N8N_BASIC_AUTH_USER=admin
# N8N_BASIC_AUTH_PASSWORD=your_password
EOF
    log_success ".env файл создан"
    log_warning "⚠️  Не забудьте обновить credentials в .env!"
else
    log_success ".env файл уже существует"
fi

# 10. Итоговая сводка
echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Установка завершена!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}\n"

log_success "Все зависимости установлены:"
echo "  • Node.js: $NODE_VERSION"
echo "  • npm: v$NPM_VERSION"
echo "  • n8n: ✅"
echo "  • n8n-nodes-puppeteer: ✅"
echo "  • Puppeteer: ✅"
echo "  • Chromium/Chrome: ✅"
echo "  • Workflow: ✅"

echo -e "\n${YELLOW}📝 Следующие шаги:${NC}\n"
echo "1. Получите credentials из claude.ai:"
echo "   ${BLUE}→ Откройте DevTools (F12) → Application → Cookies → https://claude.ai${NC}"
echo "   ${BLUE}→ Скопируйте: sessionKey и __cf_bm${NC}"
echo ""
echo "2. Обновите credentials:"
echo "   ${BLUE}→ В файле .env ИЛИ${NC}"
echo "   ${BLUE}→ В n8n UI (нода 'Set Credentials')${NC}"
echo ""
echo "3. Запустите n8n:"
echo "   ${GREEN}npx n8n start${NC}"
echo ""
echo "4. Откройте в браузере:"
echo "   ${GREEN}http://localhost:5678${NC}"
echo ""
echo "5. Импортируйте workflow:"
echo "   ${GREEN}workflows/claude-ai-via-n8n-nodes-puppeteer.json${NC}"
echo ""
echo "6. Запустите workflow и наслаждайтесь автоматизацией! 🚀"
echo ""

log_info "Для подробной инструкции см. SETUP_GUIDE.md"
echo -e "\n${BLUE}════════════════════════════════════════════════════════════${NC}\n"
