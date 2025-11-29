# Issue #6: 배경 색 채우기 + 선생님 대시보드 다듬기

## 📋 개요
선생님 대시보드 및 로그인/회원가입 페이지의 배경을 학생 페이지와 동일한 파랑 모자이크 패턴으로 통일하고, 대시보드 UI를 개선하는 작업

## 🎯 목표
1. 선생님 대시보드 배경을 학생 페이지와 동일한 파랑 모자이크 패턴으로 변경
2. 로그인/회원가입 페이지 배경도 동일하게 적용
3. 선생님 대시보드 UI 개선 (현재 너무 단순함)
4. "새로" 글자 수정

## 📁 관련 파일

### 배경 이미지 관련
- `SCA-FE/src/styles/bg.png` - 파랑 모자이크 배경 이미지
- `SCA-FE/src/index.css` - CSS 변수 정의 (`--bg-url`)

### 레이아웃 관련
- `SCA-FE/src/routes/AppRoutes.tsx` - TeacherLayout 컴포넌트 (line 70-118)
- `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` - 대시보드 메인 페이지
- `SCA-FE/src/components/teacher/Sidebar.tsx` - 사이드바 컴포넌트

### 로그인/회원가입 관련
- `SCA-FE/src/components/common/LoginPage.tsx` - 로그인 페이지
- `SCA-FE/src/components/common/SignupPage.tsx` - 회원가입 페이지

### 학생 레이아웃 참고
- `SCA-FE/src/routes/AppRoutes.tsx` - StudentLayout (line 36-67)
  - 현재: `style={{backgroundImage: "var(--bg-url)"}}` 사용

## ✅ 작업 항목

### 1. 배경 색 채우기 (파랑 모자이크 패턴)

#### 1-1. 선생님 대시보드 배경 적용
- [ ] **TeacherLayout 배경 변경**
  - 현재: `bg-white` (흰색 배경)
  - 목표: 학생 페이지와 동일한 파랑 모자이크 배경
  - 방법: `style={{backgroundImage: "var(--bg-url)"}}` 추가
  - 파일: `SCA-FE/src/routes/AppRoutes.tsx` (line 110-112)
  - 참고: StudentLayout의 구현 방식 (line 61)

- [ ] **메인 콘텐츠 영역 배경**
  - 현재: 기본 흰색 또는 투명
  - 목표: 파랑 모자이크 배경이 보이도록 설정
  - 파일: `SCA-FE/src/routes/AppRoutes.tsx` (line 112)

#### 1-2. 로그인 페이지 배경 적용
- [ ] **LoginPage 배경 변경**
  - 현재: 흰색 배경
  - 목표: 파랑 모자이크 배경 적용
  - 파일: `SCA-FE/src/components/common/LoginPage.tsx`
  - 방법: 최상위 컨테이너에 `style={{backgroundImage: "var(--bg-url)"}}` 추가

#### 1-3. 회원가입 페이지 배경 적용
- [ ] **SignupPage 배경 변경**
  - 현재: 흰색 배경
  - 목표: 파랑 모자이크 배경 적용
  - 파일: `SCA-FE/src/components/common/SignupPage.tsx`
  - 방법: 최상위 컨테이너에 `style={{backgroundImage: "var(--bg-url)"}}` 추가

#### 1-4. 역할 선택 페이지 배경 적용
- [ ] **RoleSelection 배경 변경**
  - 현재: 흰색 배경
  - 목표: 파랑 모자이크 배경 적용
  - 파일: `SCA-FE/src/components/RoleSelection.tsx`
  - 방법: 최상위 컨테이너에 `style={{backgroundImage: "var(--bg-url)"}}` 추가

### 2. 선생님 대시보드 UI 개선

#### 2-1. 대시보드 레이아웃 개선
- [ ] **페이지 헤더 스타일 개선**
  - 현재: 단순한 테두리와 패딩
  - 목표: Windows XP 스타일의 3D 효과 추가
  - 파일: `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` (line 96)

- [ ] **반 목록 카드 디자인 개선**
  - 현재: 단순한 흰색 카드
  - 목표: 
    - Windows XP 스타일의 3D 효과 (inset/outset)
    - 배경 색상 조정 (파랑 모자이크 위에서 잘 보이도록)
    - 그림자 효과 추가
  - 파일: `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` (line 127-147)

- [ ] **빈 상태 메시지 개선**
  - 현재: 단순한 텍스트 메시지
  - 목표: 아이콘이나 시각적 요소 추가
  - 파일: `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` (line 148-159)

#### 2-2. 버튼 스타일 개선
- [ ] **"반 생성하기" 버튼**
  - 현재: 검은색 배경 버튼
  - 목표: Windows XP 스타일의 3D 버튼 효과
  - 파일: `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` (line 117-124)

- [ ] **"회원정보 수정" 버튼**
  - 현재: 파란색 배경 버튼
  - 목표: Windows XP 스타일의 3D 버튼 효과
  - 파일: `SCA-FE/src/components/teacher/TeacherDashboardNew.tsx` (line 102-109)

#### 2-3. 전체적인 시각적 계층 구조
- [ ] **섹션 구분 명확화**
  - 헤더와 콘텐츠 영역의 시각적 구분 강화
  - 카드 간 간격 및 정렬 개선

- [ ] **색상 대비 조정**
  - 파랑 모자이크 배경 위에서 텍스트와 요소들이 잘 보이도록
  - 카드 배경 색상 조정 (반투명 또는 불투명 흰색)

### 3. "새로" 글자 수정
- [ ] **"새 반 만들기" 페이지 확인**
  - 현재 어떤 텍스트가 "새로"로 표시되는지 확인
  - 파일: `SCA-FE/src/components/teacher/ClassCreatePage.tsx`
  - 수정할 텍스트 확인 및 변경

### 4. 전체적인 디자인 통일성
- [ ] **Windows XP 스타일 일관성**
  - 모든 페이지에서 동일한 배경 패턴 사용
  - 버튼, 카드, 입력 필드의 3D 효과 통일
  - 색상 팔레트 일관성 유지

## 🔍 현재 상태 분석

### 학생 페이지 배경 구현 (참고)
```tsx
// StudentLayout
<div className="flex-1 overflow-y-auto no-scrollbar mb-20" 
     style={{backgroundImage: "var(--bg-url)"}}>
  <Outlet />
</div>
```

### 선생님 페이지 배경 (현재)
```tsx
// TeacherLayout
<div className="window-body bg-white flex" 
     style={{ padding: 0, height: 'calc(100% - 30px)' }}>
  <Sidebar />
  <main className="flex-1 border-l-2 border-gray-300 overflow-y-auto">
    <Outlet />
  </main>
</div>
```

### 문제점
1. 선생님 대시보드가 흰색 배경으로 단조로움
2. 학생 페이지와 배경이 달라 일관성 부족
3. 로그인/회원가입 페이지도 배경이 없음
4. 대시보드 UI가 너무 단순하여 시각적 계층 구조가 불명확
5. "새로"라는 텍스트가 정확히 어디에 있는지 확인 필요

## 💡 구현 방법

### 배경 적용 방법
1. **CSS 변수 사용** (권장)
   ```tsx
   style={{backgroundImage: "var(--bg-url)"}}
   ```
   - 이미 `index.css`에 정의되어 있음
   - 학생 페이지와 동일한 방식

2. **직접 이미지 경로 사용**
   ```tsx
   style={{backgroundImage: "url('./styles/bg.png')"}}
   ```

### 대시보드 개선 방향
1. **카드 스타일**
   - Windows XP 스타일의 `sunken-panel` 또는 `raised-panel` 클래스 사용
   - 배경을 반투명 흰색으로 설정하여 모자이크 배경이 살짝 보이도록

2. **버튼 스타일**
   - 기존 Windows XP 스타일 버튼 컴포넌트 활용
   - 3D 효과 (inset/outset shadow) 적용

3. **레이아웃 구조**
   - 헤더 영역과 콘텐츠 영역의 시각적 구분 강화
   - 카드 그리드 레이아웃 개선

## 📝 구현 체크리스트

### Phase 1: 배경 적용
- [ ] TeacherLayout 배경 변경
- [ ] LoginPage 배경 변경
- [ ] SignupPage 배경 변경
- [ ] RoleSelection 배경 변경
- [ ] 모든 페이지에서 배경이 정상적으로 표시되는지 확인

### Phase 2: 대시보드 UI 개선
- [ ] 페이지 헤더 스타일 개선
- [ ] 반 목록 카드 디자인 개선
- [ ] 버튼 스타일 개선
- [ ] 빈 상태 메시지 개선
- [ ] 전체적인 시각적 계층 구조 개선

### Phase 3: 텍스트 수정 및 최종 점검
- [ ] "새로" 텍스트 확인 및 수정
- [ ] 전체적인 디자인 통일성 검토
- [ ] 반응형 레이아웃 테스트
- [ ] 사용자 테스트

## 🎨 참고 자료
- 학생 페이지 배경 구현: `SCA-FE/src/routes/AppRoutes.tsx` (StudentLayout)
- CSS 변수 정의: `SCA-FE/src/index.css` (line 174)
- 배경 이미지: `SCA-FE/src/styles/bg.png`
- Windows XP 스타일 컴포넌트: `SCA-FE/src/components/ui/`

## 📌 우선순위
1. **High**: 배경 색 채우기 (모든 페이지)
2. **High**: "새로" 글자 수정
3. **Medium**: 대시보드 UI 개선
4. **Low**: 디테일 작업 (애니메이션, 호버 효과)

## 🔗 관련 이슈
- 이전 이슈: 배경 색 채우기 + 선생님 대시보드 다듬기 (초기 버전)

## 📅 예상 작업 시간
- Phase 1 (배경 적용): 1-2시간
- Phase 2 (대시보드 개선): 3-4시간
- Phase 3 (텍스트 수정 및 점검): 1시간
- **총 예상 시간**: 5-7시간

## ✅ 완료 조건
- [ ] 모든 페이지에서 파랑 모자이크 배경이 일관되게 적용됨
- [ ] 학생 페이지와 선생님 페이지의 배경이 동일함
- [ ] 로그인/회원가입 페이지에도 배경이 적용됨
- [ ] 대시보드 UI가 개선되어 시각적 계층 구조가 명확함
- [ ] "새로" 텍스트가 올바르게 수정됨
- [ ] Windows XP 스타일과 일치하는 디자인
- [ ] 반응형 레이아웃이 정상 작동
- [ ] 사용자 테스트 통과

## 📝 추가 참고사항
- 배경 이미지 파일 경로: `SCA-FE/src/styles/bg.png`
- CSS 변수명: `--bg-url`
- 학생 페이지에서 이미 동일한 배경을 사용하고 있으므로, 동일한 방식으로 적용하면 됨
