---
title: "[프로그래머스] 가장 먼 노드"
date: 2022-06-30 16:27:30 +0900
categories: [ProblemSolving, Programmers]
tags: [bfs, cpp, level3] # TAG names should always be lowercase
---

### 문제

[코딩테스트 연습 - 가장 먼 노드](https://programmers.co.kr/learn/courses/30/lessons/49189)

### 풀이

노드 1에서 가장 멀리 있는 노드의 갯수를 구하는 문제이다. 문제에서 입력 edge가 간선으로 연결된 노드 쌍을 나타내므로 2차원 vector를 이용하여 list node 형식으로 바꾸어준 후 bfs를 통해 진행하였다. visited 배열은 값이 0이면 방문하지 않은 노드이며 1이상이면 노드 1과의 거리를 나타낸다. max_value에서 나올 수 있는 거리 값의 최대를 저장해두며 모든 bfs가 끝난 후 visited의 값과 max_value가 같은 노드의 갯수를 세어서 answer에 저장해주면 끝이난다.

- Code

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> pii;

int solution(int n, vector<vector<int>> edge)
{
    // init
    int i, j, k;
    int answer = 0;
    vector<vector<int>> node_list(n + 1);

    // set node with list
    for (i = 0; i < edge.size(); i++)
    {
        node_list[edge[i][0]].push_back(edge[i][1]);
        node_list[edge[i][1]].push_back(edge[i][0]);
    }
    // bfs
    queue<pii> q;
    vector<int> visited(n + 1);
    int max_value = 0;

    q.push(pii(1, 1));
    while (!q.empty())
    {
        pii front = q.front();
        q.pop();
        int index = front.first;
        int value = front.second;
        if (!visited[index])
        {
            visited[index] = value;
            for (i = 0; i < node_list[index].size(); i++)
            {
                q.push(pii(node_list[index][i], value + 1));
            }
            if (max_value < value)
            {
                max_value = value;
            }
        }
    }
    for (i = 1; i <= n; i++)
    {
        if (visited[i] == max_value)
        {
            answer++;
        }
    }
    return answer;
}
```
