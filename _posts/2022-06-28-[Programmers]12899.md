---
title: "[프로그래머스] 124 나라의 숫자"
date: 2022-06-28 23:47:40 +0900
categories: [ProblemSolving, Programmers]
tags: [greedy, cpp, level2] # TAG names should always be lowercase
---

### 문제

[코딩테스트 연습 - 124 나라의 숫자](https://programmers.co.kr/learn/courses/30/lessons/12899)

### 풀이

10진법의 수를 1, 2, 4만을 사용하여 표현하는 문제이다. 처음에는 진법 변환을 바탕으로 풀이를 진행하였으나 0을 사용하지 않는다는 점 때문에 해당 방식으로는 해결할 수 없었다. 결국 모든 자릿수는 0이 될 수 없으므로 1이상의 숫자로 채워져야한다는 의미이다. 그래서 생각해낸 방식은 다음과 같다.

1. n이하의 숫자들 중 모든 3진법 자릿수에 1을 채우는 수를 구한다. 즉 n보다 작거나 같으며 3^x의 합들로 구성된 숫자들 중 최댓값을 구한다.
2. 해당 수를 자릿수 단위로 count 배열에 기록하고 n에서 뺀다.
3. 가장 큰 x부터 시작하여 1씩 감소하는 x가 있다고 하자. n을 3^x로 나누었을 때 그 몫이 변수q에 저장한다. q가 3이면(4이상은 논리적으로 나올 수 없다.) q를 2로 바꿔준다.
4. q\*3^x를 n에서 빼주고 count배열에 3^x위치에 해당하는 값을 q만큼 더해준다.
5. 모든 과정이 진행되면 count배열에는 1~3 값을 가지는 배열이 나온다.
6. 3값을 4로 치환해주고 count배열을 역순으로(뒤에서부터) 읽어주면 정답(answer)이 된다.

말이 두서가 없는 것 같다. 나중에 다시 생각을 정리해서 정리된 풀이를 설명하고 싶다.

### 개선할 점

0이 없어 모든 자릿수가 채워져야함을 조금더 일찍 파악했으면 좋았을 것 같다. 시행착오가 너무 오래 걸렸다.

- Code

```cpp
#include <bits/stdc++.h>
using namespace std;

// additional variables and functions
int all_arr[20] = {
    0,
};
int nextV[4] = {0, 0, 1, 2};
char realV[4] = {'0', '1', '2', '4'};
string solution(int n)
{
    string answer = "";
    int itemp = 1;
    int cnt = 0;
    while (true)
    {
        if (itemp > n)
        {
            break;
        }
        n -= itemp;
        all_arr[cnt] = 1;
        itemp *= 3;
        cnt++;
    }

    while (itemp)
    {
        int quo = n / itemp;
        int rem = n % itemp;
        if (quo == 3)
        {
            quo = 2;
        }
        n -= itemp * quo;
        all_arr[cnt] += quo;
        itemp /= 3;
        cnt--;
    }
    int i = 0;
    char ctemp;
    stack<char> s;
    while (i <= 19)
    {
        ctemp = realV[all_arr[i++]];
        if (ctemp == '0')
        {
            break;
        }
        s.push(ctemp);
    }
    while (!s.empty())
    {
        answer.push_back(s.top());
        s.pop();
    }

    return answer;
}

// main function
int main()
{
    // fastio;
    int i, j, k;
    // init
    for (i = 1; i < 20; i++)
    {
        cout << i << " " << solution(i) << endl;
    }

    return 0;
}
```
