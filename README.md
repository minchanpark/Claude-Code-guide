# Claude Skills 비교 데모

Claude API의 Skills 기능을 시각적으로 비교할 수 있는 웹 애플리케이션입니다.

## ⚡ 빠른 시작 (1분!)

### 초간단 배포 - 3단계만!

```bash
# 1. API 키 설정 (.env 파일에)
# 2. 실행
./run-public.sh
# 3. 생성된 URL을 노션에 붙여넣기!
```

**자세한 가이드**: [SIMPLE_GUIDE.md](SIMPLE_GUIDE.md) ⭐ 초보자 추천!

---

## 기능

- 동일한 프롬프트에 대해 Skills 적용 전후의 응답을 비교
- PDF 처리 전문가 Skill이 미리 설정됨
- 실시간 토큰 사용량 표시
- 반응형 웹 디자인

## 설치 방법

### 1. 가상 환경 생성 및 활성화 (권장)

```bash
# 가상 환경 생성
python3 -m venv venv

# 가상 환경 활성화 (macOS/Linux)
source venv/bin/activate

# 가상 환경 활성화 (Windows)
venv\Scripts\activate
```

### 2. 의존성 패키지 설치

```bash
pip install -r requirements.txt
```

### 3. 환경 변수 설정

`.env` 파일을 생성하고 Anthropic API 키를 추가하세요:

```bash
cp .env.example .env
```

`.env` 파일을 열고 API 키를 입력하세요:

```
ANTHROPIC_API_KEY=your_actual_api_key_here
```

> API 키는 [Anthropic Console](https://console.anthropic.com/)에서 발급받을 수 있습니다.

### 4. 애플리케이션 실행

```bash
python main.py
```

브라우저에서 http://localhost:5000 을 열면 애플리케이션을 사용할 수 있습니다.

## 사용 방법

1. 프롬프트 입력란에 PDF 관련 질문을 입력하세요
2. 또는 제공된 예제 버튼을 클릭하세요
3. "비교하기" 버튼을 클릭하여 결과를 확인하세요
4. Skills 적용 전후의 응답 차이를 비교해보세요

## 예제 프롬프트

- "PDF 파일에서 표를 추출하는 방법을 알려줘"
- "여러 PDF 파일을 하나로 합치고 싶어"
- "PDF 폼에 자동으로 데이터를 채우는 코드 작성해줘"
- "스캔된 PDF에서 텍스트를 추출하려면?"

## 기술 스택

- **Backend**: Flask (Python)
- **Frontend**: HTML, CSS, JavaScript
- **AI**: Anthropic Claude API (claude-sonnet-4)
- **PDF 처리**: pdfplumber, PyPDF2, pandas

## 프로젝트 구조

```
claude-code/
├── main.py              # Flask 서버 메인 파일
├── requirements.txt     # Python 패키지 의존성
├── .env                 # 환경 변수 (API 키)
├── .env.example         # 환경 변수 예제
└── templates/
    └── index.html       # 웹 인터페이스
```

## 🚀 배포하기

이 애플리케이션을 배포하여 노션에 삽입하고 싶으신가요?

### ⚡ 가장 쉬운 방법 (1분 완료!)

**[SIMPLE_GUIDE.md](SIMPLE_GUIDE.md)** ⭐ 초보자용 - 딱 3단계만!

```bash
./run-public.sh
```

### 💰 완전 무료 배포 (결제 없음!)

**[FREE_DEPLOYMENT.md](FREE_DEPLOYMENT.md)** - 100% 무료 배포 옵션 (2026년 검증)
- **PythonAnywhere** - 무료, 안정적, sleep 없음 ⭐ 최고 추천!
- **Render** - 무료, sleep 모드 있음
- **Cloudflare Tunnel** - 로컬 서버를 인터넷에 공개 (1분 완료)
- **Glitch** - 무료, 웹 에디터 제공

> ⚠️ Replit, Railway는 Always On이 유료입니다.

### 🌐 가장 빠른 방법 (1분 완료!)

```bash
# 로컬 서버를 인터넷에 공개 (Cloudflare Tunnel)
./run-public.sh
```

생성된 URL을 노션에 embed 하세요!

### 📚 상세 가이드

- **[DEPLOYMENT.md](DEPLOYMENT.md)** - 모든 배포 플랫폼 가이드
- **[NOTION_GUIDE.md](NOTION_GUIDE.md)** - 노션 Embed 가이드

### GitHub에 코드 올리기

```bash
# GitHub에 코드 올리기 (PythonAnywhere/Render용)
./deploy-to-github.sh

# 또는 수동으로:
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

## 라이선스

MIT License
