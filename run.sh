#!/bin/bash

# 가상 환경이 활성화되어 있는지 확인
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "가상 환경을 활성화합니다..."
    source venv/bin/activate
fi

# API 키 확인
if ! grep -q "ANTHROPIC_API_KEY=sk-" .env 2>/dev/null; then
    echo "⚠️  경고: .env 파일에 ANTHROPIC_API_KEY가 설정되지 않았습니다!"
    echo ""
    echo "다음 단계를 따라주세요:"
    echo "1. .env 파일을 열어주세요"
    echo "2. ANTHROPIC_API_KEY=your_api_key_here 를 실제 API 키로 변경하세요"
    echo "3. API 키는 https://console.anthropic.com/ 에서 발급받을 수 있습니다"
    echo ""
    read -p "API 키를 설정했다면 Enter를 눌러 계속하세요..."
fi

echo "Flask 애플리케이션을 시작합니다..."
python main.py
