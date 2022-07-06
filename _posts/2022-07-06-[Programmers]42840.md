---
title: "[프로그래머스] 모의고사 - 42840 (C++)"
date: 2022-07-06 23:56:28 +0900
categories: [ProblemSolving, Programmers]
tags: [greedy, cpp, level1]
---

## 문제

- 코딩테스트 연습 - 모의고사

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/42840" %}

## 풀이

3명의 참가자가 있는데 참가자가 문제를 찍는 방식이 정해져있다.

따라서 배열에 저장하여 문제 번호마다 꺼내쓰는 방식으로 하였다.

모든 문제를 풀었을 때 가장 높은 점수와 일치하는 참가자들을 answer vector에 넣어주고 오름차순으로 정렬해주면 된다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

vector<int> fir = {1, 2, 3, 4, 5};
vector<int> sec = {2, 1, 2, 3, 2, 4, 2, 5};
vector<int> thr = {3, 3, 1, 1, 2, 2, 4, 4, 5, 5};

vector<int> solution(vector<int> answers)
{
    vector<int> answer;
    int i, j, k;
    vector<int> scoreN = {0, 0, 0};
    for (i = 0; i < answers.size(); i++)
    {
        if (fir[i % fir.size()] == answers[i])
        {
            scoreN[0]++;
        }
        if (sec[i % sec.size()] == answers[i])
        {
            scoreN[1]++;
        }
        if (thr[i % thr.size()] == answers[i])
        {
            scoreN[2]++;
        }
    }
    int max_index = max_element(scoreN.begin(), scoreN.end()) - scoreN.begin();
    for (i = 0; i < 3; i++)
    {
        if (scoreN[i] == scoreN[max_index])
        {
            answer.push_back(i + 1);
        }
    }
    sort(answer.begin(), answer.end());
    return answer;
}
```
