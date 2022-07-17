---
title: "[BOJ] 상어 초등학교 - 21608 (C++)"
date: 2022-07-17 22:33:23 +0900
categories: [ProblemSolving, BOJ]
tags: [implement, 골드 5, cpp]
#수학식사용 use_math: true
---

## 문제

- 코딩테스트 연습 - 상어 초등학교

{% linkpreview "https://www.acmicpc.net/problem/21608" %}

## 풀이

네이버 부스트캠프 코딩테스트를 치루면서 구현 문제에 대한 연습이 필요함을 느꼈다. 별다른 알고리즘 없이도 문제가 어려울 수 있음을 느꼈고 구현에 관한 실력을 늘리기 위해서는 많이 풀어보는 수 밖에 없다고 생각했다.

문제를 푸는 과정은 다음과 같다.

1. 입력으로 들어온 학생에 대하여 현재 교실에서 가장 가치가 높은 자리를 찾아주고 거기에 자리를 정해준다. (goSeat함수)
2. 그렇다면 가치가 높은 자리는 어떻게 찾는가?
   = 교실의 모든 자리의 가치를 확인해보고(getSeatValue함수) 가장 높은 자리를 찾을 수 있다.
3. 그렇다면 좌표가 주어진 특정 자리의 가치는 어떻게 확인하는가?
   = 상하좌우를 살펴 그곳에 좋아하는 학생이 많이 앉아있는지, 빈자리가 많은지를 확인할 수 있고 좌표가 주어졌으므로 해당 자리의 행과 열의 가치 또한 확인할 수 있다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;
#define MAX_SIZE 501
#define fastio                   \
    ios::sync_with_stdio(false); \
    cin.tie(0);
typedef long long ll;
typedef pair<int, int> pii;
typedef pair<pii, pii> piii;

// variables
int n, m, K, itemp1, itemp2;
int dirY4[] = {-1, 0, 1, 0};
int dirX4[] = {0, 1, 0, -1};

// additional variables and functions
vector<int> favor_students[401];
int satisfaction_value[] = {0, 1, 10, 100, 1000};
int board[401][401] = {
    0,
};

bool compareValue(piii max_value, piii cur_value)
{
    if (max_value.first.first != cur_value.first.first)
    {
        return max_value.first.first < cur_value.first.first;
    }
    if (max_value.first.second != cur_value.first.second)
    {
        return max_value.first.second < cur_value.first.second;
    }
    if (max_value.second.first != cur_value.second.first)
    {
        return max_value.second.first > cur_value.second.first;
    }
    return max_value.second.second > cur_value.second.second;
}

piii getSeatValue(int y, int x, int studentId)
{
    piii ret = piii(pii(0, 0), pii(y, x));
    int i, j, nextY, nextX, value;
    // search 4 directions
    for (i = 0; i < 4; i++)
    {
        nextY = y + dirY4[i];
        nextX = x + dirX4[i];
        if (0 < nextY && nextY <= n && 0 < nextX && nextX <= n)
        {
            value = board[nextY][nextX];
            // find favor
            for (j = 0; j < 4; j++)
            {
                if (value == favor_students[studentId][j])
                {
                    ret.first.first++;
                    break;
                }
            }
            // find blank
            if (value == 0)
            {
                ret.first.second++;
            }
        }
    }
    return ret;
}

void goSeat(int studentId)
{
    int i, j;
    piii value;
    // piii = ((인접한 좋아하는 학생 수, 인접한 비어있는 칸의 수), (y좌표, x좌표))
    piii max_value = piii(pii(0, 0), pii(n, n + 1));
    // find max value seat
    for (i = 1; i <= n; i++)
    {
        for (j = 1; j <= n; j++)
        {
            if (board[i][j] != 0)
            {
                continue;
            }
            value = getSeatValue(i, j, studentId);
            if (compareValue(max_value, value))
            {
                max_value = value;
            }
        }
    }
    // go to seat
    board[max_value.second.first][max_value.second.second] = studentId;
}

void printResult()
{
    int i, j;
    for (i = 1; i <= n; i++)
    {
        for (j = 1; j <= n; j++)
        {
            cout << board[i][j] << " ";
        }
        cout << endl;
    }
}

int getSatisfaction()
{
    int i, j, k, l, studentId, cnt, nextY, nextX;
    int sum = 0;
    for (i = 1; i <= n; i++)
    {
        for (j = 1; j <= n; j++)
        {
            studentId = board[i][j];
            cnt = 0;
            for (k = 0; k < 4; k++)
            {
                nextY = i + dirY4[k];
                nextX = j + dirX4[k];
                if (0 < nextY && nextY <= n && 0 < nextX && nextX <= n)
                {
                    for (l = 0; l < 4; l++)
                    {
                        if (favor_students[studentId][l] == board[nextY][nextX])
                        {
                            cnt++;
                            break;
                        }
                    }
                }
            }
            sum += satisfaction_value[cnt];
        }
    }
    return sum;
}

// main function
int main()
{
    // fastio;
    int i, j, k;
    // init
    cin >> n;

    int studentId;
    for (i = 0; i < n * n; i++)
    {
        cin >> studentId;
        for (j = 0; j < 4; j++)
        {
            cin >> itemp1;
            favor_students[studentId].push_back(itemp1);
        }
        sort(favor_students[studentId].begin(), favor_students[studentId].end());
        goSeat(studentId);
    }

    cout << getSatisfaction();

    return 0;
}
```
