---
title: "[Book Clean Code - 5주차 (9, 10장)"
date: 2023-10-09 00:30:36 +0900
categories: [Backend, Books, Clean Code]
tags: [clean code, book]
#use_math: true
---

# 단위 테스트

### 🧹TDD 법칙 3가지

1. 실패하는 단위 테스트를 작성할 때까지 실제 코드를 작성하지 않는다.
2. 컴파일은 실패하지 않으면서 실행이 실패하는 정도로만 단위 테스트를 작성한다.
3. 현재 실패하는 테스트를 통과할 정도로만 실제 코드를 작성한다.  
<br>

### 🧹깨끗한 테스트 코드 유지하기

테스트 코드는 추가되는 경우는 있어도 없어지는 경우는 잘 없다. 그렇기에 유지보수 비용에 포함되며 깨끗하지 않은 테스트 코드는 팀의 부담을 증가시키며 테스트 코드를 폐기하게 만드는 스노우볼이 된다.  
<br>

유연성, 유지보수성, 재사용성이 있는 테스트 코드는 코드의 변경이 쉽게 이루어지도록 도우며 시스템의 안정성을 책임진다.  
<br>

### 🧹깨끗한 테스트 코드

그렇다면 깨끗한 테스트 코드는 무엇일까?  
저자는 가독성이라고 이야기한다.  
테스트는 실제 코드보다도 더욱 가독성이 중시되어야한다고 이야기한다. 하지만, 실제 코드만큼 효율적일 필요는 없다.  
<br>

### 🧹테스트 당 assert 하나

JUnit으로 작성한 테스트 코드는 함수마다 assert 문을 하나만 사용하라고 주장하는 사람들도 있다.  
가혹하다고 여길지 몰라도 장점이 있다고 한다.  
assert 문이 하나인 함수는 제시하는 결론도 하나이므로 코드를 이해하기 쉽고 빠르다. 이는, 앞서 이야기한 가독성의 측면에서 훌륭하다고 할 수 있다.  
given-when-then 관례를 지키는 것도 이러한 측면이라고 볼 수 있다.  
<br>

assert 문을 하나만 쓰는 것은 분명 훌륭하다. 때에 따라서 1개만 사용하는 것이 힘들기도 하지만 assert 문의 개수는 최대한 줄이는 것이 좋은 방향이라고 한다.  
<br>

### 🧹테스트 당 개념 하나

이것 저것 연속적으로 테스트하는 긴 함수는 작성하지 말라는 의미이다.  
직관적으로 확인할 수 있는 규칙에 따라 함수들을 나누어서 작성하다보면 미쳐 발견하지 못한 테스트들을 추가할 수 있을 것이다.  
<br>

### 🧹FIRST 규칙

깨끗한 테스트를 만족하는 5가지 조건이다.  
<br>

Fast : 테스트는 빨라야한다. 테스트는 여러번 돌리기 마련이다. 느리면 테스트를 진행하기 힘들어진다.  
<br>

Independent : 각 테스트는 의존성이 없어야한다. 한 테스트가 다음 테스트를 위한 발판이 되어서는 안된다.  
<br>

Repeatable : 테스트는 어떤 상황에서도 반복 가능해야한다.  
<br>

Self-Validating : 테스트는 boolean 값으로 결론나야한다. 성공 혹은 실패의 결과만이 존재해야한다. 테스트 로그나 파일들을 개발자가 직접 확인해야하는 일은 없어야 할 것이다.  
<br>

Timely : 테스트는 적절한 시기에 작성되어야한다. 단위 테스트는 테스트하려는 실제 코드를 구현하기 직전에 구현한다.  
<br>

## 결론

테스트는 시스템을 유지해주는 중요한 수단이며, 소홀히 관리해서는 안된다. 또한 단일 assert, FIRST 규칙과 같은 내용들을 준수하면서 테스트 코드를 작성할 수 있도록 노력해보자.  
<br>

# 클래스

지금까지의 챕터는 대부분 함수 단계에서의 깨끗함에 대해 이야기해왔다. 하지만 코드란 것은 함수만으로 이루어진 것이 아니며 더 높은 차원, 클래스의 깨끗함에도 신경을 써야한다. 이번에는 클래스에 대해서 이야기해보도록 하자.

### 🧹클래스 체계

클래스를 정의하는 표준 자바 관례에 따르면 처음에는 변수 목록이 나온다. static public 상수가 가장 먼저, 그 뒤를 이어서 static private 변수, private 인스턴스 변수가 나온다. 클래스 상에서 public 변수를 사용하는 경우는 거의 없다고 볼 수 있다. 그 이후에는 public 함수가 나온다. private 함수는 자신을 호출하는 public 함수 직후에 나온다. 이렇듯, 추상화 단계가 순차적으로 내려가는 방식으로 클래스를 전개한다고 볼 수 있다.  
<br>

+ 캡슐화

변수와 유틸리티 함수는 공개하지 않는 편이 좋지만 테스트 환경에서의 사용과 같이 필요한 경우에는 protected로 선언에 접근을 허용하기도 한다.  
그렇지만 되도록이면 캡슐화를 벗어나지 않도록 시도해보자. 캡슐화 해제는 최후의 수단이다.  
<br>

### 🧹클래스는 작아야 한다

함수 단계에서 이야기한 맥락과 유사하면서도 차이점이 존재한다. 클래스의 설계 방향이 작아야 한다는 점이 유사하다. 하지만 함수의 경우 물리적인 행의 길이가 작아야한다는 방향성을 지니고 있었지만 클래스의 경우에는 해당 클래스가 가지고 있는 책임이 작아야한다는 것이다.    
<br>

클래스의 이름은 클래스의 책임을 기술하고 있으며 작명을 잘하는 것이 클래스의 책임을 명확히하는 길이다. 이름에 Processor, Manager, Super와 같이 모호하거나 범위가 방대한 내용이 포함되었다면 클래스가 여러 책임을 가지고 있지는 않은가 생각해보자.  
또한 클래스의 설명이 만약(if), 그리고(and), ~하며(or), 하지만(but)을 사용하지 않고 25단어 내외로 가능해야한다고 한다. 너무 구체적인 지시이긴 하지만, 결국 말이 길어질 정도로 책임과 조건이 많아서는 안된다는 의미일 것이다. 다음의 코드를 예시로 들 수 있다.  
<br>

```java
public class SuperDashBoard extends JFrame implements MetaDataUser {
    public Component getLastFocusedComponent();
    public void setLastFocused(Component lastFocused);
    public int getMajorVersionNumber();
    public int getMinorversionNumber();
    public int getBuildNumber(); 
}
```  
<br>

위 클래스를 설명하려면 어떻게 해야할까? "SuperDashBoard 클래스는 마지막으로 포커스를 얻었던 컴포넌트에 접근하는 방법을 제공하며, 버전과 빌드 번호를 추적하는 메커니즘을 제공한다."와 같이 설명할 수 있다고 한다. "~하며"가 사용되었으므로 책임이 많은 클래스라고 볼 수 있다.  
<br>

+ 단일 책임 원칙

SOLID 원칙의 1번째 원칙인 Single Responsibility Principle은 클래스나 모듈을 변경할 이유가 단 하나여야한다는 원칙이다. 이는 클래스가 하나의 책임을 가져야한다는 뜻이기도 하다.  
<br>

+ 응집도 Cohesion

클래스 안의 함수와 변수가 서로 의존하며 논리적인 단위로 묶이는 것이 좋으며 이를 응집도가 높다고 이야기한다. '함수를 작게, 매개변수 목록을 짧게' 전략을 따라가다 보면 몇몇 함수들만이 사용하는 인스턴스 변수가 많아지는데, 이 때가 응집도가 떨어지는 시기이며 클래스를 분리시켜야하는 지점이다.  
<br>

해당 파트에는 함수와 클래스를 쪼개면서 리팩토링하는 예제가 있는데 글로 모두 담기는 힘들어서 한 번씩 읽어보기를 바란다.

### 🧹변경하기 쉬운 클래스

예시로 설명을 해보자. 다음의 Sql 클래스는 변경이 필요해 리팩토링이 필요한 코드이다.  
<br>

```java
public class Sql {
    public Sql(String table, Column[] columns);
    public String Select();
    public String insert(Object[] fields);
    public String selectAll();
    public String findByKey(String keyColumn, String keyValue);
    public String select(Column column, String pattern);
    public String select(Criteria criteria);
    // 이하 생략
}
```  
<br>

만약 새로운 SQL 문을 지원하고자 코드를 반영한다면 반드시 Sql 클래스를 수정해야만 한다. 기존 SQL 문을 수정하려고해도 Sql 클래스를 수정해야한다. 이처럼 변경할 이유가 두 가지 이상이 될 수 있으므로 Sql 클래스는 SRP를 위반한다고 볼 수 있다. 그렇다면 아래와 같은 코드로 클래스와 함수를 분리한다면 어떻게 될까?  
<br>

```java
abstract public class Sql {
    public Sql(String table, Column[] columns);
    abstract public String generate();
}

public class CreateSql extends Sql {
    public CreateSql(String table, Columns[] columns);
    @Overide public String generate();
}

public class SelectSql extends Sql {
    public SelectSql(String table, Columns[] columns);
    @Overide public String generate();
}

public class InsertSql extends Sql {
    public InsertSql(String table, Columns[] columns, Object[] fields);
    @Overide public String generate();
    private String valuesList(Object[] fields, final Columns[] columns);
}
// 이하 생략
```  
<br>

이렇게 작성된 경우, 클래스들이 극도로 단순해지게 되며 코드를 이해하기 쉬워진다. 함수 하나를 수정해도 다른 클래스나 함수를 건드리는 경우도 없어서 위험성이 사라졌다. 또한, 새로운 SQL 문을 추가한다고 하더라도 Sql 클래스를 상속받는 새로운 UpdateSql 클래스를 생성하면 된다. 이러한 설계는 OCP 원칙도 준수하는데, 새로운 기능을 추가하더라도 기존의 클래스들은 변경할 필요가 없이 닫혀있다.  
<br>

+ 변경으로부터 격리

요구사항은 변하고 코드도 변한다. interface와 abstract class를 활용함으로써 구현이 미치는 영향을 서로 격리할 수 있다.  
외부 API를 사용해서 진행하는 Portfolio 클래스가 있다고 하자. 해당 클래스에 외부 API를 바로 사용하는 것은 여러 원칙들에 어긋나며 변경으로부터 자유롭지 않다.  
외부 API를 사용하는 새로운 인터페이스와 클래스를 생성한 후, 해당 클래스를 Portfolio 클래스로 가져와서 사용하는 것이 테스트에도 유용하며 시스템의 결합도를 낮춘 유연성과 재사용성이 높은 코드라고 할 수 있다.  
<br>

## 결론

이번 챕터들에서는 다양한 전략과 원칙, 규칙들이 언급되었다. 그만큼 기존에 제시된 가이드라인을 따르는 것이 중요함을 강조하는 챕터라고 생각이 되었고, SOLID 원칙과 GOF 패턴들을 다시 한 번 공부해보는 시간을 가져야겠다.