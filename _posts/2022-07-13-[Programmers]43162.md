---
title: "[프로그래머스] 네트워크 - 43162 (C++)"
date: 2022-07-13 14:42:37 +0900
categories: [ProblemSolving, Programmers]
tags: []
#수학식사용 use_math: true
---

## 문제

- 코딩테스트 연습 - 네트워크

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/43162" %}

## 풀이

간선으로 연결된 네트워크의 갯수를 구하는 문제이다.

모든 노드의 방문 여부를 기록하는 1차원 bool형 배열 visited를 통해 모든 노드들을 확인할 수 있다.

모든 노드를 확인하면서 만약 해당 노드가 방문되지 않은 노드라면 bfs를 통해 해당 노드와 연결된 네트워크 전체를 확인해준다. 따라서 bfs를 통해 만나는 노드들은 모두 방문처리를 해준다. 해당 네트워크는 새로운 네트워크이므로 answer를 1 증가시켜준다.

모든 노드를 방문했다면 answer의 값 만큼 네트워크의 개수가 있음을 확인할 수 있다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> pii;

bool visited[201] = {0,};

void bfs(int start, int &n, vector<vector<int>> &computers){
    int i;
    queue<int> q;
    q.push(start);
    while(!q.empty()){
        int front = q.front();
        q.pop();
        if(!visited[front]){
            visited[front] = 1;
            for(i=0;i<n;i++){
                if(computers[front][i] == 1){
                    q.push(i);
                }
            }
        }
    }
    return;
}

int solution(int n, vector<vector<int>> computers) {
    int answer = 0;
    int i;
    for(i=0;i<n;i++){
        if(!visited[i]){
            answer++;
            bfs(i, n, computers);
        }
    }
    return answer;
}
```
