#!/bin/bash

echo "════════════════════════════════════════════════════════"
echo "   🚀 Claude Skills Demo - 초간단 배포"
echo "════════════════════════════════════════════════════════"
echo ""

# Step 1: API 키 확인
echo "📝 Step 1/3: API 키 확인 중..."
if grep -q "ANTHROPIC_API_KEY=sk-" .env 2>/dev/null; then
    echo "   ✅ API 키가 설정되어 있습니다!"
else
    echo "   ⚠️  API 키가 설정되지 않았습니다!"
    echo ""
    echo "   .env 파일을 열어서 API 키를 입력해주세요:"
    echo "   ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxx"
    echo ""
    echo "   API 키 발급: https://console.anthropic.com"
    echo ""
    read -p "   설정 완료 후 Enter를 눌러주세요..."
fi

echo ""

# Step 2: Cloudflared 확인 및 설치
echo "🔧 Step 2/3: 도구 설치 확인 중..."
if ! command -v cloudflared &> /dev/null; then
    echo "   ⚠️  Cloudflared가 설치되어 있지 않습니다."
    echo ""
    read -p "   지금 자동으로 설치하시겠습니까? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "   📦 설치 중... (30초 소요)"
        brew install cloudflared
        echo "   ✅ 설치 완료!"
    else
        echo "   ❌ Cloudflared가 필요합니다."
        echo "   수동 설치: brew install cloudflared"
        exit 1
    fi
else
    echo "   ✅ Cloudflared가 설치되어 있습니다!"
fi

echo ""

# Step 3: 서버 시작
echo "🚀 Step 3/3: 서버 시작 중..."

# 가상 환경 확인
if [ ! -d "venv" ]; then
    echo "   ⚠️  가상 환경이 없습니다. 생성 중..."
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt > /dev/null 2>&1
    echo "   ✅ 가상 환경 생성 완료!"
else
    source venv/bin/activate
fi

# Flask 서버 시작
echo "   🔄 Flask 서버 시작 중..."
python main.py > /dev/null 2>&1 &
SERVER_PID=$!
sleep 3
echo "   ✅ Flask 서버 실행 중!"

echo ""
echo "════════════════════════════════════════════════════════"
echo "   🌍 인터넷에 공개 중..."
echo "════════════════════════════════════════════════════════"
echo ""
echo "   💡 아래에 표시되는 URL을 복사하세요!"
echo "   💡 노션에 붙여넣으면 embed됩니다!"
echo ""
echo "   ⏹️  종료하려면 Ctrl+C를 누르세요"
echo ""
echo "────────────────────────────────────────────────────────"
echo ""

# Cloudflare Tunnel 시작
cloudflared tunnel --url http://localhost:5000

# 종료 시 정리
kill $SERVER_PID 2>/dev/null
echo ""
echo "════════════════════════════════════════════════════════"
echo "   ✅ 서버가 종료되었습니다. 감사합니다!"
echo "════════════════════════════════════════════════════════"
