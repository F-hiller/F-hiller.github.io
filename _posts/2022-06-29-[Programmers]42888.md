---
title: "[프로그래머스] 오픈채팅방"
date: 2022-06-29 19:14:20 +0900
categories: [ProblemSolving, Programmers]
tags: [greedy, python, level2] # TAG names should always be lowercase
---

### 문제

[코딩테스트 연습 - 오픈채팅방](https://programmers.co.kr/learn/courses/30/lessons/42888)

### 풀이

사람마다 정해진 고유 id가 있고 이름만 계속 변하기 때문에 dict를 통해서 id와 name으로 key, value를 정해주었다. 모든 record를 돌면서 Change와 Enter처럼 name이 바뀌는 경우를 찾아서 해당 id의 name을 수정해주기만 하면 된다.

그 후 다시 record를 돌면서 최종적으로 정해진 이름을 실제 record에 대입해주면 된다.

- Code

```python
def solution(record):
    answer = []
    id_name_dict = {}
    for words in record:
        word_list = words.split(" ")
        command = word_list[0]
        uid = word_list[1]
        if command == "Leave":
            continue
        name = word_list[2]
        id_name_dict[uid] = name
    for words in record:
        word_list = words.split(" ")
        command = word_list[0]
        name = id_name_dict[word_list[1]]
        if command == "Leave":
            answer.append(name + "님이 나갔습니다.")
            continue
        if command == "Enter":
            answer.append(name + "님이 들어왔습니다.")

    return answer

print(solution(
    ["Enter uid1234 Muzi", "Enter uid4567 Prodo", "Leave uid1234", "Enter uid1234 Prodo", "Change uid4567 Ryan"]))

```
