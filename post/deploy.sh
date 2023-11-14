#!/bin/sh

# 폴더 경로 지정
DIR_A="post/beforeDeploy/"
DIR_B="_posts/"

# A 폴더에 있는 각 파일을 확인
for file in "$DIR_A"*; do
    if [ -e "$DIR_B$(basename "$file")" ]; then
        # 파일이 B 폴더에 이미 존재한다면 메시지 출력
        echo "이미 존재하는 파일입니다: $(basename "$file")"
        exit 1
    fi
done

# 위의 검사에서 문제가 없다면 A 폴더의 파일들을 B 폴더로 이동
mv "$DIR_A"* "$DIR_B"

echo "\033[31m[Success] : 파일 이동 완료!\033[0m"

# Git 명령어 추가
git add .

git commit -m "upload with deployPosts.sh"

git push

echo -e "\033[31m[Success] : Changes have been pushed to the repository!\033[0m"