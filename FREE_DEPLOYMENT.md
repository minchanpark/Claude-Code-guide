# 🆓 완전 무료 배포 가이드

Railway가 결제를 요구한다면, 완전 무료로 배포할 수 있는 방법들입니다!

---

## 🎯 추천 순서 (100% 무료 검증됨)

1. **PythonAnywhere** - 영구 무료, 안정적, sleep 없음 ⭐⭐⭐⭐⭐
2. **Render 무료 티어** - 영구 무료, sleep 모드 있음 ⭐⭐⭐⭐
3. **Cloudflare Tunnel** - 내 컴퓨터를 서버로, 100% 무료 ⭐⭐⭐⭐
4. **Glitch** - 무료, 코드 에디터 제공 ⭐⭐⭐

---

## Option 1: PythonAnywhere (가장 추천!) 🌟

### 장점
- ✅ **완전 무료** (영구적)
- ✅ 안정적인 서버
- ✅ Python 전용 호스팅
- ✅ Sleep 모드 없음
- ✅ HTTPS 기본 제공

### 무료 티어 제한
- 1개의 웹 앱
- 매일 재시작 필요 (3개월마다)
- CPU/대역폭 제한

### 배포 방법

#### 1단계: PythonAnywhere 계정 생성
1. https://www.pythonanywhere.com 접속
2. "Start running Python online in less than a minute!" 클릭
3. **Beginner account** 선택 (무료)
4. 계정 생성

#### 2단계: 파일 업로드

**방법 A: GitHub에서 Clone**
```bash
# PythonAnywhere Bash 콘솔에서
git clone https://github.com/minchanpark/Claude-Code-guide.git
cd Claude-Code-guide
```

**방법 B: 수동 업로드**
1. Files 탭 클릭
2. Upload 버튼으로 파일들 업로드

#### 3단계: 가상 환경 생성
```bash
# Bash 콘솔에서
cd ~/Claude-Code-guide
python3.10 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

#### 4단계: Web App 설정
1. **Web** 탭 클릭
2. "Add a new web app" 클릭
3. "Manual configuration" 선택
4. Python 3.10 선택

#### 5단계: WSGI 설정
"WSGI configuration file" 링크 클릭 후 다음으로 교체:

```python
import sys
import os

# 프로젝트 경로 추가
path = '/home/YOUR_USERNAME/Claude-Code-guide'
if path not in sys.path:
    sys.path.append(path)

# 환경 변수 설정
os.environ['ANTHROPIC_API_KEY'] = 'your-api-key-here'

# 가상 환경 활성화
activate_this = '/home/YOUR_USERNAME/Claude-Code-guide/venv/bin/activate_this.py'
with open(activate_this) as file_:
    exec(file_.read(), dict(__file__=activate_this))

# Flask 앱 import
from main import app as application
```

#### 6단계: Virtualenv 설정
1. Web 탭에서 "Virtualenv" 섹션 찾기
2. Path 입력: `/home/YOUR_USERNAME/Claude-Code-guide/venv`

#### 7단계: 재로드
- "Reload" 버튼 클릭
- 완료! URL: `https://YOUR_USERNAME.pythonanywhere.com`

---

## Option 2: Render (완전 무료)

### 장점
- ✅ **완전 무료** (영구적)
- ✅ GitHub 자동 배포
- ✅ HTTPS 기본 제공

### 단점
- ⚠️ 15분 비활성 시 sleep 모드
- 첫 요청 시 30초-1분 로딩

### 배포 방법

#### 1단계: GitHub 업로드 (이미 완료)
```bash
# 이미 minchanpark/Claude-Code-guide에 있음!
```

#### 2단계: Render 배포
1. https://render.com 접속
2. "Get Started for Free" 클릭
3. GitHub 계정 연결
4. "New +" → "Web Service" 클릭
5. `Claude-Code-guide` 리포지토리 선택

#### 3단계: 설정
```
Name: claude-skills-demo
Environment: Python 3
Build Command: pip install -r requirements.txt
Start Command: python main.py
Instance Type: Free
```

#### 4단계: 환경 변수
1. "Environment" 탭
2. "Add Environment Variable" 클릭
```
Key: ANTHROPIC_API_KEY
Value: your-actual-api-key
```

#### 5단계: Deploy
- "Create Web Service" 클릭
- 5-10분 후 배포 완료
- URL: `https://claude-skills-demo.onrender.com`

---

## Option 3: 로컬 서버 + Cloudflare Tunnel ⚡

### 장점
- ✅ **완전 무료**
- ✅ 내 컴퓨터가 서버
- ✅ Sleep 모드 없음 (컴퓨터 켜져있으면)
- ✅ 무제한 리소스

### 단점
- ⚠️ 컴퓨터가 꺼지면 서비스 중단
- ⚠️ 인터넷 연결 필요

### 배포 방법

#### 1단계: Cloudflared 설치
```bash
# macOS
brew install cloudflared

# Windows
# https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation/
```

#### 2단계: 로컬 서버 실행
```bash
cd /Users/minchanpark/Downloads/claude-code
source venv/bin/activate
python main.py
```

#### 3단계: Cloudflare Tunnel 시작
```bash
# 새 터미널에서
cloudflared tunnel --url http://localhost:5000
```

출력 예시:
```
Your quick Tunnel has been created! Visit it at:
https://random-name-1234.trycloudflare.com
```

#### 4단계: 노션에 Embed
- 생성된 URL을 노션에 embed!
- 컴퓨터가 켜져있는 동안 작동

### 영구적으로 만들기 (선택사항)

```bash
# Cloudflare 계정 로그인
cloudflared login

# 터널 생성
cloudflared tunnel create claude-skills

# 설정 파일 생성
nano ~/.cloudflared/config.yml
```

`config.yml`:
```yaml
tunnel: <TUNNEL-ID>
credentials-file: /Users/YOUR_USER/.cloudflared/<TUNNEL-ID>.json

ingress:
  - hostname: your-domain.com  # 또는 Cloudflare 제공 도메인
    service: http://localhost:5000
  - service: http_status:404
```

```bash
# 터널 실행
cloudflared tunnel run claude-skills
```

---

## Option 4: ngrok (대안)

Cloudflare 대신 ngrok 사용:

```bash
# ngrok 설치
brew install ngrok

# 계정 생성 및 토큰 설정
ngrok config add-authtoken YOUR_AUTHTOKEN

# 터널 시작
ngrok http 5000
```

무료 티어:
- 1개의 ngrok 프로세스
- 임의의 URL (매번 변경됨)
- 제한적인 대역폭

---

## Option 5: Glitch (코드 에디터 제공)

### 장점
- ✅ **완전 무료**
- ✅ 웹 기반 코드 에디터
- ✅ HTTPS 기본 제공
- ✅ 간단한 설정

### 단점
- ⚠️ 5분 비활성 시 sleep
- ⚠️ 제한적인 리소스

### 배포 방법

#### 1단계: Glitch 계정 생성
1. https://glitch.com 접속
2. "Sign in" 클릭 (GitHub 계정 사용 가능)

#### 2단계: 새 프로젝트 생성
1. "New Project" 클릭
2. "Import from GitHub" 선택
3. `https://github.com/minchanpark/Claude-Code-guide` 입력

#### 3단계: 환경 변수 설정
1. 좌측 "Tools" 클릭
2. "Secrets" (.env) 선택
3. 추가:
``` (2026년 검증)

| 플랫폼 | 영구 무료 | Sleep 모드 | 안정성 | 속도 | 난이도 |
|--------|-----------|-----------|--------|------|--------|
| **PythonAnywhere** | ✅ | ❌ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 중간 |
| **Render** | ✅ | ✅ (15분) | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 쉬움 |
| **Cloudflare Tunnel** | ✅ | ❌ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 쉬움 |
| **Glitch** | ✅ | ✅ (5분) | ⭐⭐⭐ | ⭐⭐⭐ | 쉬움 |
| **ngrok** | ✅ | ❌ | ⭐⭐⭐ | ⭐⭐⭐⭐ | 쉬움 |
| ~~Replit~~ | ❌ 유료 | ✅ | ⭐⭐⭐ | ⭐⭐⭐ | 쉬움 |
| ~~Railway~~ | ❌ 크레딧 | ❌ | ⭐⭐⭐⭐ | ⭐
### 주의사항
- ⚠️ Replit은 Always On이 유료이므로 추천하지 않음
- ⚠️ Glitch도 5분 sleep이 있지만 첫 요청 시 빠르게 깨어남

---

## 🎯 최종 추천

### 실제 서비스용 (24/7 안정성)
**PythonAnywhere** → 무료, 안정적, sleep 없음

### 데모/테스트용 (가끔 사용)
**Render** → 무료, GitHub 연동, sleep 있음

### 개인 사용 (컴퓨터 켜져있을 때)
**Cloudflare Tunnel** → 무료, 로컬, 빠름

### 빠른 프로토타입
**Replit** → 가장 쉬움

---

## 📊 무료 옵션 비교

| 플랫폼 | 완전 무료 | Sleep 모드 | 안정성 | 속도 | 난이도 |
|--------|-----------|-----------|--------|------|--------|
| **PythonAnywhere** | ✅ | ❌ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 중간 |
| **Render** | ✅ | ✅ (15분) | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 쉬움 |
| **Cloudflare Tunnel** | ✅ | ❌ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 중간 |
| **Replit** | ✅ | ✅ | ⭐⭐⭐ | ⭐⭐⭐ | 매우 쉬움 |
| **ngrok** | ✅ | ❌ | ⭐⭐⭐ | ⭐⭐⭐⭐ | 쉬움 |

---

## 💡 추천 전략

### 시나리오 1: 하루 종일 컴퓨터 켜놓음
→ **Cloudflare Tunnel** 사용

### 시나리오 2: 가끔씩만 사용
→ **Render** 사용 (sleep 괜찮음)

### 시나리오 3: 항상 접근 가능해야 함
→ **PythonAnywhere** 사용
Cloudflare Tunnel** 사용 (로컬에서 바로)
### 시나리오 4: 5분만에 테스트
→ **Replit** 사용

---

## 🚀 지금 바로 시작하기

### 가장 빠른 방법 (Cloudflare Tunnel)

```bash
# 1. Cloudflared 설치
brew install cloudflared

# 2. 프로젝트로 이동
cd /Users/minchanpark/Downloads/claude-code

# 3. 가상환경 활성화 및 서버 실행
source venv/bin/activate
python main.py &

# 4. 터널 시작
cloudflared tunnel --url http://localhost:5000
```

생성된 URL을 노션에 embed! ✨

---

## ❓ FAQ

### Q: 서버를 직접 배포해야 하나요?
A: Flask는 서버가 필요합니다. 옵션들:
- PythonAnywhere/Render: 서버를 제공해줌
- Cloudflare Tunnel: 내 컴퓨터가 서버
Cloudflare Tunnel** - 터미널에서 `./run-public.sh` 한 번이면 완료 (1분)
### Q: 가장 간단한 무료 방법은?
A: **Render** - GitHub 연동하고 클릭 몇 번이면 완료

### Q: Sleep 모드 없이 무료로?
A: **PythonAnywhere** - 유일한 옵션

### Q: 노션 embed가 작동하나요?
A: 모든 옵션에서 HTTPS URL이 제공되므로 작동합니다!

---

**궁금한 점이 있으시면 언제든 질문해주세요!** 🎉
