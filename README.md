# DoubleFresh: Flutter

DoubleFresh Web Application: Client (Flutter)



## 소개

### 1. 로그인 화면

##### ID(휴대전화 뒷자리)와 비밀번호(초기 설정: ID와 같음)를 입력하여 로그인 합니다.

##### 비밀번호는 아이콘을 통해 보여지거나 숨길 수 있습니다.

<img src="C:\Users\HAVVING\Pictures\double_fresh\login.png" height="560"></img>



### 2. 메인 화면

##### 현재 월(月)에 해당하는 샐러드 목록을 캘린더 형식으로 보여줍니다.

##### 각 날짜를 클릭하여 예약할 수 있으며, 현재 날짜를 기준으로 이전 날짜에는 예약할 수 없습니다.

##### [예약하기] 버튼을 눌러 예약 시간까지 설정하면 예약이 완료됩니다.

| <img src="C:\Users\HAVVING\Pictures\double_fresh\main.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\reserve.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\reserve_time.png" height="560"></img> |
| :----------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |



### 3. 메뉴 화면

##### [내 정보] 탭에는 다음과 같은 메뉴들을 이용할 수 있습니다.

- 픽업 현황 보기
  - 사용자의 구독 정보 및 픽업 현황을 확인할 수 있습니다. [수정] 아이콘을 눌러 예약 시간을 수정하거나, [취소] 아이콘을 눌러 예약을 취소할 수 있습니다.
- 비밀번호 변경하기
  - 사용자의 비밀번호를 새 비밀번호로 변경할 수 있습니다.

| <img src="C:\Users\HAVVING\Pictures\double_fresh\menu3.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\my_pickup.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\password.png" height="560"></img> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |



##### [설정] 탭에는 다음과 같은 메뉴들을 이용할 수 있습니다.

- 픽업 날짜 고정하기
  - 사용자의 샐러드 픽업 날짜를 고정할 수 있습니다.
- 픽업 시간 고정하기
  - 사용자의 샐러드 픽업 시간을 고정할 수 있습니다.
- 요청사항 수정하기
  - 사용자의 기존 요청사항을 수정할 수 있습니다.

| <img src="C:\Users\HAVVING\Pictures\double_fresh\menu4.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\pickup_day.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\request.png" height="560"></img> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

그 밖에도, [전화] 탭을 눌러 가게에 바로 전화를 걸 수 있으며 [카카오톡] 탭을 눌러 카카오톡 메신저로 이동할 수 있습니다. 또한, [인스타그램] 탭을 눌러 가게의 SNS 링크로 접속할 수 있습니다.



### 4. 관리자 화면

##### 관리자는 [픽업 현황] 탭에서 날짜별로 예약 현황을 확인할 수 있습니다.

<img src="C:\Users\HAVVING\Pictures\double_fresh\admin_pickup.png" height="560"></img>



##### [구독자 관리] 탭에서 구독자들의 목록을 확인하고 관리합니다.

- 상세정보
  - 구독 횟수, 총 구독 횟수, 총 픽업 횟수, 남은 픽업 횟수, 요청사항 등을 확인할 수 있습니다.
- 구독자 추가
  - 새 구독자를 추가합니다.
- 구독자 삭제
  - 체크박스를 선택하여 구독자를 삭제합니다.

| <img src="C:\Users\HAVVING\Pictures\double_fresh\admin_user.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\admin_user_detail.png" height="560"></img> | <img src="C:\Users\HAVVING\Pictures\double_fresh\admin_user_add.png" height="560"></img> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |





## Reference

### cell_calendar

Link: [cell_calendar][link_cell]

[link_cell]: https://pub.dev/packages/cell_calendar



### calendar_strip

Link: [calendar_strip][link_strip]

[link_strip]: https://pub.dev/packages/calendar_strip