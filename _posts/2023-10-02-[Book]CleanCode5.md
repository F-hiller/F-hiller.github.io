---
title: "[Book] Clean Code - 4주차 (7장, 8장)"
date: 2023-10-02 01:00:56 +0900
categories: [Backend, Books, Clean Code]
tags: [clea code, book]
#use_math: true
---

# 오류 처리

오류가 발생할 확률이 0이 되는 일은 존재하지 않는다. 오류 처리를 어떻게 하느냐에 따라 코드의 논리를 잘 드러내는지가 결정된다고 볼 수 있다.

### 오류 코드보다 예외를 사용하라

앞선 챕터들에서도 몇 번 이야기가 나왔던 이야기이다. 오래된 언어들은 예외를 지원하지 않는 경우가 많았고 오류를 처리하고 보고하는 방법이 제한적이었기에 오류 코드를 사용했다. 하지만 Java의 Try-Catch-Finally 구문과 같이 Exception 처리를 지원하는 언어라면 해당 기능을 통해서 오류 처리와 기능 부분을 구분하도록 하자.

```java
// class 안의 함수들이다.

public void sendShutDown(){
    try {
        tryToShutDown();
    } catch (DeviceShutDownError e) {
        logger.log(e);
    }
}

private void tryToShutDown () throws DeviceShutDownError {
    // 논리 전개...
}

```  
<br>

### Checked Exception VS Unchecked Exception

확인 예외, 미확인 예외를 명확히 알지 못해 검색을 통해 찾아보았다. [Checked VS Unchecked](https://devlog-wjdrbs96.tistory.com/351)  
간단히 정리하자면 확인 예외는 반드시 try-catch를 통해서 오류 처리 코드를 작성해야하는 예외들이며, 비확인 예외는 RuntimeException의 범주에 속하는 예외들로 개발자에 의해 선택적으로 try-catch 구문을 작성할 수 있다. 확인 예외는 아래 코드와 같이 throws를 붙여줘야한다.
```java
public void test() throws IOException {
    // ...
}
```  
<br>

초창기 자바는 확인 예외를 좋다고 여겼지만 현재는 Open-Closed Principle을 위반하는 문제가 있는 과정이라고 여긴다. 하위 단계 함수에서 예외를 throw한다면 해당 코드를 포함하는 모든 상위 단계 함수 선언부에 throws를 추가하여 수정해야한다.  
<br>

따라서, 확인 예외를 사용함으로써 모든 예외를 확인할 필요가 있는 경우를 제외하고는 일반적으로 Unchecked Exception의 사용을 권장한다.  
<br>

### 호출자를 고려해 예외 클래스를 정의하라

이 부분은 글을 읽어도 이해가 되지 않는 부분들이 존재해서 코드를 대부분 적어보려고 한다.

```java
ACMEPort port = new ACMEPort(12);

try {
    port.open();
} catch (DeviceReseponseException e) {
    reportPortError(e);
    logger.log("Device response exception", e);
} catch (ATM1212UnlockedException e) {
    reportPortError(e);
    logger.log("Unlock exception", e);
} finally { 
    // ...
}
```  
<br>

호출해서 사용하는 외부 라이브러리 API가 존재한다면 아래와 같이 Wrapper Class를 통해서 예외를 작성하는 것이 더 좋다고 한다.  
<br>

```java
// 사용 예시
LocalPort port = new LocalPort(12);
try {
    port.open();
} catch (PortDeviceFailure e) {
    retportError(e);
    logger.log(e.geMessage(), e);
} finally {
    // ...
}

// Wrapper Class 파일
public class LocalPort {
    private ACMEPort innerPort;

    public LocalPort(it portNumber) {
        innerPort = new ACMEPort(portNumber);
    }

    public void open() {
        try {
            innerPort.open();
        } catch (DeviceReseponseException e) {
            throw new PortDeviceFailure(e);
        } catch (ATM1212UnlockedException e) {
            throw new PortDeviceFailure(e);
        } 
    }
    // ...
}
```  
<br>

Wrapper 클래스를 통해서 외부 라이브러리와 프로그램 사이의 의존성을 줄이며, 다른 라이브러리로 전환하기에도 용이하다고 한다.  
<br>

### 정상 흐름을 정의하라

try-catch 구문을 사용하지 않고도 진행할 수 있는지 확인해봐야한다.  
<br>

```java
try {
    MealExpenses expenses = expenseReportDAO.getMeals(employeee.getID());
    m_total += expenses.getTotal();
} catch(MealExpensesNotFound e) {
    m_total += getMealPerDiem();
}
```  
<br>

expenses.getTotal()에서 에러를 발생하는 대신 getMealPerDiem에 해당하는 기능을 수행하면 될 것이다. 또한, expenses에 null이 올 수도 있으므로 expenseReportDAO에는 항상 MealExpenses 객체를 반환하도록 수정해주어야한다.  
<br>

이를 특수 사례 패턴(Special Case Pattern)이라고 하며 클래스를 만들거나 객체를 조작해 특수 사례를 처리하는 방식이라고 한다.  
[특수 사례 패턴 1](https://apiumhub.com/tech-blog-barcelona/special-case-pattern/)  
[특수 사례 패턴 2](https://java-design-patterns.com/patterns/special-case/#explanation)  
<br>

### null을 반환하지 마라

바로 앞에서 이야기한 것처럼 메소드릐 반환 값이 null이 되는 경우 null 확인을 하지 않아서 발생하는 NullPointerException과 같은 문제가 매우 자주 발생할 수 있다. 따라서 되도록 null을 반환하지 않게, 오류가 발생하지 않도록 특수 사례 패턴의 적용을 고려해보자.  
<br>

```java
List<Employee> employees = getEmployees();
if(employees != null) {
    for(Employee e : employees) {
        totalPay += e.getPay();
    }
}
```  
<br>

만약 위 코드에서 getEmployees()라는 함수가 null 대신 Collections.emptyList()와 같이 비어있는 List를 반환한다면 if 문을 없애도 정상적으로 작동할 것이다.  
<br>

+ null을 전달하지 마라

앞에서 이야기한 내용의 연장선이다. 정상적인 인수로 null을 기대하는 API가 아니라면 메서드로 null을 전달하는 것을 최대한 피하는 것이 좋다. 만약 어떤 이유로든 null의 전달을 허용한다면 해당 문제를 처리할 코드가 필요해지며 이는 클린하지 않은 코드가 될 확률이 높아질 것이다.  
<br>

## 결론

이번 챕터에서는 코드를 통한 예제를 많이 가져왔다. 단순히 말로만 듣고 이해하기에는 어려운 부분들이 있어서 코드를 통해 어떤 부분에 문제가 있어서 사용해서는 안되는지 확인할 수 있었던 것 같다.  
null을 인수로 넣거나 반환하는 함수를 많이 사용했었고 관련된 문제들을 많이 겪어서 책의 조언에 따라 사용하지 않아야함을 상기하게 된 것 같다.  
<br>

# 경계

해당 챕터에서는 외부 코드를 어떻게 클린하게 적용할 수 있을지에 대해서 이야기한다.  
<br>

### 외부 코드 사용하기

인터페이스 제공자들은 더 많은 고객층을 확보하기 위해 적용성을 최대한으로 넓히려고 한다. 반면, 사용자들은 자신의 요구에 더 집중된 인터페이스를 요구한다. 이러한 간격 사이에서 문제점들이 발생하고는 한다.  
<br>

그 예시로, java.util.Map이 있다. Map은 광범위한 기능을 제공한다. clear() 함수로 누구나 객체의 정보를 삭제할 수 있으며 저장을 위한 객체 유형을 제한하지 않는다. 이에 따라 `Map sensors = new HashMap();`과 같이 정의하는 경우, `Sensor s = (Sensor)sensors.get(sensorId);`와 같이 Map이 반환하는 Object를 올바른 유형으로 바꿔주는 과정이 추가되어야하며 그 책임은 Map의 사용자에게 있다.  
<br>

`Map<String, Sensor> sensors = new HashMap<Sensor>();`와 같이 정의한다면, `Sensor s = sensors.get(sensorId);`처럼 사용할 수 있기는 하지만, "필요하지 않은 기능까지 제공한다"는 문제가 해결되지는 않는다.  
<br>

또한, 인터페이스도 변할 가능성이 있는 존재이기에 사용을 금지하는 시스템도 존재했다. 만약 인터페이스가 바뀐다면 바꿔야할 코드의 범위가 매우 광범위해질 것이다.  
<br>

```java
public class Sensors {
    private Map sensors = new HashMap();
    
    public Sensor getById(String id) {
        return (Sensor)sensors.get(id);
    }
}
```  
<br>

위 코드처럼 Map의 사용을 특정 클래스를 통해서 제공함으로써 범위를 제안하는 방법도 있다. 반드시 캡슐화를 하라는 의미는 아니며 경계를 넘어다니면서 사용하는 것은 오류를 유발할 수 있으므로 자제하라는 뜻이다.  
<br>

+ 경계 살피고 익히기

외부 코드를 프로젝트에 사용하기 위해서는 코드를 익히고 통합하는 작업을 거쳐야 한다. 하지만 이는 쉬운 작업이 아니며 학습 테스트를 통해서 진행하는 것이 합리적이다. 학습 테스트는 간단한 테스트 케이스를 통해서 실제로 작동하는 방식을 확인해보는 과정으로 `테스트+구글링+공식문서`를 통해서 API에 익숙해질 수 있도록 해보자.  
<br>

+ 학습 테스트는 공짜 이상이다

학습 테스트는 API 전체를 배우는 것에 비해서 필요한 지식만 확보하는 손쉬운 방법이다. 이해도를 높여주며 투자하는 노력보다 얻는 성과가 크다. API의 새로운 버전이 나오더라도 기존에 만들어둔 테스트를 통해서 다르게 작동하는지를 1차적으로 확인할 수 있다.  
이러한 테스트 케이스가 없다면, 오래된 버전을 계속 사용하려는 유혹에 빠질 수 있다.  
<br>

### 아직 존재하지 않는 코드를 사용하기

경계는 앞서 설명한 내용들도 있지만 알지 못하는 영역에 대한 경계도 존재한다. 지식의 경계를 넘어선 코드는 작성하기 힘들며 일반적으로 프로젝트에서는 지식이 많은 부분에서 지식의 경계 쪽으로 코드를 작성해나간다. 팀 단위로 이루어진 프로젝트라면 경계 바깥 쪽은 오픈소스와 같이 외부의 코드를 이용하거나 다른 팀에서 작성하고 있을 것이다.  
<br>

[Adapter 패턴](https://jusungpark.tistory.com/22)을 사용한다면 개발자가 바라는 인터페이스를 구현하기 이전에 정의할 수 있으며 Adapter를 통해서 구현 후 발생하는 차이점들을 해결할 수 있다. 또한 Fake 클래스를 사용하면서 테스트를 진행할 수도 있게 된다.  
<br>

+ 깨끗한 경계

경계에서는 변경과 같은 특별한 일들이 자주 일어난다. 경계에 위치하는 코드들은 깔끔히 분리되어야 하며 테스트 케이스를 통해 잘 관리되어야한다. 의존에 관한 문제도 외부 코드보다는 통제 가능한 팀의 코드에 존재하는게 좋다.  
<br>

## 결론

학습 테스트, Adapter 패턴에 대해서 알게 되었고 규모있는 프로젝트들에서 이러한 방식의 장점을 몸소 체험해보고 싶다.