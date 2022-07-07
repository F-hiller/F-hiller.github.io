---
title: "[프로그래머스] 정수 삼각형 - 43105 (C++)"
date: 2022-07-07 14:58:56 +0900
categories: [ProblemSolving, Programmers]
tags: [dp, cpp, python]
---

## 문제

- 코딩테스트 연습 - 정수 삼각형

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/43105" %}

## 풀이

파스칼의 삼각형과 비슷하면서 dp를 사용해 해결한 문제이다. 삼각형의 가장 윗 꼭대기에서 아래로 내려오는 경로에 있는 값의 합이 최대가 되는 값을 찾는 문제이다. 풀이는 다음과 같다.

1. 높이가 k인 삼각형의 모든 가로 열에 대해 가장 위에 있는 열을 0번 열, 가장 아래에 있는 열을 k-1번 열이라고 하자.
2. 인덱스 i, j에 대하여 i번째 열의 j번째 위치로 올 수 있는 경로 P(i, j)는 문제에서 주어진 바에 따라 P(i-1, j-1) 또는 P(i-1, j)에서 오는 경로 뿐이다. 결국 두 경로 중에 하나를 선택해야하는데 선택의 기준을 현재까지 지나온 경로의 합이 가장 큰 경로로 정하면 된다.
3. 경로를 선택하고 나면 현재 위치의 경로 값을 더해서 저장해주면 된다.
4. 따라서 $P(i, j) = max( P( i-1, j-1 ), P( i-1, j ) )+ value(i, j);$ 가 된다. 두 경로 중에 하나가 없는 경우에는 다른 한 쪽 경로를 바로 선택해주면 된다.
5. 0번째 열부터 마지막 열까지 계산을 끝내면 k-1번째 열에는 해당 위치로 올 수 있는 경로의 최댓값이 저장된다. 따라서 이들 중에서 가장 큰 값을 찾아 answer에 저장해주면 된다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

int P[500][500] = {0,};

int solution(vector<vector<int>> triangle) {
    int answer = 0;
    int i, j;
    int left, right;
    P[0][0] = triangle[0][0];
    for(i=1;i<triangle.size();i++){
        for(j=0;j<triangle[i].size();j++){
            left=P[i-1][j-1];
            right=P[i-1][j];
            if(j==0){
                P[i][j] = right+triangle[i][j];
                continue;
            }
            if(j==triangle[i].size()-1){
                P[i][j] = left+triangle[i][j];
                continue;
            }
            P[i][j] = max(left, right)+triangle[i][j];
        }
    }
    answer = *max_element(P[triangle.size()-1], P[triangle.size()-1]+triangle[triangle.size()-1].size());
    return answer;
}
```
