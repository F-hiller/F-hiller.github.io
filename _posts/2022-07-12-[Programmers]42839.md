---
title: "[프로그래머스] 소수찾기 - 42839 (C++)"
date: 2022-07-12 15:13:07 +0900
categories: [ProblemSolving, Programmers]
tags: [greedy, recursion, level2, cpp]
#수학식사용 use_math: true
---

## 문제

- 코딩테스트 연습 - 소수찾기

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/42839" %}

## 풀이

주어진 숫자들을 1개 이상 조합하여 만들 수 있는 소수의 갯수를 구하는 문제이다.

문제에서 필요한 내용은 2가지이다.

1. 조합을 통해 어떤 숫자들을 만들 수 있는가
2. 그 숫자들이 소수인가

1)의 내용은 재귀함수를 통해 모든 경우를 조합해서 set에 중복없이 저장해두기로 하였으며,

2)의 내용은 에라토스테네스의 체를 통해 7자리 이하의 모든 숫자들이 prime인지를 확인해주었다.

set에 있으며 prime인 숫자들의 갯수를 세어서 answer로 return해주면 문제를 해결할 수 있다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

bool visited[7];
set<int> ans;
bool isNotPrime[10000000] = {
    0,
};

void func(int index, string str, int select, int numbers_size, string &numbers)
{
    int i;
    if (index == numbers_size)
    {
        ans.insert(stoi(str));
        return;
    }
    for (i = 0; i < numbers_size; i++)
    {
        if (!visited[i])
        {
            visited[i] = 1;
            func(index + 1, str + numbers[i], select + 1, numbers_size, numbers);
            visited[i] = 0;
        }
        else
        {
            func(index + 1, str, select, numbers_size, numbers);
        }
    }
}

int solution(string numbers)
{
    int answer = 0, i, j;

    for (i = 2; i < 10000000; i++)
    {
        if (!isNotPrime[i])
        {
            for (j = i + i; j < 10000000; j += i)
            {
                isNotPrime[j] = 1;
            }
        }
    }

    func(0, "", 0, numbers.size(), numbers);

    for (auto value : ans)
    {
        if (value > 1 && !isNotPrime[value])
        {
            answer++;
        }
    }

    return answer;
}
```
