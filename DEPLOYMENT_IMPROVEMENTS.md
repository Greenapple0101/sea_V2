# 배포 개선사항 총정리

## 📋 개요
배포 과정에서 발견된 이슈들을 해결하고 배포 환경을 최적화한 내용을 정리합니다.

---

## 🐳 Docker & 컨테이너화 개선

### 1. `.dockerignore` 파일 추가
- **목적**: Docker 빌드 컨텍스트 최적화 및 보안 강화
- **내용**:
  - Git 관련 파일 제외 (`.git`, `.gitignore`)
  - IDE 설정 파일 제외 (`.idea`, `.vscode`)
  - 빌드 아티팩트 제외 (`build/`, `dist/`, `target/`, `*.jar`, `*.war`)
  - 환경 변수 파일 제외 (`.env*`)
  - 로그 파일 제외 (`*.log`, `logs/`)
  - 임시 파일 제외 (`tmp/`, `temp/`)
  - Node modules 제외 (컨테이너 내부에서 설치)

### 2. `docker-compose.yml` 배포 환경 최적화
- **MySQL 서비스**:
  - Healthcheck 추가 (서비스 의존성 관리 개선)
  - SQL 초기화 스크립트 마운트 (`sca_V2.sql`)
  - UTF-8 인코딩 설정 (`utf8mb4_unicode_ci`)
  - MySQL 네이티브 인증 플러그인 설정
  
- **백엔드 서비스 (sca-be)**:
  - Healthcheck 추가 (Actuator health endpoint)
  - 환경 변수 설정 (DB, JWT, AWS S3 등)
  - 서비스 의존성 설정 (`depends_on` with healthcheck)
  - 프로덕션 프로파일 활성화
  
- **프론트엔드 서비스 (sca-fe)**:
  - Healthcheck 추가 (Nginx 상태 확인)
  - 서비스 의존성 설정 (백엔드 의존)
  - 포트 매핑 설정

- **네트워크 및 볼륨**:
  - 전용 네트워크 생성 (`sca-network`)
  - MySQL 데이터 영구 저장 볼륨 설정

### 3. 프론트엔드 Dockerfile 개선
- **Multi-stage build 적용**:
  - 빌드 단계: Node 20 Alpine (react-router-dom 7.x 호환성)
  - 런타임 단계: Nginx stable Alpine
  
- **최적화 사항**:
  - 이미지 크기 최소화 (Alpine Linux 사용)
  - 빌드 의존성과 런타임 분리
  - Nginx 설정 파일 복사 (`nginx.conf`)

### 4. 불필요한 파일 정리
- **삭제된 파일**:
  - `docker-compose.local.yml` (로컬 환경 파일 제거)
  - `env.example` (환경 변수 예시 파일 제거)
  - `env.local.example` (로컬 환경 변수 예시 파일 제거)
  - `SCA-BE/src/main/resources/collect-all-fish-new.sql` (불필요한 SQL 파일 제거)

---

## 🔧 백엔드 개선사항

### 1. 엔티티 수정
- **GroupQuest.java**: 
  - 엔티티 구조 최적화
  - 관계 매핑 개선
  
- **Raid.java**:
  - 엔티티 구조 최적화
  - 상태 관리 메서드 개선 (`isActive()`, `decreaseBossHp()`, `markCompleted()` 등)

### 2. 데이터베이스 스크립트 정리
- **추가된 파일**:
  - `SCA-BE/src/main/resources/add-missing-fish.sql`: 빠진 물고기 데이터 추가용 스크립트
  - `mysql-fish-data-update.sql`: MySQL 물고기 데이터 업데이트 스크립트

- **업데이트된 파일**:
  - `sca_V2.sql`: 스키마 및 초기 데이터 업데이트

---

## 🎨 프론트엔드 개선사항

### 1. FishAnimation 컴포넌트 개선
- **애니메이션 최적화**:
  - 동적 keyframes 생성 함수 구현
  - 프레임 기반 스프라이트 애니메이션 개선
  - 픽셀 아트 렌더링 설정 (`image-rendering: pixelated`)
  - 접근성 개선 (ARIA 라벨 추가)

### 2. StudentGacha 컴포넌트 개선
- **데이터 검증 강화**:
  - `fish_name` 데이터 무결성 검증 로직 추가
  - 잘못된 데이터에 대한 fallback 처리
  - 에러 핸들링 개선
  
- **사용자 경험 개선**:
  - 가챠 애니메이션 개선 (로딩 상태 표시)
  - 서버와 클라이언트 코랄 동기화 로직 개선
  - 에러 메시지 개선

- **스프라이트 애니메이션 통합**:
  - `FishAnimation` 컴포넌트 활용
  - 정적 아이콘과 애니메이션 아이콘 자동 선택

---

## 🗄️ 데이터베이스 개선사항

### 1. 물고기 데이터 관리
- **MySQL 업데이트 스크립트**:
  - 물고기 이름 및 등급 업데이트
  - 확률 값 설정
  - `ON DUPLICATE KEY UPDATE` 사용하여 중복 방지

- **H2 개발 환경 스크립트**:
  - 빠진 물고기 데이터 추가 스크립트
  - 컬렉션 엔트리 업데이트

### 2. 스키마 업데이트
- `sca_V2.sql` 파일 업데이트
- 초기화 스크립트를 Docker Compose에 통합

---

## 🔒 보안 및 환경 변수 관리

### 1. 환경 변수 분리
- 프로덕션 환경 변수는 `docker-compose.yml`에서 관리
- 민감한 정보는 환경 변수로 주입
- 기본값 설정으로 개발 환경 호환성 유지

### 2. .dockerignore를 통한 보안 강화
- 환경 변수 파일이 이미지에 포함되지 않도록 설정
- Git 히스토리 제외

---

## 📊 배포 체크리스트

### 완료된 항목
- [x] Docker 빌드 최적화 (.dockerignore 추가)
- [x] Multi-stage build 적용 (프론트엔드)
- [x] Healthcheck 추가 (모든 서비스)
- [x] 서비스 의존성 관리 개선
- [x] 환경 변수 관리 개선
- [x] 불필요한 파일 정리
- [x] 데이터베이스 초기화 스크립트 통합
- [x] 프론트엔드 애니메이션 최적화
- [x] 데이터 검증 로직 강화
- [x] 에러 핸들링 개선

### 권장 사항
- [ ] 프로덕션 환경 변수 관리 시스템 도입 (예: AWS Secrets Manager)
- [ ] CI/CD 파이프라인 구축
- [ ] 모니터링 및 로깅 시스템 구축
- [ ] 백업 전략 수립

---

## 🚀 배포 시 주의사항

1. **환경 변수 설정**:
   - `.env` 파일 또는 환경 변수로 다음 값들을 설정해야 합니다:
     - `MYSQL_ROOT_PASSWORD`
     - `MYSQL_DATABASE`
     - `MYSQL_USER`
     - `MYSQL_PASSWORD`
     - `DB_URL`
     - `DB_USERNAME`
     - `DB_PASSWORD`
     - `JWT_SECRET`
     - `OPENAI_API_KEY`
     - `AWS_ACCESS_KEY`
     - `AWS_SECRET_KEY`
     - `AWS_S3_BUCKET`

2. **데이터베이스 초기화**:
   - `sca_V2.sql` 파일이 `docker-compose.yml`에 마운트되어 자동 초기화됩니다.
   - 수동으로 데이터를 업데이트해야 하는 경우 `mysql-fish-data-update.sql`을 사용하세요.

3. **빌드 순서**:
   - 백엔드 JAR 파일이 먼저 빌드되어 있어야 합니다.
   - `SCA-BE/build/libs/sca-be-0.0.1-SNAPSHOT.jar` 파일이 존재해야 합니다.

4. **네트워크 설정**:
   - 모든 서비스는 `sca-network`를 통해 통신합니다.
   - 외부 접근은 포트 매핑을 통해 이루어집니다.

---

## 📝 변경 파일 목록

### 추가된 파일
- `.dockerignore`
- `SCA-BE/src/main/resources/add-missing-fish.sql`
- `mysql-fish-data-update.sql`

### 수정된 파일
- `docker-compose.yml`
- `SCA-FE/Dockerfile`
- `SCA-BE/src/main/groovy/com/example/sca_be/domain/groupquest/entity/GroupQuest.java`
- `SCA-BE/src/main/groovy/com/example/sca_be/domain/raid/entity/Raid.java`
- `SCA-FE/src/components/FishAnimation.tsx`
- `SCA-FE/src/components/student/StudentGacha.tsx`
- `sca_V2.sql`

### 삭제된 파일
- `docker-compose.local.yml`
- `env.example`
- `env.local.example`
- `SCA-BE/src/main/resources/collect-all-fish-new.sql`

---

## 🔗 관련 이슈
- 배포 환경 최적화
- Docker 빌드 성능 개선
- 데이터베이스 초기화 자동화
- 프론트엔드 애니메이션 최적화
- 데이터 검증 로직 강화

