# ☁️ GCP & AWS 배포 가이드

Flask 서버를 GCP나 AWS에 직접 배포하는 방법입니다.

---

## 🔵 Google Cloud Platform (GCP) 배포

### Option 1: Cloud Run (가장 추천!) ⭐⭐⭐⭐⭐

#### 장점
- ✅ **완전 무료 티어** (월 200만 요청)
- ✅ 자동 스케일링 (0 → ∞)
- ✅ HTTPS 자동 제공
- ✅ 컨테이너 기반
- ✅ 사용한 만큼만 과금

#### 배포 단계

##### 1. Dockerfile 생성
이미 준비되어 있습니다!

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# 의존성 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 앱 복사
COPY . .

# 포트 설정
ENV PORT=8080
EXPOSE 8080

# 실행
CMD ["python", "main.py"]
```

##### 2. GCP 설정

```bash
# Google Cloud SDK 설치 (Mac)
brew install --cask google-cloud-sdk

# 로그인
gcloud auth login

# 프로젝트 생성 또는 선택
gcloud projects create claude-skills-demo
gcloud config set project claude-skills-demo

# Cloud Run API 활성화
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

##### 3. 배포 (한 줄!)

```bash
cd /Users/minchanpark/Downloads/claude-code

# Cloud Run에 배포
gcloud run deploy claude-skills \
  --source . \
  --region asia-northeast3 \
  --allow-unauthenticated \
  --set-env-vars ANTHROPIC_API_KEY=your-api-key-here
```

**완료!** 2-3분 후 URL이 생성됩니다:
```
https://claude-skills-xxxxx-an.a.run.app
```

##### 4. 자동 배포 설정 (GitHub 연동)

```bash
# GitHub 연결
gcloud run services update claude-skills \
  --region asia-northeast3 \
  --source https://github.com/minchanpark/Claude-Code-guide
```

---

### Option 2: App Engine

```bash
# app.yaml 생성 필요
cat > app.yaml << EOF
runtime: python311
entrypoint: python main.py

env_variables:
  ANTHROPIC_API_KEY: "your-api-key-here"
EOF

# 배포
gcloud app deploy
```

---

## 🟠 Amazon Web Services (AWS) 배포

### Option 1: Elastic Beanstalk (가장 쉬움) ⭐⭐⭐⭐⭐

#### 장점
- ✅ 설정 간단
- ✅ 자동 스케일링
- ✅ 로드 밸런싱 포함
- ✅ 무료 티어 (EC2 포함)

#### 배포 단계

##### 1. EB CLI 설치

```bash
# Mac
brew install awsebcli

# AWS 자격증명 설정
aws configure
# Access Key ID 입력
# Secret Access Key 입력
# Region: ap-northeast-2 (서울)
```

##### 2. 프로젝트 초기화

```bash
cd /Users/minchanpark/Downloads/claude-code

# Elastic Beanstalk 초기화
eb init -p python-3.11 claude-skills-demo --region ap-northeast-2

# 환경 생성 및 배포
eb create claude-skills-env

# 환경 변수 설정
eb setenv ANTHROPIC_API_KEY=your-api-key-here

# 브라우저에서 열기
eb open
```

##### 3. 자동 배포 설정

```bash
# .ebignore 파일 생성
cat > .ebignore << EOF
venv/
__pycache__/
*.pyc
.env
.git/
EOF

# 업데이트 배포
eb deploy
```

---

### Option 2: EC2 (수동 설정)

#### 1. EC2 인스턴스 생성
- AWS Console → EC2 → Launch Instance
- Ubuntu 22.04 선택
- t2.micro (무료 티어)
- 보안 그룹: HTTP (80), HTTPS (443) 허용

#### 2. SSH 접속 및 설정

```bash
# SSH 접속
ssh -i "your-key.pem" ubuntu@your-ec2-ip

# 서버 설정
sudo apt update
sudo apt install python3-pip nginx -y

# 프로젝트 클론
git clone https://github.com/minchanpark/Claude-Code-guide.git
cd Claude-Code-guide

# 의존성 설치
pip3 install -r requirements.txt

# 환경 변수 설정
echo "ANTHROPIC_API_KEY=your-api-key" > .env

# Gunicorn 설치 및 실행
pip3 install gunicorn
gunicorn -w 4 -b 0.0.0.0:8000 main:app
```

#### 3. Nginx 설정

```nginx
# /etc/nginx/sites-available/claude-skills
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

#### 4. 서비스 자동 시작

```bash
# systemd 서비스 생성
sudo nano /etc/systemd/system/claude-skills.service

# 내용:
[Unit]
Description=Claude Skills Demo
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/Claude-Code-guide
Environment="PATH=/home/ubuntu/.local/bin"
ExecStart=/home/ubuntu/.local/bin/gunicorn -w 4 -b 0.0.0.0:8000 main:app

[Install]
WantedBy=multi-user.target

# 서비스 시작
sudo systemctl start claude-skills
sudo systemctl enable claude-skills
```

---

## 📊 플랫폼 비교

| 플랫폼 | 난이도 | 무료 티어 | 자동 스케일링 | HTTPS | 추천도 |
|--------|--------|-----------|---------------|-------|--------|
| **GCP Cloud Run** | ⭐ 쉬움 | ✅ 200만 요청/월 | ✅ | ✅ | ⭐⭐⭐⭐⭐ |
| **GCP App Engine** | ⭐⭐ 중간 | ✅ 28시간/일 | ✅ | ✅ | ⭐⭐⭐⭐ |
| **AWS Elastic Beanstalk** | ⭐⭐ 중간 | ✅ 750시간/월 | ✅ | ⚠️ 설정 필요 | ⭐⭐⭐⭐⭐ |
| **AWS EC2** | ⭐⭐⭐⭐ 어려움 | ✅ 750시간/월 | ❌ | ⚠️ 설정 필요 | ⭐⭐⭐ |

---

## 🎯 최종 추천

### 가장 쉬운 방법
**GCP Cloud Run** - 한 줄 명령어로 배포

```bash
gcloud run deploy claude-skills \
  --source . \
  --region asia-northeast3 \
  --allow-unauthenticated \
  --set-env-vars ANTHROPIC_API_KEY=sk-ant-xxxxx
```

### AWS 사용자라면
**Elastic Beanstalk** - EB CLI로 간단히

```bash
eb init -p python-3.11 claude-skills
eb create claude-skills-env
eb setenv ANTHROPIC_API_KEY=sk-ant-xxxxx
```

---

## 💰 비용 예상

### GCP Cloud Run (무료 티어)
- 요청: 200만 회/월 무료
- CPU: 180,000 vCPU-초/월 무료
- 메모리: 360,000 GiB-초/월 무료
- **예상**: 월 1만 요청 시 → **무료**

### AWS Elastic Beanstalk (무료 티어)
- EC2 t2.micro: 750시간/월 무료 (1년)
- **예상**: 소규모 트래픽 → **무료** (1년)

---

## 🚀 빠른 시작 (GCP Cloud Run)

### 필요한 파일 준비

```bash
cd /Users/minchanpark/Downloads/claude-code
```

Dockerfile이 필요합니다:

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV PORT=8080
EXPOSE 8080
CMD ["python", "main.py"]
```

### 배포 실행

```bash
# 1회만: gcloud 설치 및 로그인
brew install --cask google-cloud-sdk
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# 배포 (5분 소요)
gcloud run deploy claude-skills \
  --source . \
  --region asia-northeast3 \
  --allow-unauthenticated \
  --set-env-vars ANTHROPIC_API_KEY=sk-ant-xxxxx \
  --platform managed
```

---

## ❓ FAQ

### Q: GCP vs AWS 중 뭐가 더 쉬운가요?
**A:** GCP Cloud Run이 가장 쉽습니다. 한 줄로 배포 가능.

### Q: 비용이 얼마나 나오나요?
**A:** 소규모 프로젝트는 둘 다 무료 티어 내에서 가능합니다.

### Q: 도메인 연결은?
**A:** 둘 다 커스텀 도메인 연결 지원. GCP는 자동 SSL 제공.

### Q: 가장 저렴한 방법은?
**A:** GCP Cloud Run → 사용한 만큼만 과금, 0 요청 시 $0

---

더 자세한 내용이 필요하시면 말씀해주세요! 🚀
