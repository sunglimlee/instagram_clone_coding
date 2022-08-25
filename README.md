#목차 (Github commit 확인)
1. Image 객체
2. BottomNavigationBar 객체
3. Getx binding 새로운 방법
4. IndexedStack 객체
5. Navigator 를 만들지 않고 `List<int> = [0];`를 사용해서 navigation 을 하고 있네..
6. SingleChildScrollView 객체 
7. CachedNetworkImage 객체
8. ClipRect 객체 : 이름을 잘 생각해 봐라.
9. ExpandableText 객체
10. GestureDetector 객체
11. Container 객체 가로전체 채우기
12. AppBar 객체 사이즈 알아내기
13. TabBar 객체 알아야 할 내용
14. 중첩 라우팅 - nested navigating
15. BottomNavigationBar 객체
16. enum 객체
17. PageView 객체도 사용해 보도록 하자. (애니메이션과 손으로 넘기기도 되는것 같다.)
18. SingleChildScrollView 객체 기억나지?


# Image 객체
> 디바이스 pixel ratio 에 따라 값이 조절되도록 하고 싶을 때
```dart
return image.asset(icon, width: width / MediaQuery.of(context).devicePixelRatio);
```

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

# Navigator 를 만들지 않고 `List<int> = [0];`를 사용해서 navigation 을 하고 있네..


# SingleChildScrollView 객체
```dart
return SingleChildScrollView(
scrollDirection : Axis.horizontal, child: Row(
children: List.generate(100, (index) => Container(width: 60, height: 60,
   decoration: BoxDecoration(shape: BoxShape.circle, color: Color.grey))))
);
```

# CachedImageNetwork 객체
```dart
child : CachedNetworkImage(imageUrl: thumbPath, fit: Boxfit.cover),
```

# ClipRect 객체
```dart
ClipRect(borderRadius: BorderRadius.circular(65), )
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

# Container 객체 가로전체 채우기
```dart
Container(width: Size:infinite.width), 
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

# enum
> Rx type 으로 넣을 수 없다는 문제

# PageView 객체도 사용해 보도록 하자. (애니메이션과 손으로 넘기기도 되는것 같다.)

# SingleChildScrollView 객체 기억나지?








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
