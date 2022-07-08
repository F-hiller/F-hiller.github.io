---
title: "[프로그래머스] 디스크 컨트롤러 - 42627 (C++)"
date: 2022-07-08 20:54:17 +0900
categories: [ProblemSolving, Programmers]
tags: [heap, level3, cpp]
---

## 문제

- 코딩테스트 연습 - 디스크 컨트롤러

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/42627" %}

## 풀이

heap을 이용한 문제이다. 푸는 방식에 대해서는 알았지만 코드로 구현하는 과정에서 꼬여서 많이 복잡해졌다. 풀이는 다음과 같다.

1. 입력 배열이 정렬되지 않았으므로 jobs[i][0]에 대해서 오름차순으로 정렬해준다. (요청 시각이 짧은 순으로 정렬)
2. 현재 처리 중인 요청이 끝날 때까지 들어오는 모든 요청을 priority queue에 넣어준다.
3. priority queue는 jobs[i][1]이 작은 값이 top에 오게 된다. (처리 시간이 작은 순으로 정렬)
4. 만약 priority queue가 비었다면 다음 요청 시각까지 들어오는 모든 요청을 priority queue에 넣어준다.
   이 부분을 놓쳐서 코드가 복잡해졌는데 만약 (0, 1)요청의 처리가 끝나고 같은 시각에서의 요청 (3, 6), (3, 7)이 들어왔을 때 이 둘 모두를 priority queue에 넣어주어야한다.
5. priority queue의 top에 있는 요청을 처리하고 있음을 반영하기 위해 현재 처리 중인 요청이 끝나는 시각을 저장해준다. 다음 요청을 확인하며 2)로 돌아간다.

## 개선할 점

해당 문제의 경우, 코드를 작성하면서 하나의 논리를 놓쳐 다른 방식으로 구현하다 반복적으로 틀리는 경우였다. 무엇이 필요한지(현재 작업 중인 요청이 끝나는 시각, 다음 요청), 필요한 것을 제공하기 위해서 어떤 논리, 방식을 사용할지(priority queue의 empty여부에 따라 끝나는 시각을 다르게 설정, priority queue에서 다음 요청 뽑아냄)를 꼼꼼하게 생각해보고 진행하도록 하자.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef pair<int, int> pii;

struct comp_pq
{
    bool operator()(pii a, pii b)
    {
        return a.second > b.second;
    }
};
bool comp_sort(pii a, pii b)
{
    return a.first < b.first;
}

int solution(vector<vector<int>> jobs)
{
    int answer = 0;
    priority_queue<pii, vector<pii>, comp_pq> pq;
    vector<pii> jobs_pii;
    int i;
    int job_size = jobs.size();

    // set and sort
    for (auto job : jobs)
    {
        jobs_pii.push_back(pii(job[0], job[1]));
    }
    sort(jobs_pii.begin(), jobs_pii.end(), comp_sort);

    int cnt = 0;
    int end_time = 0;
    int index = 0;
    while (cnt < job_size)
    {
        while (index < job_size && jobs_pii[index].first <= end_time)
        {
            pq.push(jobs_pii[index++]);
        }
        if (pq.empty())
        {
            end_time = jobs_pii[index].first;
            continue;
        }
        pii top = pq.top();
        pq.pop();
        end_time += top.second;
        answer += end_time - top.first;
        cnt++;
    }

    return answer / job_size;
}
```
