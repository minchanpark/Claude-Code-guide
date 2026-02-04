# ⚡ 초간단 배포 가이드 (1분 완료!)

다른 복잡한 거 다 필요 없습니다. **딱 3단계**만 하면 끝!

---

## 🚀 방법 1: 로컬에서 바로 실행 (가장 쉬움!)

### 1단계: .env 파일에 API 키 입력

[.env](.env) 파일을 열고:
```
ANTHROPIC_API_KEY=여기에_실제_API_키_입력
```

> API 키는 https://console.anthropic.com 에서 발급

### 2단계: 터미널에서 한 줄 실행

```bash
./run-public.sh
```

### 3단계: 생성된 URL을 노션에 붙여넣기

터미널에 나온 URL (예: `https://abc-123.trycloudflare.com`)을 복사해서 노션에 붙여넣으면 끝!

---

## 🎯 끝! 정말 이게 전부입니다.

**Q: 컴퓨터를 끄면?**
→ 서비스가 중단됩니다. 다시 `./run-public.sh` 실행하면 됩니다.

**Q: 항상 켜놓고 싶어요**
→ 아래 "24/7 배포" 섹션 참고

**Q: 명령어가 안 먹혀요**
→ 아래 "문제 해결" 섹션 참고

---

## 🌍 24/7 배포 (컴퓨터 꺼도 작동)

항상 켜놓고 싶다면 이 방법들 중 하나 선택:

### 방법 A: Render (가장 쉬움, 10분)

#### 5단계로 끝내기:

1. **GitHub에 코드 올리기**
   ```bash
   ./deploy-to-github.sh
   ```
   GitHub 리포지토리 URL 입력 (이미 있음: `https://github.com/minchanpark/Claude-Code-guide.git`)

2. **Render 접속**
   https://render.com → "Sign up" (GitHub 계정으로)

3. **New Web Service 클릭**

4. **리포지토리 선택**
   `Claude-Code-guide` 선택

5. **환경 변수만 입력하고 배포!**
   - Name: 원하는 이름
   - Environment: Python 3
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `python main.py`
   - Environment Variables 추가: 
     - Key: `ANTHROPIC_API_KEY`
     - Value: 실제 API 키

끝! 10분 후 `https://your-app.onrender.com` 생성됨

---

### 방법 B: PythonAnywhere (sleep 없음, 15분)

#### 간단 요약:

1. https://www.pythonanywhere.com 가입 (무료)

2. Bash 콘솔에서 코드 가져오기:
   ```bash
   git clone https://github.com/minchanpark/Claude-Code-guide.git
   cd Claude-Code-guide
   python3.10 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

3. "Web" 탭 → "Add a new web app" → Manual configuration → Python 3.10

4. WSGI 파일 수정 (자세한 건 [FREE_DEPLOYMENT.md](FREE_DEPLOYMENT.md) 참고)

5. Reload 버튼 → 완료!

---

## 🛠️ 문제 해결

### "cloudflared: command not found"

```bash
# 설치
brew install cloudflared

# 다시 실행
./run-public.sh
```

### "Permission denied"

```bash
# 권한 부여
chmod +x run-public.sh

# 다시 실행
./run-public.sh
```

### "venv not found"

```bash
# 가상환경 생성
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 다시 실행
./run-public.sh
```

### API 키 오류

`.env` 파일 확인:
```bash
cat .env
```

다음과 같아야 함:
```
ANTHROPIC_API_KEY=sk-ant-xxxxxxxxxxxxx
```

---

## 📱 노션에 삽입하기

### 방법 1: Embed (추천)
1. 노션 페이지에서 `/embed` 입력
2. URL 붙여넣기
3. Enter!

### 방법 2: 직접 붙여넣기
1. URL을 노션에 바로 붙여넣기
2. "Create embed" 선택

---

## 🎬 전체 과정 (영상처럼)

```bash
# 1. API 키 설정
nano .env  # 또는 텍스트 에디터로 열기
# ANTHROPIC_API_KEY=sk-ant-xxxxx 입력하고 저장

# 2. 실행
./run-public.sh

# 3. 출력된 URL 복사
# 예: https://random-name.trycloudflare.com

# 4. 노션에 붙여넣기
# 완료! 🎉
```

---

## 💡 요약

| 방법 | 시간 | 컴퓨터 필요 | Sleep | 난이도 |
|------|------|-------------|-------|--------|
| **로컬 + Tunnel** | 1분 | 켜져있어야 함 | ❌ | ⭐ 초간단 |
| **Render** | 10분 | 불필요 | ✅ 15분 | ⭐⭐ 쉬움 |
| **PythonAnywhere** | 15분 | 불필요 | ❌ | ⭐⭐⭐ 중간 |

---

## 🎯 추천

- **지금 당장 테스트**: `./run-public.sh` (1분)
- **실제 사용**: Render 배포 (10분, 무료)
- **24/7 안정**: PythonAnywhere (15분, 무료, sleep 없음)

---

**더 궁금한 게 있으면 물어보세요!** 🚀
