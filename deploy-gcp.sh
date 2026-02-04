#!/bin/bash

echo "☁️  GCP Cloud Run에 배포합니다"
echo ""

# 프로젝트 ID 확인
read -p "GCP Project ID를 입력하세요: " PROJECT_ID

if [ -z "$PROJECT_ID" ]; then
    echo "❌ Project ID가 필요합니다."
    exit 1
fi

# API 키 확인
if [ ! -f ".env" ]; then
    echo "❌ .env 파일이 없습니다. API 키를 설정해주세요."
    exit 1
fi

API_KEY=$(grep ANTHROPIC_API_KEY .env | cut -d '=' -f2)

if [ -z "$API_KEY" ]; then
    echo "❌ .env 파일에 ANTHROPIC_API_KEY가 없습니다."
    exit 1
fi

echo "✅ API 키 확인 완료"
echo ""

# gcloud 확인
if ! command -v gcloud &> /dev/null; then
    echo "❌ gcloud CLI가 설치되어 있지 않습니다."
    echo "설치: brew install --cask google-cloud-sdk"
    exit 1
fi

echo "🔧 GCP 프로젝트 설정 중..."
gcloud config set project $PROJECT_ID

echo ""
echo "🚀 Cloud Run에 배포 중... (2-3분 소요)"
echo ""

gcloud run deploy claude-skills \
  --source . \
  --region asia-northeast3 \
  --allow-unauthenticated \
  --set-env-vars ANTHROPIC_API_KEY=$API_KEY \
  --platform managed

echo ""
echo "✅ 배포 완료!"
echo ""
echo "URL을 노션에 embed 하세요!"
