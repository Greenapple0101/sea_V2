#!/bin/bash

# sea_V2 저장소에 SCA-BE와 SCA-FE 푸시 스크립트

cd /Users/baegseoyeon/Desktop/배포

# 저장소 초기화
echo "저장소 초기화 중..."
rm -rf sea_V2-repo
mkdir sea_V2-repo
cd sea_V2-repo
git init
git remote add origin https://github.com/Greenapple0101/sea_V2.git

# SCA-BE와 SCA-FE 복사
echo "파일 복사 중..."
cp -r ../SCA-BE ./SCA-BE
cp -r ../SCA-FE ./SCA-FE

# application-dev.yaml에서 API 키를 환경변수 참조로 변경
echo "application-dev.yaml 수정 중..."
if [ -f "SCA-BE/application-dev.yaml" ]; then
  sed -i '' 's/api-key: sk-proj-.*/api-key: ${OPENAI_API_KEY:}/' SCA-BE/application-dev.yaml
fi

# .gitignore 확인 (build, node_modules 등은 이미 제외됨)
echo "Git 상태 확인 중..."
git add .
git status

# 커밋
echo "커밋 중..."
git commit -m "Initial commit: SCA-BE and SCA-FE"

# 푸시
echo "푸시 중..."
GIT_SSL_NO_VERIFY=true git push -u origin main

echo "완료!"

