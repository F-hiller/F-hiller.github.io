---
title: N으로 표현
date: 2022-06-24 23:05:50 +0900
categories: [ProblemSolving, Programmers]
tags: [dp] # TAG names should always be lowercase
---

### 문제

[N으로 표현](https://programmers.co.kr/learn/courses/30/lessons/42895)

### 풀이

(N을 K번 사용한 값)을 찾기 위해서는 (N을 i번 사용한 값)과 (K-i번 사용한 값)을 사칙연산 통해 구할 수 있다. 처음에는 N을 K번 붙이는 경우를 고려하지 않아서 해결하기 어려웠다. 하지만 NN은 N에서 10을 곱하고 N을 더한 값이며 N을 2번 사용한 경우에 해당된다. 이를 for문을 통해 적용해주면 된다.

### 개선할 점

다른 풀이들을 살펴보던 중 unordered_set을 이용한 글을 보았다. 해당 set에 원하는 숫자(number)가 있는지를 찾는 문제이므로 set이 정렬되는지 여부는 중요하지 않다. 따라서 성능을 조금이라도 더 올리고자 한다면 unordered_set을 이용할 수 있다.

- Code

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<set<int>> v(9);
int solution(int N, int number)
{
    // init
    int answer = 0;
    int i, K, l, cur, fir, sec;

    // N을 붙여 나감
    int NN = N;
    for (i = 1; i < 9; i++)
    {
        v[i].insert(NN);
        NN = NN * 10 + N;
    }
    // N이 K번 사용되기 위해서는  i번 + K-i번의 사칙연산을 이용하면 된다.
    for (K = 2; K < 9; K++)
    {
        for (i = 1; i < K; i++)
        {
            for (auto j = v[i].begin(); j != v[i].end(); j++)
            {
                for (auto k = v[K - i].begin(); k != v[K - i].end(); k++)
                {
                    v[K].insert(*j + *k);
                    if (*j - *k > 0)
                    {
                        v[K].insert(*j - *k);
                    }
                    v[K].insert(*j * *k);
                    if (*k)
                    {
                        v[K].insert(*j / *k);
                    }
                }
            }
        }
    }
    for (i = 1; i < 9; i++)
    {
        if (v[i].find(number) != v[i].end())
        {
            return i;
        }
    }
    return -1;
}

// main function
int main()
{
    // fastio;
    int i, j, k;
    // init
    cout << solution(2, 11);

    return 0;
}
```
