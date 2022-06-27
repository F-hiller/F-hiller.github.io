---
title: "[프로그래머스] 문자열 압축"
date: 2022-06-27 22:58:20 +0900
categories: [ProblemSolving, Programmers]
tags: [binary search, python, level2] # TAG names should always be lowercase
---

### 문제

[코딩테스트 연습 - 문자열 압축](https://programmers.co.kr/learn/courses/30/lessons/60057)

### 풀이

[Run-Length Encoding(RLE)](https://en.wikipedia.org/wiki/Run-length_encoding)를 구현해보는 문제이다. 처음에는 loop를 돌면서 길이를 loop_result에 저장해서 진행하는 형식으로 구현하였다. 하지만 마지막 부분을 index 처리하는 과정에서 문제가 생겨서 해당 방식 대신 loop_result에 직접 결과가 되는 string을 저장하는 방식으로 구현하였다.

### 개선할 점

직접 구현하는 방식 또한 문제를 해결하는 좋은 방안이 될 수 있다.

- Code

```python
def solution(s):
    s_len = len(s)
    answer = s_len
    # i는 끊을 단어 수
    for block_len in range(1, s_len // 2 + 1):
        # 압축된 길이를 기록
        loop_result = ""
        prev = s[0:block_len]
        cnt = 1
        for cur_index in range(block_len, s_len, block_len):
            # 이전 쌍과 비교해서 같으면 압축, 내용 저장
            if prev == s[cur_index:cur_index + block_len]:
                cnt += 1
                continue
            # 이전 쌍과 다르고 앞에 저장된 내용이 있다면 결과에 반영
            if cnt > 1:
                loop_result += str(cnt)
            loop_result += prev
            prev = s[cur_index:cur_index + block_len]
            cnt = 1
        # 마지막 쌍 비교해서 반영
        if cnt > 1:
            loop_result += str(cnt)
        loop_result += prev
        # 결과 비교
        if answer > len(loop_result):
            answer = len(loop_result)
    return answer
```
