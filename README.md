#목차 (Github commit 확인)
> BottomNavigationBar, nested navigation, list 이용한 history back button, showDialog, GridView 사용자 객체, 

1. Image 객체
2. BottomNavigationBar 객체
3. Getx binding 새로운 방법
4. IndexedStack 객체
5. Navigator 를 만들지 않고 `List<int> = [0];`를 사용해서 navigation 을 하고 있네..
6. SingleChildScrollView 객체 - List & Row 사용 
7. CachedNetworkImage 객체
8. ClipRRect 객체 : 이름을 잘 생각해 봐라. 컨테이너 객체 가장자리 둥글게 만들어준다.
9. ExpandableText 객체
10. GestureDetector 객체
11. Container 객체 가로전체 채우기, Container width & height
12. Container Circle 모양으로 만들기
13. AppBar 객체 사이즈 알아내기
14. TabBar 객체 알아야 할 내용
15. 중첩 라우팅 - nested navigating
16. BottomNavigationBar 객체
17. enum 객체
18. PageView 객체도 사용해 보도록 하자. (애니메이션과 손으로 넘기기도 되는것 같다.)
19. SingleChildScrollView 객체 기억나지?
20. Wrap 객체 - 너무 많으면 다음줄로 넘긴다. Warning 피할 수 있슴
21. WillPopScope 객체
22. Material 객체 - 스타일을 입히기 위해서
23. Elevated Button 객체
24. showDialog 객체 (callback 함수 호출에 대한 착각)
25. CachedNetworkImage 객체
26. List 를 사용해서 children 에 배열을 계속 나열하고 싶을 때
27. Stack 객체 (Positioned 객체 사용법)
28. ExpandableText 객체 (... 으로 늘렸다 줄였다 하는 위젯)



# Image 객체
> 디바이스 pixel ratio 에 따라 값이 조절되도록 하고 싶을 때
```dart
  return Image.asset(_icon, width: _width! / Get.mediaQuery.devicePixelRatio,); // 디바이스 전체 크기 비율로 줄여주는구나.
```
> 이미지는 항상 SVG 파일로 만들는게 좋다는 걸 기억하자.

# BottomNavigationBar 객체
> 일단 static 을 포함한 객체를 이용해서 경로를 가진 IconPath 를 넘겨주면 좋고.
```dart
type : BottomNavigationBarType.fixed, // 아이콘이 뜨는걸 방지
showSelectedLabels : false, // label 을 보이지 않도록
showUnselectedLabels : false, // label 을 보이지 않도록
elevation : 0, 
```

# Getx binding 새로운 방법
> GetxMaterialApp() 쪽에 `initbinding = initBining()` 해주고 
```dart
class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanant: true); // permanant 로 인해서 계속 살아있게 된다.
    // 그말은 여기에 계속 추가해서 넣어줄 수 있다는 건가??? 한번보자.
  }
}
```

# IndexedStack
> 내가 배웠던 Stack 과 Offset 위젯을 합쳐 놓은거네.. ㅎㅎㅎ

# Navigator 를 만들지 않고 `List<int> = [0];`를 사용해서 navigation 을 하고 있네.. ❤❤❤❤❤


# SingleChildScrollView 객체
```dart
return SingleChildScrollView(
scrollDirection : Axis.horizontal, child: Row(
children: List.generate(100, (index) => Container(width: 60, height: 60,
   decoration: BoxDecoration(shape: BoxShape.circle, color: Color.grey))))
);
```
```dart
  Widget _myBodyStoryBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            // [question] The element type 'List<Container>' can't be assigned to the list type 'Widget'.
            // [answer] Row 의 children 이 List [] 인데 지금 List 를 리턴하니깐 [] 를 없애주어야지..
            List.generate(
                100,
                (index) => Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey),
                    )),
      ),
    );
  }

```

# CachedImageNetwork 객체
```dart
child : CachedNetworkImage(imageUrl: thumbPath, fit: Boxfit.cover),
```

# ClipRect 객체
> 컨테이너 객체 가장자리 둥글게 만들어준다.
```dart
ClipRRect(borderRadius: BorderRadius.circular(65), )
```
> 만약 Container() 안에다가 바로 하고 싶다면
```dart
List.generate(100, (index) => Container(decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),))

```

# ExpandableText 객체
```dart
ExpandableText(prefixText: '개발하는남자', prefixStyle: TextStyle(fontWeight: FontWeight.bold),
onPrefixTap: () => print(" 개발하는 남자 링크로 가즈아!") , 
'콘텐츠1입니다.콘텐츠1입니다.콘텐츠1입니다.', expandText: '더보기', collapseText: '접기',
maxLines: 3, expandOnTextTap: true, collapseOnTextTap: true,
linkColor: Colors.grey,),
```

# GestureDetector 객체
```dart
return GestureDetector(onTap: (){}, child: Text('댓글 199개 모두보기', style: TextStyle(),), )
```

# Container 객체 가로전체 채우기, Container width & height
```dart
Container(width: Size:infinite.width), 
```
> Container `width=200, height=200` 미리 입력하는 습관을 들이도록 하자.
# Container Circle 모양으로 만들기
```dart
Container(width: 25, height: 25,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple,
          border: Border.all(color: Colors.white, width: 2)),
          child: Icon(Icons.add, color: Colors.white,),
        ),
```

# AppBar 객체 사이즈 알아내기
```dart
Scaffold( bottom: PreferredSize(preferredSize: Size.fromHeight(AppBar().preferredSize.height))), // 이런게 참 중요한 건데.. 
```

# TabBar 객체 알아야 할 내용
> TabBar(), TabController() // 이건 이벤트를 받기에 인터페이스 상속받고, TabBarView() 를 이용해서 내부만든다.

# 중첩 라우팅 - nested navigating
> Navigator 로 감싸진 객체 즉 nested Navigator 로 들어가서는 그 안에서 네비게이션이 이루어진다. 
> IndexedStack 과 TabBarView 는 여전히 1개의 페이지이므로 Navigator 가 필요가 없다.
> 따라서 nested Navigator 에서 나오려면 WillPopScope 을 구현해 주어야 한다.
> 그리고 해당 중첩 Navigator 의 Navigation 을 조절하려면 Global Key 를 이용해 주어야 한다. 그래서 Global Key 를 루트에 선언해 주는거다.
```dart
// pop 할게 있으면 하는데 그래서 true 가 되고 그러면 앱이 종료되는데 종료되는걸 막기 위해서 !await 를 해주는 거다.
return !await bottomNavigationBarController.searchFocusNavigationKey.currentState!.maybePop();
```

# BottomNavigationBar 객체
> 

# enum 객체
> Rx type 으로 넣을 수 없다는 문제
```dart
enum PageName {HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE}
var page = PageName.values[value];
```

# PageView 객체도 사용해 보도록 하자. (애니메이션과 손으로 넘기기도 되는것 같다.)

# SingleChildScrollView 객체 기억나지?


# Wrap 객체 - 너무 많으면 다음줄로 넘긴다. Warning 피할 수 있슴
[What is Wrap object](https://medium.com/flutter-community/flutter-wrap-widget-e1ee0b005b16)
```dart
Wrap(
  direction: Axis.vertical,
  children: [
    MyWidget(),
    MyWidget(),
    MyWidget(),
    MyWidget(),
    MyWidget(),
  ],
),
```
# WillPopScope 객체
> false 는 계속 유지, true 는 종료
[강제 종료하는 방법](https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app)
```dart
  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      Get.defaultDialog(title: 'close', content: Text('Do you want to close?'),  textConfirm: "Close", textCancel: "Cancel",
          // 여기 잘봐라. exit(0) 아주 중요하다. 그리고 Get.back()
          onConfirm: ()=> exit(0), onCancel: ()=> Get.back());
      return true;
    } else {
      print('goto before page!'); // 현재는 아무것도 움직이지 않잖아????
      bottomHistory.removeLast(); // 마지막걸 지우고..
      print(bottomHistory);
      var index = bottomHistory.last;
      changeBottomNav(index, isTapped: false); // 여기 보이나? 탭으로 바꿔주고 있다는 걸... 결국 이게 맞네.. 내가 한게 맞았네..
      return false;
    }
  }

```

# Material 객체 - 스타일을 입히기 위해서
```dart
// TODO
```
# ElevatedButton 객체 - 배경색

```dart
showDialog(context: Get.context!, builder: (context) {
  return MessagePopup( // 여기 잘보자. cancel Callback : Get.back 만 했다. 왜냐하면 함수가 넘어가야 하니깐.
  okCallback: (){exit(0);}, title: '시스템', message: '종료하시겠습니까?', cancelCallback: Get.back,
);


////
final Function()? _cancelCallback;
final Function()? _okCallback;

////
ElevatedButton(onPressed: () {_okCallback;}, child: const Text("확인"),),
ElevatedButton(onPressed: () {_cancelCallback;}, style: ElevatedButton.styleFrom(primary: Colors.grey), child: const Text("취소"),),

```
# showDialog 객체
> 함수를 호출해야한다는 의미는 함수의 이름만 1:1로 대응이 되어야하는데 너는 실수로 () => 함수를 실행시켰다. 
> 완전 삽질을 한거지..

# CachedNetworkImage
> 프로젝트를 새로 시작해라. 그래야지 제대로 불러들인다. 왜냐고? PUb sub 새로 들어왔잖아.
> Indicator 도 사용할 수 있고.. 다재다능하네.

```dart
  Widget type1Widget() {
    // Gradation 이 들어가야하는 위젯이다.
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple, Colors.orange]),
          shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65), // 이걸 감싸주어야 동그랗게 잘라줄 수 있게 된다.
        child: SizedBox(
          width: 65,
          height: 65,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

```
```dart
Widget type1WidgetTempBackup() {
  // Gradation 이 들어가야하는 위젯이다.
  return Container(
    width: 160,
    height: 160,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.orange]),
        shape: BoxShape.circle),
    child: CachedNetworkImage(
      imageUrl: 'https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=0d3f33fb6aa6e0154b7713a00454c83d',
      placeholder: (context, url) => const CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 150,
      ),
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        radius: 150,
      ),
    ),
  );
}

```

# List 를 사용해서 children 에 배열을 계속 나열하고 싶을 때
```dart
      child: Row(
        children: [
          _myStory(),
          // [question] The element type 'List<Container>' can't be assigned to the list type 'Widget'.
          // [answer] Row 의 children 이 List [] 인데 지금 List 를 리턴하니깐 [] 를 없애주어야지..
          ...List.generate( // 배열을 계속 나열하겠다는 뜻임.
              100,
                  (index) => AvatarWidget(thumbPath: 'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2022-04/220428-dog-breeds-mb-1019-95b354.jpg', type: AvatarType.TYPE1)),

        ]
      ),
```
```dart
    return Column(
      children:
      List.generate(50, (index) => PostWidget()).toList(),);
  }
```

# Stack 객체 (Positioned 객체 사용법)
```dart
  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(thumbPath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5W2qWDdF7ztjYI9lL_odxd3LY3uv8BOI9Ug&usqp=CAU', type: AvatarType.TYPE2, size: 70,),
        Positioned(
          right: 1,bottom: 0, child: Container(width: 25, height: 25,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.purple,
          border: Border.all(color: Colors.white, width: 2)),
          child: Icon(Icons.add, color: Colors.white,),
        ),
        )
      ],
    );
  }

```

# 28. ExpandableText 객체 (... 으로 늘렸다 줄였다 하는 위젯)



# instagram_clone_coding

Instagram Clone Coding

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
