import 'package:get/get.dart';
import 'package:instagram_clone_coding/model/post.dart';
import 'package:instagram_clone_coding/src/repository/post_repository.dart';

class HomeController extends GetxController {
  RxList<Post> postList = <Post>[].obs;

  @override
  void onInit() {
    loadFeedList();
  }

  void loadFeedList() async {
    var feedList = await PostRepository
        .loadFeedList(); // 잘봐라.. 데이터베이스에 접근해서 데이터를 가지고 오는 부분이잖아. 그래서 Repository 에서 불러오는거지.;
    postList.clear();
    postList.addAll(feedList);
    // 이제는 좀더 고급지게 작업할거야.. forEach 가 있는걸 알잖아.
    // [for 문 관련 내용] https://flutterbyexample.com/lesson/looping-for-in-and-for-each
/*
    feedList.forEach((post) {
      print('피드리스트 $post');
    });
    print(feedList.length.toString());
*/
  }
}
