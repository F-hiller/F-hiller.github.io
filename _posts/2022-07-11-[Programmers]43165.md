---
title: "[프로그래머스] 타겟 넘버 - 43165 (C++)"
date: 2022-07-11 17:55:46 +0900
categories: [ProblemSolving, Programmers]
tags: [dfs, level2, cpp]
---

## 문제

- 코딩테스트 연습 - 타겟 넘버

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/43165" %}

## 풀이

숫자들의 배열이 주어졌을 때 +와 -를 적절히 사용하여 원하는 숫자를 만드는 경우의 수를 찾는 문제이다.

주어진 배열의 길이가 최대 20이므로 +와 -를 이용한 모든 경우의 수는 2^20개, 약 100만개이며 이는 완전탐색을 통해 해결이 가능하다. 따라서 모든 경우를 진행하면서 해당 경우가 목표 숫자(target)과 일치하면 반환값에 1을 더해준다. 최종으로 반환되는 값이 target을 만들 수 있는 경우의 수가 되며 정답이라고 할 수 있다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

int dfs(int value, int index, vector<int> &v, int &target){
    if(index == v.size()){
        if(value == target){
            return 1;
        }
        return 0;
    }
    return dfs(value+v[index], index+1, v, target)+dfs(value-v[index], index+1, v, target);
}

int solution(vector<int> numbers, int target) {
    return dfs(0, 0, numbers, target);
}
```
