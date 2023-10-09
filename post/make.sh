#!/usr/bin/env sh

TRUE=0
FALSE=1
current_date=$(date +"%Y-%m-%d")

# 질문 1 - 문제 해결(Problem Solving)을 위한 게시글인가요? (y/n)

# 질문 2.1 - 문제 해결을 위한 게시글이라면, 어떤 사이트의 문제인가요? (ex. BOJ, Programmers ...)
# 질문 2.2 - 문제 해결을 위한 게시글이라면, 문제 번호는 무엇인가요? (ex. 1000, 1001 ...)
# 질문 2.3 - 문제 해결을 위한 게시글이라면, 문제의 제목은 무엇인가요?
# 질문 2.4 - 문제 해결을 위한 게시글이라면, 문제를 해결한 언어는 무엇인가요? (ex. C++, Java ...)
# 질문 2.5 - 문제 해결을 위한 게시글이라면, 문제의 태그들은 무엇인가요? (ex. DP, BFS ...)

# 질문 3.1 - 문제 해결을 위한 게시글이 아니라면, 어떤 주제의 게시글인가요? (ex. Book,  ...)
# 질문 3.2 - 문제 해결을 위한 게시글이 아니라면, 주제의 내용은 무엇인가요? (ex. CleanCode1, NodeJS3 ...)
# 질문 3.3 - 문제 해결을 위한 게시글이 아니라면, 주제의 제목은 무엇인가요? (ex. [Book] Clean Code - 2주차 (3장) ...)
# 질문 3.4 - 문제 해결을 위한 게시글이 아니라면, 주제의 카테고리들은 무엇인가요? (ex. Backend, Books, Clean Code ...)
# 질문 3.5 - 문제 해결을 위한 게시글이 아니라면, 주제의 태그들은 무엇인가요? (ex. clean code, book ...)

read -p "질문 1 - 문제 해결(Problem Solving)을 위한 게시글인가요? (y/n) 
--> " isProblemSolving

if [ $isProblemSolving = "y" ]; then
  read -p "질문 2.1 - 어떤 사이트의 문제인가요? (ex. BOJ, Programmers ...) 
--> " site
  read -p "질문 2.2 - 문제 번호는 무엇인가요? (ex. 1000, 1001 ...) 
--> " problemNumber
  read -p "질문 2.3 - 문제의 제목은 무엇인가요? " problemTitle
  read -p "질문 2.4 - 문제를 해결한 언어는 무엇인가요? (ex. C++, Java ...) 
--> " language
  read -p "질문 2.5 - 문제의 태그들은 무엇인가요? (ex. DP, BFS ...) 
--> " tags

  filename="post/posts/$current_date-[$site]$problemNumber.md"
  
  cat << EOF > "$filename"
---
title: "[$site] $problemTitle - $problemNumber ($language)"
date: $(date +"%Y-%m-%d %H:%M:%S %z")
categories: [ProblemSolving, $site]
tags: [$tags]
#use_math: true
---
## 문제

- 코딩테스트 연습 - 
{% linkpreview "" %}

- [코딩테스트 연습 - ]()

## 풀이

### 코드
EOF
  echo "\033[31m[Success] : File $filename has been created!\033[0m"

elif [ $isProblemSolving = "n" ]; then
  read -p "질문 3.1 - 어떤 주제의 게시글인가요? (ex. Book,  ...) 
--> " category
  read -p "질문 3.2 - 주제의 내용은 무엇인가요? (ex. CleanCode1, NodeJS3 ...) 
--> " content
  read -p "질문 3.3 - 주제의 제목은 무엇인가요? (ex. [Book] Clean Code - 2주차 (3장) ...) 
--> " title
  read -p "질문 3.4 - 주제의 카테고리들은 무엇인가요? (ex. Backend, Books, Clean Code ...) 
--> " categories
  read -p "질문 3.5 - 주제의 태그들은 무엇인가요? (ex. clean code, book ...) 
--> " tags

  filename="post/posts/$current_date-[$category]$content.md"

  cat << EOF > "$filename"
---
title: "$title"
date: $(date +"%Y-%m-%d %H:%M:%S %z")
categories: [$categories]
tags: [$tags]
#use_math: true
---
EOF
  echo "\033[31m[Success] : File $filename has been created!\033[0m"
else
  echo "잘못된 입력입니다."
fi

