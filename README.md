# Clamate
## 'Clamate 클라메이트' - 오늘의 기온과 미세먼지를 알려주는 ToDo App
https://apps.apple.com/kr/app/clamate-%ED%81%B4%EB%9D%BC%EB%A9%94%EC%9D%B4%ED%8A%B8/id6446807047
<br>


### 계기 및 배경
---
알레르기성 비염이 있어 외출하기 전, 온도와 미세먼지를 항상 검색하는 편 입니다.
앱스토어에 ToDo 앱은 많이 존재하지만, ***현재 온도와 미세먼지를 함께 보여주는 ToDo 앱이 없어 날씨 앱을 따로 사용해야하는 불편함***이 다소 있었습니다.
개인적으로 불편함을 해소하기 위해 온도와 미세먼지 정보를 알려주는 ToDo 앱을 만들어보았습니다.
***Swift를 공부한 후, 처음으로 만든 개인 프로젝트***입니다.
<br>

  
  
### 개발 환경
---
#### StoryBoard vs Code
* UI를 포함하여, 100% 코드로 개발하였습니다.
#### 디자인패턴
* MVC 패턴으로 만들었습니다.
#### user 데이터 저장 방식
* Core Data를 사용하였습니다.
#### 네트워킹
* OpenWeatherMap의 API로 현재 기온을, AQICN에서 현재 미세먼지 현황 데이터를 각각 JSON 형태로 받았습니다.
<br>


  
### 개발 기간
---
2023.03.08 ~ 2023.03.26 (약 18일 소요)  
<br>



### 구현 기능
---
#### Main 
1. 오전, 오후, 밤, 새벽마다 다른 응원 메세지를 띄웠습니다.
2. user가 선택한 지역의 기온과 미세먼지를 알려줍니다.
#### Today 
1. user의 오늘 ToDo list 를 오름차순으로 정렬하여 표시합니다.
2. 다 끝낸 ToDo list는 Done list로 옮겨집니다.
3. Done list에 있는 ToDo list를 다시 undo 할 수 있습니다.
4. 원하는 List를 삭제하고 편집 할 수 있습니다.
#### Monthly
1. 한달 단위의 달력을 띄웁니다.
2. ToDo list가 있는 날짜를 한번에 확인할 수 있습니다.
3. 오늘 날짜를 한번에 확인 할 수 있습니다.
4. 원하는 날짜를 선택하여 ToDo list를 확인하고, 추가 및 수정 할 수 있습니다.
#### 다크모드
1. 라이트모드 뿐만 아니라, 다크모드를 지원합니다.  
<br>


 
### 배운 점
---
1. CoreData를 CRUD하는 법을 배웠습니다.
2. REST API를 통해 JSON 형식의 데이터를 받아 원하는 모델로 Decoding하여 처리하는 것을 배웠습니다.
3. @escaping 키워드의 존재 이유와 GCD의 역할을 보다 더 이해할 수 있게 되었습니다.
3. View의 life cycle에 대해 배웠습니다.
4. didSet 속성감시자를 활용하여 view를 그리는 법을 배웠습니다.
5. TableView에 swipe action을 추가하는 법을 배웠습니다.
6. 외부 변수를 캡처하는 클로저의 캡처리스트에 weak 키워드를 사용하여 RC를 관리하는 법을 배웠습니다.
7. WWDC22에 출시된 UICalendarView를 사용하는 법을 배웠습니다.
7. 다크모드를 구현하는 법을 배웠습니다.  
<br>



### 심사 과정
---
Reject없이 통과 되었습니다. (하단 이미지 참고)
<img width="1064" alt="image" src="https://user-images.githubusercontent.com/126672733/227861133-5deee717-aa3e-48b1-9154-e688892991aa.png">
<br>  



### 업데이트 과정
---
ver. 1.01 - 23.03.27 제출
1. Start View의 alert title 오타를 수정했습니다.
2. Monthly View의 UICalendarView에 오늘 날짜를 한눈에 볼 수 있도록 decordation을 추가했습니다.
