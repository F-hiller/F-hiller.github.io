---
title: "[Book] Clean Code - 3주차 (5장, 6장)"
date: 2023-09-17 23:30:15 +0900
categories: [Backend, Books, Clean Code]
tags: [clean code, book]
#use_math: true
---
# 형식 맞추기

이번 챕터는 내용들의 이해가 어렵지 않은 편이라 목록으로 쭉 나열하는 방식으로 진행해보려고 한다.  
<br>

1. 개념은 빈 행으로 분리하라  
   import, 함수처럼 의미가 분리되는 구간에는 빈 행을 넣어주는 것이 좋다.  
<br>

2. 세로 밀집도 & 수직 거리  
   비슷한 개념끼리는 코드 상의 거리가 가까워야하며 개념 사이의 주석이나 빈 행은 최소화되는 것이 좋다.  
<br>

3. 가로 형식  
   적당히 짧은, 한 줄에 많아도 120자 정도의 길이가 되었으면 좋겠다.   
<br>

4. 들여쓰기  
   대부분의 도구에서 지원하는 들여쓰기를 적극 활용해라.  
<br>

5. 가짜 범위  
   빈 while문이나 for문은 오해를 유발할 수 있으며 사용을 자제하는 것을 추천한다. 다만, 사용했을 경우 세미콜론을 새로운 행에 작성하는 방식을 추천한다.
   ```java
   while (dis.read(buf, 0, readBufferSize)) != -1)
   ;
   ```  
<br>

6. 팀 규칙을 우선해라  
   합의된 규칙을 무시하는 것만큼 잘못된 행동은 없다. 팀에 속한다면 팀의 규칙을 따라라.  
<br>

7. 코드 자체가 최고의 표준 문서가 되도록 해라.  
<br>

### 🧹프로젝트 소개

해당 챕터에서 7개의 프로젝트에서 파일 길이에 대해서 소개해주는 부분이 있다. 모르는 프로젝트들이 몇몇 존재해서 알아보고자 조사를 해보았다.

1. [FitNesse](http://docs.fitnesse.org/FrontPage)  
   간단히 설명하자면 오픈소스 인수 테스트 자동화 도구이다. Fit(Framework for integrated test)라는 테스팅 프레임워크를 사용하며 이해관계자(고객, 개발자)들의 협업을 돕는 것을 목표로 한다.  
<br>

2. [testNG](https://testng.org/doc/)  
   JUnit과 유사한 자바 테스트 프레임워크이다.  
<br>

3. Time and Money (tam)  
   검색해보았으나 해당 이름에 맞는 프로젝트를 찾지 못했다.  
<br>

4. [JDepend](https://github.com/clarkware/jdepend)  
   자바 패키지 의존성 분석 도구이다. 재사용 여부, 무한 반복 의존 관계와 같은 문제점들을 조사하고 분석해주는 도구이다.  
<br>

5. [Ant](https://ant.apache.org/)  
   풀네임은 Apache Ant로 Java 프로그램용 build 도구라고 한다. 유사한 프로젝트로는 Tomcat이 있다.  
<br>

## 결론

이번 챕터에서는 "(적어도 나로서는)"과 같은 표현을 사용하며 개발자마다 느끼는 바가 다를 수 있음을 알려주는 경우가 있었으며 저자의 의견이 강하게 드러나지 않았다. 또한 "세로로 짧게 써라", "가로로 짧게 써라", "팀의 규칙을 우선해라"처럼 일반적인 상황에서 크게 벗어나는 내용들이 별로 많지 않았다.  

intellij와 같은 도구에서 지원하는 형식 맞추기로도 충분히 형식 맞추기를 준수할 수 있다고 생각하며 팀 규칙을 따르는 것만으로도 이번 챕터는 충분히 커버할 수 있다고 생각한다.  
<br>

# 객체와 자료 구조

### 🧹자료 추상화

변수를 공개하지 않는 것은 변수에 의존하지 않게 만들기 위해서이다. 내부 작동, 변수들을 알지 않아도 추상적인 개념으로, 함수로 표현하는 것이 좋다.  

아무런 생각 없이 그저 클래스의 private 변수를 조회/설정하는 get/set 함수를 추가하는 것은 그리 좋은 방향이 아닐 것이다.  
<br>

### 🧹자료/객체 비대칭

일반적으로 객체는 자료를 숨기며 자료를 다루는 함수만을 공개하고, 자료구조는 자료를 그대로 공개하며 별다른 함수를 제공하지 않는 경향이 있다. 이러한 특징은 절차 지향과 객체 지향에서도 드러난다.  
<br>

  
절차적인 코드에서 각 도형에 대한 클래스가 있고, 해당 도형들을 사용한 계산을 진행해주는 Geometry 클래스가 있다고 하자.  
```java
public class Square {
   public Point topLeft;
   public double side;
}
public class Circle {
   public Pointer center;
   public double radius;
}
public class Geometry {
   public final double PI = 3.141592;

   public double area(Object shape) throws NoSuchShapeException {
      if (shape instanceof Square) {
         Square s = (Square)shape;
         return s.side * s.side;
      }
      else if (shape instanceof Circle) {
         Circle c = (Circle)shape;
         return PI * c.radius * c.radius;
      }
      throw new NoSuchShapeException();
   }
}
```
새로운 도형을 추가하는 경우, Geometry의 모든 함수에 해당 도형에 관한 내용을 추가해주어야 한다. 반면, 도형의 둘레 길이를 계산해주는 함수를 추가하고 싶을 때 도형 클래스나 다른 함수를 수정해야하는 일은 일어나지 않는다.  
<br>

객체 지향적인 도형 클래스의 경우를 살펴보자.
```java
public class Square implements Shape {
   private Point topLeft;
   private double side;

   public double area() {
      return side * side;
   }
}
public class Circle implements Shape {
   private Point center;
   private double radius;
   private final double PI = 3.141592;

   public double area() {
      return PI * radius * radius;
   }
}
```
새로운 도형을 추가하는 경우, 다른 도형을 수정해야하는 일은 일어나지 않는다. 반면, 도형의 둘레 길이를 계산해주는 함수를 추가하고 싶을 때 모든 도형 클래스에 함수를 추가해주어야 한다.  
<br>

이처럼 상호 보완적인 특징이 존재하며 객체와 자료 구조는 비대칭, 양분된다.
+ 장점  
절차적인 코드 : 기존 자료 구조를 변경하지 않으면서 새 함수를 추가하기 쉽다.
객체 지향 코드 : 기존 함수를 변경하지 않으면서 새 클래스를 추가하기 쉽다.
+ 단점  
절차적인 코드 : 새로운 자료 구조를 추가하기 어렵다.
객체 지향 코드 : 새로운 함수를 추가하기 어렵다.

이러한 특성들을 고려하여 적절하게 사용할 수 있어야 한다.  
<br>

### 🧹디미터 법칙

모듈(객체)은 자신이 조작하는 객체의 속사정을 몰라야 한다는 법칙으로 앞서 이야기한 내용들과 맥락이 비슷하다.
```java
final String outputDir = ctxt.getOptions().getScratchDir().getAbsolutePath();
```
다음과 같은 코드를 기차 충돌이라고 하며 일반적으로 조잡하다 여기진다고 한다. 다음과 같은 방식으로 개선하기를 권장한다.
```java
Options opts = ctxt.getOptions();
File scratchDir = opts.getScratchDir();
final String outputDir = scratchDir.getAbsolutePath();
```

자료 구조라면 디미터 법칙에 해당하지 않으며 다음과 같이 작성될 수 있을 것이다.
```java
final String outputDir = ctxt.options.scratchDir.absolutePath;
```  
<br>

+ 잡종 구조

이렇게 절차지향과 객체지향을 혼란하게 사용하다보면 객체와 자료 구조를 동시에 사용하고 있는 잡종 구조가 탄생하기도 한다. 되도록 피하도록 하자.  
<br>

### 🧹자료 전달 객체

일반적으로 DTO라고 부르는 자료 구조체이다.
비공개 변수를 바탕으로 get/set 함수를 통해서 조작한다.  
글쓴이는 "일종의 사이비 캡슐화"라고 표현하며 공개 변수만으로 작동하는 자료 구조체와 비교해서 큰 이점이 없다고 이야기한다.  
<br>

## 결론 

객체는 동작을 공개하고 자료를 숨겨야한다.  
자료 구조는 동작 없이 자료를 노출한다.  
상황에 맞게 더 좋은 방식을 사용할 수 있는 개발자가 되도록 하자.  
<br>

마지막 부분에 get/set을 이용한 DTO가 그리 큰 이점이 존재하지 않는다고 보는 부분이 있었는데 본인은 일반적으로 getter를 사용해서 DTO를 작성해서 궁금증이 생겼다. 코드가 "클린"하다면 객체와 자료구조가 구분되므로 get/set을 사용하지 않아도 된다는 의견인지 궁금하다.
