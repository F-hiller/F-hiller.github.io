---
title: "[프로그래머스] 단체사진 찍기 - 1835 (C++)"
date: 2022-07-15 16:48:00 +0900
categories: [ProblemSolving, Programmers]
tags: [brute force, dfs, level2, cpp]
#수학식사용 use_math: true
---

## 문제

- 코딩테스트 연습 - 단체사진 찍기

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/1835" %}

## 풀이

8명이 조건에 맞게 줄을 서는 경우의 수를 찾는 문제이다. 8명이 줄을 서는 모든 경우의 수는 8! == 40320, 약 4만개이다. 이는 완전탐색을 통해서 모든 경우의 수를 확인해볼 수 있다는 의미이다.

따라서 makeGroup함수를 통해 8명이 줄을 서는 경우를 만들어주고 8명이 줄을 섰다면 입력으로 주어진 조건에 해당하는지 확인해준다. 입력을 통해 확인할 수 있는 정보는 2명의 friends 이름(firstMan, secondMan)과 그들 사이에 몇 명의 friends가 올 수 있는지(aimGap)에 관한 정보이다.

2명의 friends 이름을 cpp의 string.find()함수로 현재 줄의 몇 번째에 서있는지를 알 수 있다. 이를 통해 현재 줄에서 두 사람 사이에 몇 명이 서있는지(gap)를 알 수 있고 aimGap과 비교하여 조건을 만족하는지 확인할 수 있다.
조건을 모두 만족했다면 answer에 1을 더해주고 다음 경우로 넘어간다. 이는 재귀함수에서 1을 반환함으로써 구현해주었다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

bool isExisting[8];
vector<char> names;
int friendsToIndex(char c)
{
    int i;
    for (i = 0; i < 8; i++)
    {
        if (names[i] == c)
        {
            return i + 1;
        }
    }
}

int makeGroup(string group, int cnt, int &n, vector<string> &data)
{
    int i;
    int ret = 0;
    if (cnt == 8)
    {
        for (i = 0; i < n; i++)
        {
            char firstMan = data[i][0];
            char secondMan = data[i][2];
            char oper = data[i][3];
            int aimGap = data[i][4] - 48;

            int firstIndex = group.find(firstMan);
            int secondIndex = group.find(secondMan);

            int gap = max(firstIndex, secondIndex) - min(firstIndex, secondIndex) - 1;

            if ((oper == '=' && gap != aimGap) || (oper == '<' && gap >= aimGap) || (oper == '>' && gap <= aimGap))
            {
                return 0;
            }
        }
        return 1;
    }
    for (i = 0; i < 8; i++)
    {
        if (!isExisting[i])
        {
            isExisting[i] = 1;
            ret += makeGroup(group + names[i], cnt + 1, n, data);
            isExisting[i] = 0;
        }
    }
    return ret;
}

// 전역 변수를 정의할 경우 함수 내에 초기화 코드를 꼭 작성해주세요.
int solution(int n, vector<string> data)
{
    int i;
    int answer = 0;
    for (i = 0; i < 8; i++)
    {
        isExisting[i] = 0;
    }
    names = {'A', 'C', 'F', 'J', 'M', 'N', 'R', 'T'};

    answer = makeGroup("", 0, n, data);

    return answer;
}
```
