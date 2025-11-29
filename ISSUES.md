# 이슈 목록

## 🔴 [Critical] AI 보상 추천 기능 서버 오류

### 발생 일시
- 2024년 (정확한 날짜는 추후 업데이트)

### 발생 위치
- **페이지**: 개인 퀘스트 등록 페이지 (`/teacher/quest/individual`)
- **기능**: AI 보상 추천받기
- **API 엔드포인트**: `POST /api/v1/quests/personal/ai-recommend`

### 문제 설명
개인 퀘스트 등록 페이지에서 학생을 선택하고 "AI 보상 추천받기" 기능을 사용하는 중에 서버 오류가 발생합니다.

**에러 메시지**: "서버 오류가 발생했습니다."

### 재현 단계
1. 선생님 계정으로 로그인
2. 개인 퀘스트 등록 페이지로 이동 (`/teacher/quest/individual`)
3. 퀘스트 정보 입력 (제목, 내용, 난이도 등)
4. 학생 1명 이상 선택
5. "AI 보상 추천받기" 버튼 클릭
6. "분석 중..." 상태에서 서버 오류 발생

### 예상 원인
1. **백엔드 서비스 레이어 예외**
   - `PersonalQuestService.recommendRewards()` 메서드에서 예외 발생
   - 가능한 원인:
     - `questAnalyzerService.analyzeQuest()` 호출 실패
     - `studentRepository.findByIdsWithMember()` 호출 실패
     - `studentFactorService.calculatePersonalizedReward()` 호출 실패
     - NullPointerException (학생 정보가 null인 경우)
     - 데이터베이스 연결 문제

2. **예외 처리 부족**
   - 컨트롤러에서 예외 처리가 없음
   - 서비스에서 `RuntimeException`으로 래핑하여 던짐
   - 전역 예외 핸들러에서 처리하지만 구체적인 에러 메시지가 사용자에게 전달되지 않음

### 관련 코드
- **프론트엔드**: `SCA-FE/src/components/teacher/IndividualQuestCreatePage.tsx` (line 201-258)
- **백엔드 컨트롤러**: `SCA-BE/src/main/groovy/com/example/sca_be/domain/personalquest/controller/PersonalQuestController.java` (line 39-46)
- **백엔드 서비스**: `SCA-BE/src/main/groovy/com/example/sca_be/domain/personalquest/service/PersonalQuestService.java` (line 254-330)
- **전역 예외 핸들러**: `SCA-BE/src/main/groovy/com/example/sca_be/global/exception/GlobalExceptionHandler.java` (line 119-129)

### 해결 방안
1. **로그 확인**
   - 서버 로그에서 구체적인 에러 메시지 및 스택 트레이스 확인
   - `PersonalQuestService.recommendRewards()` 메서드의 catch 블록에서 로깅되는 에러 확인

2. **예외 처리 개선**
   - 컨트롤러에서 try-catch 추가하여 구체적인 에러 메시지 반환
   - 서비스에서 발생 가능한 예외를 구체적으로 처리
   - Null 체크 추가 (학생 정보, 분석 결과 등)

3. **에러 응답 개선**
   - 전역 예외 핸들러에서 더 구체적인 에러 메시지 제공
   - 프론트엔드에서 에러 응답을 더 자세히 표시

4. **데이터 검증**
   - 요청 데이터 검증 강화
   - 학생 ID 유효성 검사
   - 퀘스트 데이터 필수 필드 검증

### 우선순위
**High** - 핵심 기능이 동작하지 않아 사용자 경험에 큰 영향을 미침

### 상태
- [ ] 조사 중
- [ ] 수정 중
- [ ] 테스트 중
- [ ] 해결 완료

### 참고 사항
- 브라우저 콘솔에서 네트워크 요청 및 응답 확인 필요
- 서버 로그에서 상세한 에러 정보 확인 필요
- 데이터베이스 연결 상태 확인 필요

---

## 🟡 [Medium] 한글 문자 인코딩 깨짐 문제

### 발생 일시
- 2024년 (정확한 날짜는 추후 업데이트)

### 발생 위치
- **페이지**: 학생 컬렉션 페이지 (수족관/도감)
- **데이터**: 물고기 이름 (`fish_name`) 필드
- **API 엔드포인트**: 
  - `GET /api/v1/collection/aquarium`
  - `GET /api/v1/collection/encyclopedia`

### 문제 설명
데이터베이스에서는 한글이 정상적으로 저장되어 있고 SELECT 쿼리로 조회 시에도 정상적으로 보이지만, 웹 화면에서는 한글이 깨져서 표시됩니다.

**예시**:
- DB: "상어" ✅
- 화면: "iƒ…" ❌

### 재현 단계
1. 학생 계정으로 로그인
2. 컬렉션 페이지로 이동 (수족관 또는 도감)
3. 물고기 이름이 한글인 항목 확인
4. 한글이 깨져서 표시되는 것을 확인

### 예상 원인
1. **HTTP 응답 인코딩 문제**
   - JSON 응답 시 `Content-Type` 헤더에 `charset=UTF-8`이 명시되지 않음
   - `MappingJackson2HttpMessageConverter`에 UTF-8 인코딩 설정이 없음
   - `WebConfig`에서 `StringHttpMessageConverter`만 설정하고 JSON 컨버터는 설정하지 않음

2. **데이터베이스 연결 인코딩**
   - JDBC URL에 `useUnicode=true&characterEncoding=UTF-8` 파라미터 누락 가능
   - MySQL 연결 시 `character-set-server` 설정은 되어 있으나 JDBC 연결 파라미터 확인 필요

3. **프론트엔드 인코딩 처리**
   - `fetch` 또는 `axios` 요청 시 인코딩 설정 문제
   - 브라우저가 응답을 잘못된 인코딩으로 해석

### 관련 코드
- **프론트엔드**: `SCA-FE/src/components/student/StudentCollection.tsx` (line 81-124)
- **백엔드 서비스**: `SCA-BE/src/main/groovy/com/example/sca_be/domain/gacha/service/CollectionService.java` (line 34-66, 71-120)
- **웹 설정**: `SCA-BE/src/main/groovy/com/example/sca_be/global/config/WebConfig.groovy` (line 14-17)
- **데이터베이스 설정**: `docker-compose.yml` (line 22)
- **프로덕션 설정**: `SCA-BE/src/main/resources/application-prod.yaml` (line 6-9)

### 해결 방안
1. **WebConfig 개선**
   - `MappingJackson2HttpMessageConverter`에 UTF-8 인코딩 명시
   - JSON 응답의 `Content-Type`에 `charset=UTF-8` 포함

2. **application.yaml 설정 확인**
   - 모든 프로파일에서 `spring.http.encoding.charset=UTF-8` 설정 확인
   - `spring.http.encoding.enabled=true` 및 `force=true` 설정

3. **JDBC URL 확인**
   - 데이터베이스 연결 URL에 `useUnicode=true&characterEncoding=UTF-8` 파라미터 추가
   - MySQL의 경우 `useSSL=false&serverTimezone=Asia/Seoul` 등과 함께 설정

4. **프론트엔드 확인**
   - API 요청 시 `Accept-Charset: UTF-8` 헤더 확인
   - 응답 파싱 시 인코딩 명시

5. **브라우저 개발자 도구 확인**
   - Network 탭에서 응답 헤더의 `Content-Type` 확인
   - Response 탭에서 실제 응답 데이터의 인코딩 확인

### 우선순위
**Medium** - 기능은 동작하지만 사용자 경험에 영향을 미침

### 상태
- [ ] 조사 중
- [ ] 수정 중
- [ ] 테스트 중
- [ ] 해결 완료

### 참고 사항
- 데이터베이스에서는 정상적으로 저장되어 있으므로 DB 인코딩 문제는 아님
- HTTP 응답 전송 과정에서의 인코딩 문제로 추정
- 브라우저 개발자 도구의 Network 탭에서 실제 응답 헤더 및 바디 확인 필요
