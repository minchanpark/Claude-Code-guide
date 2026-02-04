# 🎯 Skills 효과 비교 예시

## 실제 테스트 결과

### 질문: "PDF 파일에서 표를 추출하는 방법을 알려줘"

---

## ❌ Skills 없이 (일반 Claude)

```
PDF에서 표를 추출하는 방법을 알려드리겠습니다.

여러 Python 라이브러리를 사용할 수 있습니다:

1. PyPDF2 사용
2. pdfplumber 사용
3. tabula-py 사용

가장 간단한 예제:

import pdfplumber

with pdfplumber.open('file.pdf') as pdf:
    page = pdf.pages[0]
    table = page.extract_table()
    print(table)

자세한 내용은 각 라이브러리의 문서를 참고하세요.
```

**특징:**
- 간단한 설명
- 기본적인 코드
- 설치 명령어 없음
- 에러 처리 없음
- 실무 팁 없음

---

## ✅ PDF 전문가 Skill 적용

```python
# PDF 테이블 추출 완전 가이드

## 1. 설치
pip install pdfplumber pandas openpyxl

## 2. 완전한 코드 (즉시 실행 가능)

import pdfplumber
import pandas as pd
import re
from pathlib import Path

def extract_tables_from_pdf(pdf_path, output_excel='tables.xlsx'):
    """
    PDF에서 모든 테이블 추출 및 Excel 저장
    
    Args:
        pdf_path: PDF 파일 경로
        output_excel: 저장할 Excel 파일명
    
    Returns:
        추출된 테이블 리스트
    """
    all_tables = []
    
    try:
        with pdfplumber.open(pdf_path) as pdf:
            print(f"📄 총 {len(pdf.pages)} 페이지 분석 중...\n")
            
            for page_num, page in enumerate(pdf.pages, 1):
                # 테이블 추출
                tables = page.extract_tables()
                
                for table_num, table in enumerate(tables, 1):
                    if table and len(table) > 1:
                        # DataFrame 생성
                        df = pd.DataFrame(table[1:], columns=table[0])
                        
                        # 데이터 정제
                        df = df.dropna(how='all')  # 빈 행 제거
                        df = df.dropna(axis=1, how='all')  # 빈 열 제거
                        
                        # 시트명 생성
                        sheet_name = f"Page{page_num}_Table{table_num}"
                        all_tables.append((sheet_name, df))
                        
                        print(f"✓ {sheet_name}: {df.shape[0]}행 x {df.shape[1]}열")
    
    except FileNotFoundError:
        print(f"❌ 파일을 찾을 수 없습니다: {pdf_path}")
        return []
    except Exception as e:
        print(f"❌ 오류 발생: {e}")
        return []
    
    # Excel로 저장
    if all_tables:
        with pd.ExcelWriter(output_excel, engine='openpyxl') as writer:
            for sheet_name, df in all_tables:
                df.to_excel(writer, sheet_name=sheet_name, index=False)
        
        print(f"\n📊 총 {len(all_tables)}개 테이블을 '{output_excel}'에 저장했습니다.")
    
    return all_tables

## 3. 사용 예제

# 기본 사용
tables = extract_tables_from_pdf('document.pdf')

# 여러 PDF 처리
pdf_files = ['file1.pdf', 'file2.pdf', 'file3.pdf']
for pdf_file in pdf_files:
    extract_tables_from_pdf(pdf_file, f'{Path(pdf_file).stem}_tables.xlsx')

## 4. 고급 옵션

### 테이블 감지 설정 조정
with pdfplumber.open('document.pdf') as pdf:
    page = pdf.pages[0]
    
    # 세밀한 설정
    table = page.extract_table({
        "vertical_strategy": "lines",
        "horizontal_strategy": "lines",
        "explicit_vertical_lines": [],
        "explicit_horizontal_lines": [],
        "snap_tolerance": 3,
    })

## 5. 실무 팁

### ✅ 장점:
- 복잡한 표 구조도 정확히 추출
- 여러 페이지 자동 처리
- Excel로 바로 저장

### ⚠️ 주의사항:
- 스캔된 PDF는 OCR 필요 (pytesseract)
- 이미지로 된 표는 추출 불가
- 병합된 셀은 데이터 검증 필요

### 🚀 성능 최적화:
- 대용량 PDF는 페이지 단위로 분할
- 멀티프로세싱으로 병렬 처리 가능

## 6. 대안 방법

### tabula-py 사용 (Java 기반)
pip install tabula-py

import tabula
tables = tabula.read_pdf('file.pdf', pages='all')
for i, df in enumerate(tables):
    df.to_excel(f'table_{i}.xlsx', index=False)

### camelot-py 사용 (가장 정확)
pip install camelot-py[cv]

import camelot
tables = camelot.read_pdf('file.pdf', pages='1-end')
tables.export('output.xlsx', f='excel')

## 7. 트러블슈팅

❌ 문제: 표가 제대로 추출되지 않음
✅ 해결: table_settings 조정 또는 camelot-py 사용

❌ 문제: 한글이 깨짐
✅ 해결: encoding='utf-8' 명시

❌ 문제: 메모리 부족
✅ 해결: 페이지 단위로 처리
```

**특징:**
- ✅ 완전한 실행 가능 코드
- ✅ 설치 명령어 포함
- ✅ 에러 처리 완비
- ✅ 여러 사용 예제
- ✅ 고급 옵션 설명
- ✅ 실무 팁 제공
- ✅ 대안 방법 제시
- ✅ 트러블슈팅 가이드

---

## 📊 차이점 요약

| 항목 | Skills 없이 | PDF 전문가 Skill |
|------|-------------|------------------|
| **코드 완성도** | 기본 예제 | 프로덕션 레벨 |
| **실행 가능성** | 부분적 | 즉시 실행 가능 |
| **에러 처리** | ❌ | ✅ 완비 |
| **설치 가이드** | ❌ | ✅ 상세 |
| **실무 팁** | ❌ | ✅ 풍부 |
| **대안 제시** | ❌ | ✅ 3가지 방법 |
| **문서화** | 간단 | 상세 주석 |
| **예제 수** | 1개 | 5개 이상 |

---

이제 직접 테스트해보세요! 차이가 확실히 보일 것입니다. 🎉
