import 'package:instagram_clone_coding/pages/about_screen.dart';
import 'package:instagram_clone_coding/pages/home_screen.dart';
import 'package:instagram_clone_coding/pages/search_screen.dart';
import 'package:instagram_clone_coding/pages/like_screen.dart';
import 'package:instagram_clone_coding/pages/search_screen_old.dart';

enum BottomNavigationNames {
  HOME,
  SEARCH,
  ITEM,
  LIKE,
  ABOUT}

class MyScreens {
  static var aboutScreen = AboutScreen();
  static var homeScreen = HomeScreen();
  // static var searchFocus = SearchFocus();
  static var likeScreen = LikeScreen();
  static var searchScreen = SearchScreenOld();
}
