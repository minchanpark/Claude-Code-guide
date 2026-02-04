#!/bin/bash

echo "🌐 로컬 서버를 인터넷에 공개합니다 (Cloudflare Tunnel)"
echo ""

# Cloudflared 설치 확인
if ! command -v cloudflared &> /dev/null; then
    echo "📦 Cloudflared가 설치되어 있지 않습니다."
    echo ""
    read -p "지금 설치하시겠습니까? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "설치 중..."
        brew install cloudflared
        echo "✅ 설치 완료!"
        echo ""
    else
        echo "❌ Cloudflared가 필요합니다. 수동 설치:"
        echo "   brew install cloudflared"
        exit 1
    fi
fi

# API 키 확인
if ! grep -q "ANTHROPIC_API_KEY=sk-" .env 2>/dev/null; then
    echo "⚠️  경고: .env 파일에 ANTHROPIC_API_KEY가 설정되지 않았습니다!"
    echo ""
    read -p "계속하시겠습니까? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 가상 환경 활성화
if [ ! -d "venv" ]; then
    echo "❌ 가상 환경이 없습니다. 먼저 실행하세요:"
    echo "   python3 -m venv venv"
    echo "   source venv/bin/activate"
    echo "   pip install -r requirements.txt"
    exit 1
fi

echo "🚀 Flask 서버를 시작합니다..."
source venv/bin/activate
python main.py &
SERVER_PID=$!

# 서버가 시작될 때까지 대기
sleep 3

echo ""
echo "🌍 Cloudflare Tunnel을 시작합니다..."
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  생성된 URL을 노션에 embed 하세요!"
echo "  Ctrl+C를 눌러 종료할 수 있습니다"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Cloudflare Tunnel 시작
cloudflared tunnel --url http://localhost:5000

# 종료 시 Flask 서버도 종료
kill $SERVER_PID 2>/dev/null
echo ""
echo "✅ 서버가 종료되었습니다."
