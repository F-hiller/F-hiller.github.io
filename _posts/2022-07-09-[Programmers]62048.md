---
title: "[프로그래머스] 멀쩡한 사각형 - 62048 (C++)"
date: 2022-07-09 22:53:19 +0900
categories: [ProblemSolving, Programmers]
tags: [gcd, level2, cpp]
---

## 문제

- 코딩테스트 연습 - 멀쩡한 사각형

{% linkpreview "https://programmers.co.kr/learn/courses/30/lessons/62048" %}

## 풀이

$w*h$크기의 직사각형이 있을 때 전체 블럭 갯수에서 가장 왼쪽 위의 점과 가장 오른쪽 아래의 점을 이은 대각선과 만나는 블럭의 갯수( $hit_{w,h}$ )를 빼주면 되는 문제이다.

문제를 보던 중 GCD를 이용해 문제의 경우를 줄일 수 있음을 알았고 아래와 같이 가정해줄 수 있다.
$g=GCD(w, h)$
$x=w/g$
$y=h/g$
$hit_{w,h}= g*hit_{x, y}$

gcd는 알고 있는 지식에서 해결할 수 있으므로 $hit_{x, y}$에 관한 식만 구하면 문제를 해결할 수 있다. 하지만 해당 식을 계산하는 방법을 구하지 못해서 시간이 오래 걸렸다.
대각선의 직선 경로는 가장 왼쪽 위의 점과 가장 오른쪽 아래의 두 점을 이어주는 최단 경로이다. 이를 블럭의 단위로 생각해본다면 가장 왼쪽 위의 블럭에서 출발하여 가장 오른쪽 아래의 블럭으로 가는 최단 경로로 나타낼 수 있다. 따라서 최단 경로의 길이는 (가로+세로-1) 즉, $(x+y-1)$개이다.
$hit_{x, y}= x+y-1$이므로 $hit_{w,h}=g*(x+y-1)=w+h-g$라고 할 수 있으며
$answer=w*h-(w+h-g)$가 된다.

### 코드

```cpp
#include <bits/stdc++.h>
using namespace std;

int gcd(int a, int b) {
   if (b == 0){
       return a;
   }
   return gcd(b, a % b);
}

long long solution(int w,int h) {
    return (long long)w * h - (w + h - gcd(w, h));
}

```
