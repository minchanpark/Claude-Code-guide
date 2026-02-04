# 🚀 배포 가이드

## 목차
1. [Replit 배포 (가장 쉬움)](#option-1-replit)
2. [Railway 배포 (추천)](#option-2-railway)
3. [Render 배포](#option-3-render)
4. [노션에 삽입하기](#notion-embed)

---

## Option 1: Replit 배포 (가장 쉬움)

### 1단계: Replit 계정 생성
1. https://replit.com 접속
2. 계정 생성/로그인

### 2단계: 새 Repl 생성
1. "Create Repl" 클릭
2. Template: **Python** 선택
3. Title: 원하는 프로젝트 이름 입력 (예: `claude-skills-demo`)
4. "Create Repl" 클릭

### 3단계: 파일 업로드
다음 파일들을 Replit에 업로드:
- `main.py`
- `requirements.txt`
- `templates/index.html`

### 4단계: Secrets 설정 (중요!)
1. 좌측 메뉴에서 **"Tools"** → **"Secrets"** 클릭
2. 새 Secret 추가:
   - Key: `ANTHROPIC_API_KEY`
   - Value: 실제 Anthropic API 키 입력 (https://console.anthropic.com 에서 발급)
3. "Add new secret" 클릭

### 5단계: 실행
1. 상단의 **"Run"** 버튼 클릭
2. 자동으로 패키지가 설치되고 서버가 시작됩니다
3. 우측 상단에 배포 URL이 표시됩니다
   - 예: `https://claude-skills-demo.username.repl.co`

### 6단계: Always On (선택사항)
- **무료 티어**: 일정 시간 사용하지 않으면 sleep 모드
- **유료 플랜**: Always On 기능으로 24/7 실행 가능

---

## Option 2: Railway 배포 (추천)

### 장점
- 무료 크레딧 $5/월 제공
- GitHub 연동 자동 배포
- 안정적이고 빠름

### 1단계: GitHub에 코드 올리기

```bash
cd /Users/minchanpark/Downloads/claude-code

# Git 초기화
git init

# 모든 파일 추가 (.gitignore가 불필요한 파일 제외)
git add .

# 커밋
git commit -m "Initial commit: Claude Skills Demo"

# GitHub에 새 리포지토리 생성 후 (https://github.com/new)
git remote add origin https://github.com/YOUR_USERNAME/claude-skills-demo.git
git branch -M main
git push -u origin main
```

### 2단계: Railway 배포

1. https://railway.app 접속 및 로그인
2. "New Project" 클릭
3. "Deploy from GitHub repo" 선택
4. 방금 생성한 리포지토리 선택
5. "Deploy Now" 클릭

### 3단계: 환경 변수 설정

1. 프로젝트 대시보드에서 **"Variables"** 탭 클릭
2. "New Variable" 클릭
3. 추가:
   - `ANTHROPIC_API_KEY`: 실제 API 키 입력
   - `PORT`: `5000` (자동으로 설정되지만 확인)
4. "Add" 클릭

### 4단계: 배포 완료

- 자동으로 빌드 및 배포가 시작됩니다
- "Settings" → "Generate Domain"으로 퍼블릭 URL 생성
- 예: `https://your-app.up.railway.app`

---

## Option 3: Render 배포

### 1단계: GitHub에 코드 올리기 (Railway와 동일)

### 2단계: Render 배포

1. https://render.com 접속 및 로그인
2. "New +" → "Web Service" 클릭
3. GitHub 리포지토리 연결
4. 설정:
   - **Name**: 원하는 이름
   - **Environment**: Python 3
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `python main.py`
   - **Instance Type**: Free

### 3단계: 환경 변수 설정

1. "Environment" 탭에서
2. "Add Environment Variable" 클릭
3. 추가:
   - Key: `ANTHROPIC_API_KEY`
   - Value: 실제 API 키

### 4단계: 배포 완료

- 자동으로 배포가 시작됩니다
- URL: `https://your-app.onrender.com`

⚠️ **주의**: Render 무료 티어는 15분 비활성 후 sleep 모드로 전환됩니다.

---

## 🎯 노션에 삽입하기 (Notion Embed)

### 방법 1: Embed 블록 사용

1. **노션 페이지 열기**

2. **Embed 블록 추가**
   - 빈 줄에서 `/embed` 타입
   - 또는 `/임베드` 타입 (한글)

3. **배포된 URL 입력**
   ```
   https://your-app.railway.app
   ```
   또는
   ```
   https://your-app.username.repl.co
   ```

4. **"Embed link" 클릭**

5. **크기 조정**
   - Embed 블록의 가장자리를 드래그하여 크기 조정
   - Full width 추천

### 방법 2: 직접 URL 붙여넣기

1. 노션 페이지에 배포 URL을 붙여넣기
2. "Create embed" 옵션 선택
3. 노션이 자동으로 embed 블록 생성

### 노션 Embed 팁

✅ **작동하는 것들:**
- 모든 HTTPS URL
- 반응형 웹사이트
- iframe 지원 사이트

⚠️ **주의사항:**
- HTTP URL은 작동하지 않음 (HTTPS 필수)
- 일부 사이트는 X-Frame-Options 때문에 embed 불가
- 모바일에서는 embed가 제대로 표시되지 않을 수 있음

### 대안: 링크 프리뷰

Embed가 작동하지 않는 경우:
1. URL을 노션에 붙여넣기
2. "Create bookmark" 선택
3. 예쁜 링크 카드가 생성됨
4. 사용자가 클릭하면 새 탭에서 열림

---

## 🔒 보안 고려사항

### API 키 보호

**절대 하면 안 되는 것:**
- ❌ API 키를 코드에 직접 작성
- ❌ GitHub에 `.env` 파일 푸시
- ❌ 프론트엔드에 API 키 노출

**올바른 방법:**
- ✅ 환경 변수 사용 (Replit Secrets, Railway Variables)
- ✅ `.gitignore`에 `.env` 추가
- ✅ 백엔드에서만 API 호출

### Rate Limiting

많은 사용자가 접근할 경우:
- API 사용량 모니터링
- Rate limiting 구현 고려
- 비용 관리 설정

---

## 📊 배포 플랫폼 비교

| 플랫폼 | 무료 티어 | 장점 | 단점 |
|--------|-----------|------|------|
| **Replit** | ✅ (제한적) | 설정 초간단, 코드 편집 가능 | Sleep 모드, 성능 제한 |
| **Railway** | ✅ ($5 크레딧) | 빠름, GitHub 연동, 안정적 | 크레딧 소진 시 유료 |
| **Render** | ✅ | 무료, 안정적 | 15분 후 Sleep 모드 |
| **Vercel** | ✅ | 빠름, CDN | Serverless 변환 필요 |

---

## 🎬 빠른 시작 (추천 순서)

### 초보자 / 빠른 테스트
1. **Replit** 사용 → 가장 쉬움

### 실제 서비스 / 안정성 필요
1. **Railway** 사용 → GitHub 연동
2. 노션에 Embed

### 단계별 순서

```bash
# 1. Git 초기화
git init
git add .
git commit -m "Initial commit"

# 2. GitHub 리포지토리 생성 (웹에서)
# https://github.com/new

# 3. GitHub에 푸시
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main

# 4. Railway 또는 Render에 배포
# (웹 인터페이스 사용)

# 5. 노션에 URL embed
```

---

## 💡 추가 팁

### 커스텀 도메인 (선택사항)
- Railway/Render에서 커스텀 도메인 설정 가능
- 예: `skills.yourdomain.com`

### 모니터링
- Railway/Render 대시보드에서 로그 확인
- API 사용량 모니터링

### 업데이트
- GitHub에 코드 푸시 → 자동 재배포
- Replit은 파일 저장 시 자동 재시작

---

## ❓ 문제 해결

### "API 키가 설정되지 않았습니다" 오류
→ 환경 변수 확인 (Secrets/Variables 탭)

### 노션 Embed가 작동하지 않음
→ HTTPS URL 확인, Bookmark 사용 시도

### Sleep 모드 문제
→ 유료 플랜으로 업그레이드 또는 Railway 사용

### 느린 로딩
→ Railway나 Render로 이전 (Replit보다 빠름)

---

**도움이 필요하시면 언제든 질문해주세요!** 🚀
