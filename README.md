# Clamate
## 'Clamate 클라메이트' - 오늘의 기온과 미세먼지를 알려주는 ToDo App
앱스토어 : https://apps.apple.com/kr/app/clamate-%ED%81%B4%EB%9D%BC%EB%A9%94%EC%9D%B4%ED%8A%B8/id6446807047
<br>
<br>


### 계기 및 배경
---
알레르기성 비염이 있어 외출하기 전, 온도와 미세먼지를 항상 검색하는 편 입니다. <br>
앱스토어에 ToDo 앱은 많이 존재하지만, ***현재 온도와 미세먼지를 함께 보여주는 ToDo 앱이 없어 날씨 앱을 따로 사용해야하는 불편함***이 다소 있었습니다. <br>
불편함을 해소하기 위해 온도와 미세먼지 정보를 알려주는 ToDo 앱을 만들어보았습니다. <br>
***Swift를 공부한 후, 처음으로 만든 개인 프로젝트***입니다.
<br>
<br>
![Simulator Screen Recording - iPhone 14 - 2023-03-28 at 18 36 06](https://user-images.githubusercontent.com/126672733/228194873-5b8871d9-be13-4267-b2fa-8db57c93c9bd.gif)
![Simulator Screen Recording - iPhone 14 - 2023-03-28 at 18 44 54](https://user-images.githubusercontent.com/126672733/228197269-8572f8d4-1b98-4f39-b64b-a00ddd1de671.gif)
![Simulator Screen Recording - iPhone 14 - 2023-03-28 at 18 46 50](https://user-images.githubusercontent.com/126672733/228197884-b3fb1ea4-33d5-460d-b18f-8074ff232991.gif)

<br>
<br>

### 개발 환경
---
#### StoryBoard vs Code
* UI를 포함하여, 100% 코드로 개발 (UIKit)
#### 디자인패턴
* MVC 패턴
#### user 데이터 저장 방식
* Core Data 사용
#### 네트워킹
* 현재 기온 : OpenWeatherMap - JSON 형태 <br>
* 미세먼지 : AQICN - JSON 형태
<br>
<br>
<br>
 
### 개발 기간
---
2023.03.08 ~ 2023.03.26 (약 18일 소요)  
<br>
<br>
<br>

### 문제 및 해결 과정
---
#### 1. TableView - 셀의 하위 view가 즉시 나타나지 않는 문제<br>
문제 상황 <br>
<img width="677" alt="image" src="https://user-images.githubusercontent.com/126672733/228141408-0e1791f4-eff3-4858-a5cf-774749dce8e4.png">

파악 과정 : 
1. contentView의 색이 표시되는 것을 보고, tableView위에 셀을 띄우는 것이 아닌, 셀 subView의 오토레이아웃을 잡는 시점이 잘못되었다는 것을 인지했습니다. 
2. View의 drawing cycle에 대한 문서를 찾아보았습니다. <br> 그 결과, 셀의 크기를 고정적으로 유지할 것임에도 불구하고, update cycle이 실행되는 시점에 셀 subView의 오토레이아웃을 잡은 것이 문제인 것을 깨닫게 되었습니다. 
3. update cycle 안에 호출되는 함수로 오토레이아웃을 잡게 되면 해당 사이클이 메인 런루프의 마지막 단계에 호출되므로, subView의 오토레이아웃이 즉시 잡히지 않음을 알게 되었습니다.<br>
+ 덕분에 애니메이션 효과처럼 기존의 view에 ***변화를 즉각적***으로 주고 싶을 때 updateConstraintsIfNeeded(), layoutIfNeeded()와 같은 메서드를 실행하면 ***update cycle과 관계없이 즉각적으로 layoutSubviews()와 같은 함수들이 실행되기 때문에 view의 변화가 바로 반영***이 되는 점까지 배울 수 있었습니다. <br>

해결 방법 : 
* 셀의 생성자 함수 안에 오토레이아웃 잡는 함수를 넣어, 셀이 생성되는 시점에 셀 안의 sub view들의 오토레이아웃이 잡히도록 코드를 수정하여 문제를 해결할 수 있었습니다.<br> + 번외) 이 과정 덕에 mainView의 현재 기온과 미세먼지를 알려주는 view의 애니메이션 효과를 줄 때 layoutIfNeeded()를 적절하게 사용 할 수 있었습니다!
<img width="674" alt="image" src="https://user-images.githubusercontent.com/126672733/228148510-e5f22a40-ba94-4087-8589-af152ea60fb0.png">
[MainView의 애니메이션 효과 주는 코드]
<img width="874" alt="image" src="https://user-images.githubusercontent.com/126672733/228148266-700714f0-fe2d-46cf-b81f-a0153aa108c0.png">
<br>
<br>
<br>

#### 2. User 정보가 존재하지 않는 경우에만 StartView를 띄우는 방법
해결 방법 : 
1. User정보만 저장하는 CoreData entity를 따로 생성했습니다. 
2. StartView가 사라지지 않은 채로 다른 view를 띄우지 않기 위해, navigation바의 루트 뷰로 설정하여 present했습니다.
3. User정보가 있는 경우와 없는 경우를 if문으로 분기처리하는 함수를 만들었습니다.<br>
<img width="779" alt="image" src="https://user-images.githubusercontent.com/126672733/228158289-656386a7-9c90-4ead-a3f7-152e520963b8.png">
4. 해당 함수를 viewWillAppear()에 호출하여, StartView를 user가 옆으로 스와이프해도 계속해서 유저 정보를 요청할 수 있도록 만들었습니다.
<br>
<br>
<br>



#### 3. DateFormatter를 자주 사용해서 메서드가 자주 비대해짐
* 파악 과정 : 코드를 되돌아보는 도중, 날짜와 시간을 사용할 때마다 DateFormatter를 번번이 작성하는 것을 깨닫게 되어 코드 낭비라는 생각이 들었습니다.

* 해결 방법 : DateHelper라는 구조체 모델을 하나 생성하여 dateFormatter가 필요할 때마다 해당 모델을 변수에 담아 사용하여 코드 낭비를 줄였습니다.
<br>
<br>
<br>

#### 4. 미세먼지 API 교체하기
* 파악 과정 : OpenWeatherMap의 Air Pollution API를 통해 미세먼지 데이터를 받았지만, 우리나라 대기질관측소 결과와 조금씩 오차가 있는 것을 발견하게 되어 API 교체를 고려하게 되었습니다.
 1. OpenWeatherMap - Air Pollution API (기존에 사용) : <br>
 * 장점 : 날씨 데이터 중 해당 지역의 위도 경도 데이터도 받을 수 있음, 지원되는 우리나라 도시가 비교적 많음, 기존 로직 유지 가능.
 * 단점 : 좌표로만 요청이 가능하기 때문에 위도 경도 데이터가 추가로 필요함, AQI calculation에 NH3과 NO는 반영 안되어 정확도가 떨어짐, 제한적인 무료 데이터 서비스 요청량

 2. AQICN
* 장점 : 우리나라 관측소에 측정된 결과를 제공하기 때문에 데이터의 정확도가 높음, 비상업적 용도로는 제한 없이 무료 사용 가능
* 단점 : 지원되는 우리나라 도시가 기존에 비해 비교적 적음, 분기처리 하는 코드가 미세하게 더 길다. 다시 모델을 작성하고 로직을 구현해야 함. <br>
#### 결론: 지원하는 지역이 적어지더라도 더 정확도 높은 데이터를 user에게 제공하는 것이 훨씬 중요하다 생각이 들었기에, API를 교체했습니다. 
<br>
<br>
<br>

### 구현 기능
---
#### 알림
- 유저가 설정한 일정의 날짜 및 시간에 알림을 보냅니다.
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
4. 원하는 날짜를 선택하여 ToDo list를 확인하고, 추가 및 수정 할 수 있습니다.<br>
#### 다크모드
1. 다크모드를 지원합니다. 
<br>
<br>
<br>

### 배운 점
---
1. CoreData를 CRUD하는 법을 배웠습니다.
2. REST API를 통해 JSON 형식의 데이터를 받아 원하는 모델로 Decoding하여 처리하는 것에 익숙해질 수 있었습니다.
3. @escaping 키워드의 존재 이유와 GCD의 역할을 보다 더 이해할 수 있었습니다.
3. View의 life cycle에 대해 경험하며 배울 수 있었습니다.
4. didSet 속성감시자를 활용하여 데이터를 주고받으며 view를 그릴 수 .
5. TableView에 swipe action을 추가하는 법을 배웠습니다.
6. 외부 변수를 캡처하는 클로저의 캡처리스트에 weak 키워드를 사용하여 RC를 관리하는 법을 배웠습니다.
7. WWDC22에 출시된 UICalendarView를 사용하는 법을 배울 수 있었습니다.
7. 다크모드를 구현하는 법을 학습했습니다.  
<br>
<br>
<br>

### 심사 과정
---
<img width="1064" alt="image" src="https://user-images.githubusercontent.com/126672733/227861133-5deee717-aa3e-48b1-9154-e688892991aa.png">
<br>  
<br>
<br>

### 업데이트 과정
---
ver. 1.01 (23.03.27)
1. Start View의 alert title 오타를 수정했습니다.
2. Monthly View의 UICalendarView에 오늘 날짜를 한눈에 볼 수 있도록 decordation을 추가했습니다.
<br>
<br>

ver. 1.2 (23.06.07)
1. Push Notification, Background Module 을 사용한 로컬 푸시 알림 구현 
2. AddVC, DetailVC의 timeFormatter의 분 단위를 수정했습니다. (1분 단위 -> 5분 단위)
<br>
<br>

ver 1.3 (23.11.22)
1. 유저 닉네임 및 날씨 미세먼지 정보 받을 지역 수정 기능 추가
2. 하단 탭바의 아이콘 변경
3. launchScreen 제거 (HIG)
