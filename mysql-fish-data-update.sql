-- ============================================
-- MySQL 물고기 데이터 업데이트 스크립트
-- ============================================
-- 이 스크립트는 MySQL 데이터베이스의 물고기 데이터를
-- 새로운 이름 순서로 업데이트합니다.
-- 
-- 사용 방법:
-- 1. MySQL 클라이언트에서 실행
-- 2. 또는 MySQL Workbench에서 실행
-- 3. 또는 Docker Compose로 MySQL 실행 시 수동으로 실행
-- ============================================

-- 기존 물고기 데이터 삭제 (선택사항)
-- DELETE FROM collection_entries;  -- 컬렉션 엔트리 먼저 삭제
-- DELETE FROM fish;  -- 물고기 데이터 삭제

-- 새로운 물고기 데이터 삽입
INSERT INTO fish (fish_name, grade, probability) VALUES
-- COMMON (7개)
('흰동가리', 'COMMON', 0.10),
('열대어', 'COMMON', 0.10),
('해마', 'COMMON', 0.10),
('복어', 'COMMON', 0.10),
('해파리', 'COMMON', 0.10),
('말미잘', 'COMMON', 0.10),
('구피', 'COMMON', 0.10),
-- RARE (4개)
('바다거북', 'RARE', 0.0625),
('문어', 'RARE', 0.0625),
('상어', 'RARE', 0.0625),
('전기뱀장어', 'RARE', 0.0625),
-- LEGENDARY (2개)
('심해해룡', 'LEGENDARY', 0.025),
('리바이어던', 'LEGENDARY', 0.025)
ON DUPLICATE KEY UPDATE 
    fish_name = VALUES(fish_name),
    grade = VALUES(grade),
    probability = VALUES(probability);

-- ============================================
-- 기존 데이터가 있는 경우 업데이트 방법
-- ============================================
-- 만약 이미 fish_id가 할당된 데이터가 있다면,
-- 아래 방법으로 업데이트할 수 있습니다:

-- UPDATE fish SET fish_name = '흰동가리', grade = 'COMMON', probability = 0.10 WHERE fish_id = 1;
-- UPDATE fish SET fish_name = '열대어', grade = 'COMMON', probability = 0.10 WHERE fish_id = 2;
-- UPDATE fish SET fish_name = '해마', grade = 'COMMON', probability = 0.10 WHERE fish_id = 3;
-- UPDATE fish SET fish_name = '복어', grade = 'COMMON', probability = 0.10 WHERE fish_id = 4;
-- UPDATE fish SET fish_name = '해파리', grade = 'COMMON', probability = 0.10 WHERE fish_id = 5;
-- UPDATE fish SET fish_name = '말미잘', grade = 'COMMON', probability = 0.10 WHERE fish_id = 6;
-- UPDATE fish SET fish_name = '구피', grade = 'COMMON', probability = 0.10 WHERE fish_id = 7;
-- UPDATE fish SET fish_name = '바다거북', grade = 'RARE', probability = 0.0625 WHERE fish_id = 8;
-- UPDATE fish SET fish_name = '문어', grade = 'RARE', probability = 0.0625 WHERE fish_id = 9;
-- UPDATE fish SET fish_name = '상어', grade = 'RARE', probability = 0.0625 WHERE fish_id = 10;
-- UPDATE fish SET fish_name = '전기뱀장어', grade = 'RARE', probability = 0.0625 WHERE fish_id = 11;
-- UPDATE fish SET fish_name = '심해해룡', grade = 'LEGENDARY', probability = 0.025 WHERE fish_id = 12;
-- UPDATE fish SET fish_name = '리바이어던', grade = 'LEGENDARY', probability = 0.025 WHERE fish_id = 13;

