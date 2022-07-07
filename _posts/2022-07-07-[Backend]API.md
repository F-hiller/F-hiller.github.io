---
title: "[Backend] 기초 개념 정리 - API"
date: 2022-07-07 22:38:55 +0900
categories: [Backend, basic concept]
tags: [api]
---

## API란

### 정의

- Application Programming Interface의 줄임말이다.

Application : API를 이야기할 때의 application은 고유한 기능을 가진 모든 소프트웨어를 의미한다.

Interface : 두 application 간의 서비스 계약(연결의 매개체)을 의미한다. 계약은 요청(request)와 응답(response)를 사용하며 application끼리 통신하는 방법에 대해 정의한다.

즉 여러 개의 소프트웨어끼리 요청과 응답을 통해 통신하는 것을 의미한다고 할 수 있다.

### API의 4가지 방식

1. SOAP(Simple Object Access Protocoal) API  
   단순 객체 접근 프로토콜(SOAP)을 사용하며 xml(다목적 마크업 언어 중 하나)을 사용하여 메시지를 교환한다.  
   과거에 자주 사용되었으며 유연성이 떨어진다.

2. RPC(Remote Procedure Call) API  
   xml을 사용하는 방식에서 JSON으로 넘어가는 과정에서 SOAP API의 대안으로 인식되었다고 한다.  
   API의 재사용성이 떨어진다는 단점이 있다.

3. Websocket API  
   JSON객체를 사용하여 데이터를 전달한다. 클라이언트와 서버 간의 양방향 통신을 지원한다.  
   서버가 클라이언트에 콜백 메시지를 전송할 수 있다는 점에서 REST API 보다 효율적이라고 한다.

4. REST(REpresentational State Transfer) API  
   오늘날 가장 많이 사용되는 API라고 할 수 있다.  
   클라이언트가 서버에 요청을 보내고 서버가 요청을 받아 함수를 통해 얻은 결과를 클라이언트에 응답으로 보내준다.

## REST API

### HTTP API

HTTP는 HyperText Transfer Protocol의 줄임말로 다양한 파일을 전송하기 위한 방법이다.

대부분의 API가 HTTP API이며 HTTP 통신 규칙을 이용하는 API를 지칭한다.

IoT처럼 저사양, 저전력 환경에서 작동해야하는 장치는 HTTP 통신이 아닌 다른 프로토콜을 사용하기도 한다.

### REST를 위한 6가지 제한 조건

1. Client-Server architecture  
    Client-Server 디자인 패턴을 통해서 관심사 분리(Separation of Concerns 줄여서 SoC) 디자인 원칙을 준수하며 진행할 수 있다.  
   Client는 서비스 요청자, Server는 서비스 자원의 제공자이며 역할에 따라 작업을 분리해줄 수 있다.

2. Statelessness  
    서버는 클라이언트의 요청에 대한 정보를 저장하지 않는다. 따라서 클라이언트에서 보내는 모든 요청은 서로 독립적이다. 추가적인 저장을 진행하지 않는다는 점에서 서버의 부하를 줄일 수 있고 서버 디자인을 단순하게 만들어준다.  
   하지만 저장하는 정보가 줄어든만큼 모든 요청에 추가적인 정보가 들어가게 된다.

3. Cacheability  
    Statelessness가 서버에서의 추가 정보 저장에 관한 내용이었다면 Cacheability는 클라이언트의 정보 저장에 관한 내용이다. Cache는 서버의 지연을 줄이기위해서 여러가지 파일들을 클라이언트 측에서 임시로 저장해두는 방식이다.  
   이를 통해 서버와의 추가적인 통신을 제거할 수 있으며 확장성과 성능을 향상시킬 수 있다.

4. Layered system  
   서버와 클라이언트 2개의 사이에 여러개의 중간 서버를 넣음으로써 서버에 가해지는 부하를 분산시킬 수 있으며 공유 캐시를 제공하여 확장성을 향상시킬 수 있다. 보안 로직을 비지니스 로직과 분리하여 다른 layer로 만들 수 있다.

5. Code on demand(optional)  
   Java applet이나 JavaScript를 통해서 서버에서 클라이언트의 기능을 확장시킬 수 있다.

6. Uniform Interface  
   통일된 형식의 인터페이스는 단순화 및 분리를 통한 독립적인 활용이 가능하다는 점에서 RESTful한 환경에 필수적이다.

여기서 Uniform Interface에 대한 4가지 제약 조건이 있는데 이는 HTTP API와의 차이점이라고도 할 수 있다. REST API에는 있으며 HTTP API에는 없다.

1. Request를 통한 자원 식별  
   Request에 있는 내용을 통해서 Resource를 파악할 수 있어야한다.

2. Request를 통한 자원 변경  
   특정 Request를 통해서 Resource를 변경, 삭제할 수 있어야한다.

3. 자기서술적 Request  
   Request는 스스로의 처리 방식에 대한 충분한 정보를 가지고 있어야한다.

4. Hypermedia As The Engine Of Application State(HATEOAS)  
   클라이언트가 원하는 어떤 Resource와 연관된 내용들을 Response에서 확인할 수 있어야한다. 즉 현재 사용 가능한 다른 리소스에 대한 하이퍼링크나 Hypermedia 정보가 Response에 있어야한다.

### 장점

1. 통합  
   정해진 형식으로 통신하기에 새로운 application과 기존 시스템의 통합이 유리하다.

2. 혁신  
   다양한 사회적, 기술적 혁신을 코드에 적용하여 배포하는데 큰 변화를 줄 필요가 없다.

3. 확장  
   고객의 요구 사항에 따라 프로그램의 전체 구조를 바꾸는 것이 아니라 API를 추가하는 선에서 다양한 확장이 일어날 수 있다.

4. 유지 관리  
   두 시스템 간을 이어주는 장치이므로 쉽게 바꿀 수 없다. 따라서 어느 한쪽의 변화가 다른 시스템에 영향을 주지 않도록 해준다.

## Reference

[API란 무엇인가요? - API 초보자를 위한 가이드 - AWS](https://aws.amazon.com/ko/what-is/api/)

[REST - 위키백과, 우리 모두의 백과사전](https://ko.wikipedia.org/wiki/REST)

[API - 위키백과, 우리 모두의 백과사전](https://ko.wikipedia.org/wiki/API)
