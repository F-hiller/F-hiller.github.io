---
title: "[프로그래머스] 행렬 테두리 회전하기 - 77485 (C++)"
date: 2022-07-16 16:06:09 +0900
categories: [ProblemSolving, Programmers]
tags: [implement, level2, cpp]
use_math: true
---

## 문제

- 코딩테스트 연습 - 행렬 테두리 회전하기

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/77485" %}

## 풀이

문제의 내용을 구현하는 문제이다. 행렬을 만들면 문제의 조건에 따라 i행 j열에 있는 숫자는 $((i-1) x columns + j)$이다. 이를 바탕으로 행렬 테두리 회전을 진행시켜주었다.

자세한 구현은 아래와 같다.

1. A 좌표와 B 좌표가 주어졌을 때 A가 좌측 최상단, B가 우측 최상단에 있는 도넛 모양의 행렬 테두리를 정의할 수 있다.
2. 이 때 행렬 테두리 범위안에 있는 모든 좌표들을 시계방향으로 한 칸 씩 움직이려고 한다.
3. 우선 A 좌표부터 시작하여 시계방향으로 나아가면서
   다음 좌표에 현재 좌표의 값을 넣어주면 된다. 물론 현재 좌표의 값은 회전하기 이전의 값이여야하므로 별도의 공간(itemp)에 잠시 저장해두는 방식을 사용하였다.  
   $itemp=matrix[Pos_{next}]$  
   $matrix[Pos_{next}]=matrix[Pos_{cur}]$  
   $matrix[Pos_{cur}]=itemp$
4. 한 번의 회전을 진행하면서 건드리는 모든 값은 ans_value와 비교하여 최솟값을 저장해두며 query를 통한 회전 1번이 끝나면
   answer 배열에 최솟값을 저장해준다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;
typedef pair<int, int> pii;

int board[101][101];

void moving(int first_board, int second_board, int &value, int &ans_value);
vector<int> solution(int rows, int columns, vector<vector<int>> queries)
{
    vector<int> answer;
    int i, j, itemp;
    // set array
    for (i = 1; i <= rows; i++)
    {
        for (j = 1; j <= columns; j++)
        {
            board[i][j] = ((i - 1) * columns + j);
        }
    }

    // simulate query
    for (auto &&pos : queries)
    {
        pii first_pos = pii(pos[0], pos[1]);
        pii second_pos = pii(pos[2], pos[3]);
        int value = board[first_pos.first][first_pos.second];
        int ans_value = 987654321;
        for (i = first_pos.second + 1; i <= second_pos.second; i++)
        {
            moving(first_pos.first, i, value, ans_value);
        }
        for (i = first_pos.first + 1; i <= second_pos.first; i++)
        {
            moving(i, second_pos.second, value, ans_value);
        }
        for (i = second_pos.second - 1; i >= first_pos.second; i--)
        {
            moving(second_pos.first, i, value, ans_value);
        }
        for (i = second_pos.first - 1; i >= first_pos.first; i--)
        {
            moving(i, first_pos.second, value, ans_value);
        }
        answer.push_back(ans_value);
    }

    return answer;
}
void moving(int first_board, int second_board, int &value, int &ans_value)
{
    int itemp = board[first_board][second_board];
    board[first_board][second_board] = value;
    value = itemp;
    ans_value = min(ans_value, value);
}
```
