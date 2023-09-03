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
code_numbers: a b
language: c
title: d
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
/*
[a] d - b (c) 의 형식으로 title이 작성된다. 수식을 사용하는 게시글의 경우는 use_math 주석을 해제하고 작성하면 된다.
카테고리는 대문자로 시작하고 태그는 소문자로 시작한다. "," 콤마로 구분하여 작성하면 된다. 
프로그래머스 링크처럼 미리보기 이미지 등이 갖춰져있는 경우 linkpreview를, 그냥 링크만 달아두는 경우는 markdown 문법을 사용하면 된다.
*/
EOF

echo "[Success] : File $filename has been created!"
