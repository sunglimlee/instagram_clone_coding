import 'package:instagram_clone_coding/pages/about_screen.dart';
import 'package:instagram_clone_coding/pages/home_screen.dart';
import 'package:instagram_clone_coding/pages/item_screen.dart';
import 'package:instagram_clone_coding/pages/like_screen.dart';
import 'package:instagram_clone_coding/pages/search_screen.dart';

enum BottomNavigationNames {
  HOME,
  SEARCH,
  ITEM,
  LIKE,
  ABOUT}

class MyScreens {
  static var aboutScreen = AboutScreen();
  static var homeScreen = HomeScreen();
  static var itemScreen = ItemScreen();
  static var likeScreen = LikeScreen();
  static var searchScreen = SearchScreen();
}
