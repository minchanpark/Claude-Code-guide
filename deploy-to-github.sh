#!/bin/bash

echo "🚀 GitHub에 프로젝트를 올립니다..."
echo ""

# Git이 초기화되어 있는지 확인
if [ ! -d .git ]; then
    echo "📦 Git 초기화 중..."
    git init
    echo "✅ Git 초기화 완료"
    echo ""
fi

# 사용자에게 GitHub 리포지토리 URL 요청
echo "❓ GitHub 리포지토리 URL을 입력하세요:"
echo "   (예: https://github.com/username/claude-skills-demo.git)"
read -p "URL: " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "❌ URL이 입력되지 않았습니다."
    exit 1
fi

# 모든 파일 추가
echo ""
echo "📝 파일 추가 중..."
git add .

# 커밋
echo "💾 커밋 생성 중..."
git commit -m "Initial commit: Claude Skills Demo" || echo "이미 커밋된 내용이 있거나 변경사항이 없습니다."

# Remote 추가 (이미 있으면 무시)
echo "🔗 Remote 설정 중..."
git remote add origin $REPO_URL 2>/dev/null || git remote set-url origin $REPO_URL

# 메인 브랜치로 변경
git branch -M main

# Push
echo "⬆️  GitHub에 푸시 중..."
git push -u origin main

echo ""
echo "✅ GitHub에 성공적으로 업로드되었습니다!"
echo ""
echo "다음 단계:"
echo "1. Railway (https://railway.app) 또는 Render (https://render.com) 접속"
echo "2. 방금 생성한 GitHub 리포지토리 연결"
echo "3. 환경 변수 ANTHROPIC_API_KEY 설정"
echo "4. 배포 완료 후 노션에 URL embed!"
echo ""
echo "자세한 내용은 DEPLOYMENT.md 파일을 참고하세요."
