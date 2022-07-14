---
title: "[프로그래머스] 카카오프렌즈 컬러링북 - 1829 (C++)"
date: 2022-07-14 16:01:17 +0900
categories: [ProblemSolving, Programmers]
tags: []
#수학식사용 use_math: true
---

## 문제

- 코딩테스트 연습 - 카카오프렌즈 컬러링북

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/1829" %}

## 풀이

별다른 조건이 없는 bfs 문제이다. bfs를 통해 최대 영역 크기를 구할 수 있고, bfs를 몇 번 실행하는지에 따라 전체 영역의 갯수를 구할 수 있다.

bfs를 진행할 때 해당 칸이 빈칸이 아니고 현재 진행중인 bfs 영역의 색과 같은지를 확인해주면서 진행해주면 문제를 해결할 수 있다.

프로그래머스의 문제들은 전역변수 사용시 반드시 함수안에서 초기화 작업을 진행해줘야한다. 아래 코드에서는 따로 적지는 않았지만 문제를 제출하려한다면 초기화 작업을 하기를 바란다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> pii;

bool visited[101][101] = {
    0,
};
int dirY[4] = {-1, 0, 1, 0};
int dirX[4] = {0, 1, 0, -1};

int bfs(int y, int x, int &m, int &n, vector<vector<int>> &picture)
{
    int i;
    int cnt = 0;
    int cur_value = picture[y][x];
    queue<pii> q;
    q.push(pii(y, x));
    while (!q.empty())
    {
        pii front = q.front();
        q.pop();
        int frontY = front.first;
        int frontX = front.second;
        if ((-1 < frontY && frontY < m && -1 < frontX && frontX < n) && !visited[frontY][frontX] && picture[frontY][frontX] == cur_value)
        {
            visited[frontY][frontX] = 1;
            cnt++;
            for (i = 0; i < 4; i++)
            {
                q.push(pii(frontY + dirY[i], frontX + dirX[i]));
            }
        }
    }
    return cnt;
}

vector<int> solution(int m, int n, vector<vector<int>> picture)
{
    int number_of_area = 0;
    int max_size_of_one_area = 0;
    int i, j;

    for (i = 0; i < m; i++)
    {
        for (j = 0; j < n; j++)
        {
            if (!visited[i][j] && picture[i][j] != 0)
            {
                int itemp = bfs(i, j, m, n, picture);
                max_size_of_one_area = max(max_size_of_one_area, itemp);
                number_of_area++;
            }
        }
    }

    vector<int> answer(2);
    answer[0] = number_of_area;
    answer[1] = max_size_of_one_area;
    return answer;
}
```
