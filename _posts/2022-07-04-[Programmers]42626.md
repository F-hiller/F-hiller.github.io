---
title: "[프로그래머스] 더 맵게 - 42626 (Python)"
date: 2022-07-04 18:10:39 +0900
categories: [ProblemSolving, Programmers]
tags: [heap, python, level2]
---

### 문제

- 코딩테스트 연습 - 더 맵게

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/42626" %}

### 풀이

가장 스코빌 지수가 낮은 음식을 루프를 돌 때마다 찾아야한다. 이는 우선순위 큐(heap)으로 해결할 수 있으며 파이썬에서 heap을 사용해보고자 언어를 파이썬으로 진행하였다.

파이썬에서는 heapq와 PriorityQueue가 존재하는데 그 중 heapq를 사용하여 진행하였다.

음식의 갯수와 값에 따라 여러 조건이 나오는데 내용은 아래와 같다.

1. 남은 음식의 갯수가 1개. 이 상황은 음식을 더 이상 섞을 수 없으므로 해당 음식의 스코빌지수에 따라 answer값을 결정해주면 된다.
2. 음식 갯수가 2개 이상 + 스코빌 지수가 가장 낮은 음식의 값 < K. 음식을 섞어줘야하므로 스코빌 지수가 두 번째로 낮은 음식의 값을 찾아서 섞어준다. 이 때 heap에서는 음식 2개를 빼고 섞은 음식 1개를 새로 추가해주면 된다. 한 번 음식을 섞으므로 answer = answer + 1을 해준다.
3. 음식 갯수가 2개 이상 + 스코빌 지수가 가장 낮은 음식의 값 ≥ K. 음식을 더 이상 섞을 필요가 없으므로 그대로 answer를 return 해준다. 구현에서는 while문을 탈출해줬다.

- Code

```python
import heapq
def solution(scoville, K):
    answer = 0
    heapq.heapify(scoville)
    while(True):
        if(len(scoville) >= 2 and scoville[0] < K):
            first = heapq.heappop(scoville)
            second = heapq.heappop(scoville)
            heapq.heappush(scoville, first+2*second)
            answer += 1
            continue
        break
    if scoville[0] < K:
        answer = -1

    return answer
```
