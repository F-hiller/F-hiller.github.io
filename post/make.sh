#!/usr/bin/env sh

# 현재 날짜를 YYYY-MM-DD 형식으로 가져옵니다.
current_date=$(date +"%Y-%m-%d")
filename="post/posts/$current_date.md"
count=1

# post 폴더가 없으면 생성합니다.
mkdir -p post/posts

# 파일 이름이 이미 존재하는 경우 번호를 추가하여 새로운 이름을 생성합니다.
while [[ -e $filename ]]; do
    filename="post/posts/$current_date($count).md"
    ((count++))
done

# markdown 파일을 post 폴더 안에 생성합니다.
cat << EOF > "$filename"
---
code_numbers: 
language: 
title: 
date: $(date +"%Y-%m-%d %H:%M:%S %z")
categories: []
tags: []
#use_math: true
---
## 문제

- 코딩테스트 연습 - 
{% linkpreview "" %}

- [코딩테스트 연습 - ]()

## 풀이

### 코드
EOF

echo "[Success] : File $filename has been created!"
