# [프로그래머스] [1차] 추석 트래픽

### 문제

[[1차] 추석 트래픽](https://programmers.co.kr/learn/courses/30/lessons/17676)

### 풀이

처음에 문제를 접했을 때에는 배열을 이용하여 진행하고자 하였다.
하지만 배열의 크기도 커지고 시간이 매우 오래 걸려서 포기하였다.
문제 해결을 위해 사용한 방법은 다음과 같다.

1.  모든 입력의 (시작시간, 종료시간)을 구한다.
2.  입력은 문제 조건에 따라 종료시간 기준으로 정렬되어있기에 처음부터 차례대로 진행한다
    2-1. i번째 입력에 대해서 i보다 큰 모든 입력을 j라고 하고 cnt = 1로 정한다.
    2-2. j번째 입력의 시작시간이 i번째 입력의 종료시간보다 앞서면(작으면) cnt += 1해준다.
3.  cnt의 값과 answer를 비교해서 큰 값을 저장해준다.

- Code

```python
def get_pair(line):
    arr = line.split()
    end_time = arr[1].split(':')
    end_hour = int(end_time[0]) * 60 * 60 * 1000
    end_minute = int(end_time[1]) * 60 * 1000
    end_second = int(float(end_time[2]) * 1000)
    end_time = end_hour + end_minute + end_second
    duration = int(float(arr[2].split('s')[0]) * 1000) - 1
    return end_time, duration

change_list = []

def solution(lines):
    answer = 0

    for line in lines:
        change_list.append(get_pair(line))
    for i in range(len(change_list)):
        pair = change_list[i]
        start_time = pair[0]
        end_time = start_time + 999
        print(end_time)
        cnt = 1
        for j in range(i + 1, len(change_list)):
            after_pair = change_list[j]
            range_time = after_pair[0] - after_pair[1]
            print(range_time)
            if range_time <= end_time:
                cnt += 1
                print(1)
        if answer < cnt:
            answer = cnt
        print("=============================")
    return answer

inputs = ["2016-09-15 20:59:57.421 0.351s"
    , "2016-09-15 20:59:58.233 1.181s"
    , "2016-09-15 20:59:58.299 0.8s", "2016-09-15 20:59:58.688 1.041s", "2016-09-15 20:59:59.591 1.412s",
          "2016-09-15 21:00:00.464 1.466s", "2016-09-15 21:00:00.741 1.581s", "2016-09-15 21:00:00.748 2.31s",
          "2016-09-15 21:00:00.966 0.381s", "2016-09-15 21:00:02.066 2.62s"]
print(solution(inputs))

```
