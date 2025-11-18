#!/usr/bin/env python3
"""
Скрипт для автоматического извлечения Cloudflare Turnstile sitekey из Claude.ai
Требует: pip install requests beautifulsoup4
"""

import re
import requests
from bs4 import BeautifulSoup

def find_sitekey_in_html(url="https://claude.ai/new"):
    """
    Извлекает Turnstile sitekey из HTML страницы
    """
    print(f"🔍 Загружаем страницу: {url}")

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.9',
    }

    try:
        response = requests.get(url, headers=headers, timeout=30)
        response.raise_for_status()
        html = response.text

        print("✅ Страница загружена, ищем sitekey...")

        results = []

        # Метод 1: BeautifulSoup поиск data-sitekey атрибута
        soup = BeautifulSoup(html, 'html.parser')

        # Поиск элементов с data-sitekey
        elements_with_sitekey = soup.find_all(attrs={'data-sitekey': True})
        for element in elements_with_sitekey:
            sitekey = element.get('data-sitekey')
            results.append({
                'method': 'data-sitekey attribute',
                'sitekey': sitekey,
                'element': element.name
            })

        # Метод 2: Regex поиск в HTML
        # Поиск data-sitekey="..."
        pattern1 = r'data-sitekey=["\']([\w-]+)["\']'
        matches1 = re.findall(pattern1, html)
        for match in matches1:
            results.append({
                'method': 'regex: data-sitekey',
                'sitekey': match
            })

        # Поиск sitekey: "..."
        pattern2 = r'sitekey[\s:]+["\']([\w-]+)["\']'
        matches2 = re.findall(pattern2, html)
        for match in matches2:
            results.append({
                'method': 'regex: sitekey property',
                'sitekey': match
            })

        # Поиск turnstile.render(..., {sitekey: "..."})
        pattern3 = r'turnstile\.render\([^)]*sitekey[\s:]+["\']([\w-]+)["\']'
        matches3 = re.findall(pattern3, html)
        for match in matches3:
            results.append({
                'method': 'regex: turnstile.render',
                'sitekey': match
            })

        # Метод 3: Поиск в iframe src
        iframes = soup.find_all('iframe', src=re.compile(r'challenges\.cloudflare\.com'))
        for iframe in iframes:
            src = iframe.get('src', '')
            sitekey_match = re.search(r'[?&]sitekey=([\w-]+)', src)
            if sitekey_match:
                results.append({
                    'method': 'iframe src',
                    'sitekey': sitekey_match.group(1)
                })

        # Удаляем дубликаты
        unique_sitekeys = []
        seen = set()
        for item in results:
            sitekey = item['sitekey']
            if sitekey not in seen:
                seen.add(sitekey)
                unique_sitekeys.append(item)

        # Выводим результаты
        print("\n" + "="*50)
        print("🔑 Найденные Sitekeys:")
        print("="*50)

        if unique_sitekeys:
            for i, item in enumerate(unique_sitekeys, 1):
                print(f"\n{i}. Метод: {item['method']}")
                print(f"   Sitekey: {item['sitekey']}")
                if 'element' in item:
                    print(f"   Элемент: <{item['element']}>")

            print("\n" + "="*50)
            print(f"✅ Рекомендуется использовать: {unique_sitekeys[0]['sitekey']}")
            print("="*50)

            return unique_sitekeys[0]['sitekey']
        else:
            print("\n❌ Sitekey не найден автоматически")
            print("\n💡 Возможные причины:")
            print("   - Cloudflare загружается динамически через JavaScript")
            print("   - Требуется аутентификация или куки")
            print("   - Sitekey загружается через отдельный API запрос")
            print("\n📝 Попробуйте другие методы (через браузер)")
            print("="*50)
            return None

    except requests.exceptions.RequestException as e:
        print(f"\n❌ Ошибка при загрузке страницы: {e}")
        return None
    except Exception as e:
        print(f"\n❌ Непредвиденная ошибка: {e}")
        return None

if __name__ == "__main__":
    sitekey = find_sitekey_in_html()

    if sitekey:
        print(f"\n📋 Скопируйте этот sitekey в n8n workflow:")
        print(f"   {sitekey}")
