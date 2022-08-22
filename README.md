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
> 일단은 중첩 라이팅이 되어야지.. 그래서 아마도 Navigator 객체를 감싸줄거고.. 그리고 그걸 namedTo 이런걸로 가지 않을까? 아니... 정확히는
> GlobalKey 값이 있기때문에 그 키값을 가지고 네비게이터를 찾는거다.

# BottomNavigationBar 객체
> 

# enum
> Rx type 으로 넣을 수 없다는 문제











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
