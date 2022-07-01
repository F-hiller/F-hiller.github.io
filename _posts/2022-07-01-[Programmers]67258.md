---
title: "[프로그래머스] 보석 쇼핑 - 67258 (Python)"
date: 2022-07-01 19:28:20 +0900
categories: [ProblemSolving, Programmers]
tags: [two pointer, python, level3] # TAG names should always be lowercase
---

### 문제

[코딩테스트 연습 - 보석 쇼핑](https://programmers.co.kr/learn/courses/30/lessons/67258)

### 풀이

무작위 보석들이 담긴 배열이 주어질 때 모든 보석이 최소 하나씩은 들어간 가장 짧은 구간을 찾는 two pointer 문제이다. gem_dict에 보석의 종류를 저장해주고 보석을 탐색할 때 가장 앞부분은 head, 가장 뒷부분은 tail로 표시하고 진행하였다. 풀이 과정은 다음과 같다.

1. tail을 1씩 늘리면서 새로운 보석을 구간에 넣는다.
2. head에 해당하는 보석을 없애도 구간에 해당 보석이 하나 이상 존재하는지 확인한다.
   이는 dict형식인 cur_range에 보석의 종류마다 갯수를 기록해두는 것으로 확인할 수 있다.
3. 만약 head를 빼도 된다면 cur_range에서 head에 해당하는 보석을 하나 빼준다.
4. cur_range에 있는 보석의 종류와 gem_dict에 있는 보석의 종류가 같다면( == len이 같다면) 해당 구간에 모든 보석이 최소 하나씩은 존재한다는 의미이므로 정답의 후보가 될 수 있다.
5. 결과를 저장해둘 변수 result_len과 비교하여 현재 head~tail 의 길이가 result_len보다 짧다면 result_len에 기록해둔다.
   만약 result_len과 길이가 같다면 문제의 조건 “시작 진열대 번호가 가장 작은 구간”에 따라 result에 기록할 필요가 없다.
6. tail이 보석 진열대의 끝에 도달하면 끝이 난다.

- Code

```python
def solution(gems):
    gem_dict = {}
    for i in gems:
        if i in gem_dict:
            gem_dict[i] += 1
        else :
            gem_dict[i] = 1

    result_len = 987654321
    result_head = 0
    result_tail = 0

    cur_range = {}
    head = 0
    tail = 0
    while tail < len(gems):

        if gems[tail] in cur_range:
            cur_range[gems[tail]] += 1
        else:
            cur_range[gems[tail]] = 1

        while gems[head] in cur_range and cur_range[gems[head]] > 1:
            cur_range[gems[head]] -= 1
            head += 1
        if len(gem_dict) == len(cur_range) and result_len > tail-head+1:
            result_len = tail-head+1
            result_head = head
            result_tail = tail

        tail+=1

    answer = []
    answer.append(result_head+1)
    answer.append(result_tail+1)
    return answer
```
