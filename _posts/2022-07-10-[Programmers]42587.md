---
title: "[프로그래머스] 프린터 - 42587 (C++)"
date: 2022-07-10 15:08:23 +0900
categories: [ProblemSolving, Programmers]
tags: [priority queue, queue, level2, cpp]
---

## 문제

- 코딩테스트 연습 - 프린터

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/42587" %}

## 풀이

우선순위 큐, 그리고 일반적인 큐를 사용하는 문제이다.

```
1. 인쇄 대기목록의 가장 앞에 있는 문서(J)를 대기목록에서 꺼냅니다.
2. 나머지 인쇄 대기목록에서 J보다 중요도가 높은 문서가 한 개라도 존재하면 J를 대기목록의 가장 마지막에 넣습니다.
3. 그렇지 않으면 J를 인쇄합니다.
```

"대기목록의 가장 앞에 있는 문서(J)"에서 큐를, "대기목록에서 J보다 중요도가 높은 문서"에서 우선순위 큐를 생각할 수 있다. 둘을 활용하는 문제임을 알면 해결할 수 있는 문제였다.

1. 배열로 주어진 인쇄 대기목록을 큐와 우선순위 큐로 만들어준다.
   큐를 통해 대기목록의 가장 앞에 있는 문서를 확인할 수 있으며 우선순위 큐를 통해 대기목록에서 중요도가 가장 높은 문서를 확인할 수 있다.
2. 큐에서 문서를 하나씩 빼면서 해당 문서가 중요도가 가장 높은 문서인지 내가 원하는 문서인지를 확인한다. (우선순위 큐의 top과 비교, 입력으로 들어온 location값과 비교)
3. 2)의 조건에 따라 3개의 경우가 생기는데 중요도가 높지 않은 문서, 중요도가 높지만 원하지 않는 문서, 중요도가 높으며 원하는 문서로 나뉜다.
4. 중요도가 높지 않은 문서는 다시 큐에 넣어주고 큐의 다음 front에 있는 문서를 확인해주면 된다.
5. 중요도가 높지만 원하지 않는 문서는 프린트되므로 answer의 값을 1 증가시켜준다. 해당 문서가 큐에서 사라졌으므로 우선순위 큐의 top 또한 pop시켜준다.
6. 중요도가 높으며 원하는 문서가 나오면 나머지 큐들을 확인해줄 필요가 없으므로 answer를 return해주고 종료해주면 된다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef pair<int, int> pii;

struct comp
{
    bool operator()(pii a, pii b)
    {
        return a.second < b.second;
    }
};

int solution(vector<int> priorities, int location)
{
    int answer = 1, i;
    priority_queue<pii, vector<pii>, comp> pq;
    queue<pii> q;
    for (i = 0; i < priorities.size(); i++)
    {
        pq.push(pii(i, priorities[i]));
        q.push(pii(i, priorities[i]));
    }
    while (!q.empty())
    {
        pii front = q.front();
        q.pop();
        if (front.second == pq.top().second)
        {
            if (front.first == location)
            {
                break;
            }
            answer++;
            pq.pop();
            continue;
        }
        q.push(front);
    }

    return answer;
}
```
