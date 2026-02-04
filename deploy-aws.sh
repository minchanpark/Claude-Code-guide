#!/bin/bash

echo "☁️  AWS Elastic Beanstalk에 배포합니다"
echo ""

# EB CLI 확인
if ! command -v eb &> /dev/null; then
    echo "❌ EB CLI가 설치되어 있지 않습니다."
    echo "설치: brew install awsebcli"
    exit 1
fi

# AWS 설정 확인
if ! aws sts get-caller-identity &> /dev/null; then
    echo "❌ AWS 자격증명이 설정되지 않았습니다."
    echo "실행: aws configure"
    exit 1
fi

echo "✅ AWS 설정 확인 완료"
echo ""

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

# EB 초기화 (이미 되어있으면 스킵)
if [ ! -d ".elasticbeanstalk" ]; then
    echo "🔧 Elastic Beanstalk 초기화 중..."
    eb init -p python-3.11 claude-skills-demo --region ap-northeast-2
fi

echo ""
echo "🚀 Elastic Beanstalk에 배포 중... (5-7분 소요)"
echo ""

# 환경이 없으면 생성
if ! eb list | grep -q "claude-skills-env"; then
    eb create claude-skills-env
else
    eb deploy
fi

# 환경 변수 설정
echo "🔐 환경 변수 설정 중..."
eb setenv ANTHROPIC_API_KEY=$API_KEY

echo ""
echo "✅ 배포 완료!"
echo ""
echo "브라우저에서 열기:"
eb open
