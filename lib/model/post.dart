import 'package:instagram_clone_coding/model/instagram_user.dart';

// 보면 전부 null 이 되도록 해놓았다. 그래서 생성자에서도 required 가 없고..
class Post {
  // 올리는 그들에 대해서 전부 모델 객체로 만들어서 관리하겠다는거네..
  final String? id; // 이 Post 에 대한 고유의 id 이지.
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final InstagramUser? userInfo;
  final String? uid; // 이건 중복으로 들어가 있는것 같은데.. 아니면 InstagramUser.uid 와의 차이는 뭘까?
  final DateTime? createAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;

  Post(
      {this.id,
      this.thumbnail,
      this.description,
      this.likeCount,
      this.userInfo,
      this.uid,
      this.createAt,
      this.updateAt,
      this.deleteAt}); // 나중에 List 로 관리하는게 좋다.

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
        id: json['id'] == null ? '' : json['id'] as String,
        thumbnail: json['thumbnail'] == '' ? null : json['thumbnail'] as String,
        description:
            json['description'] == '' ? null : json['description'] as String,
        likeCount: json['likeCount'] == 0 ? null : json['likeCount'] as int,
        userInfo: json['userInfo'] == null
            ? null
            : InstagramUser.fromJson(json['userInfo']),
        uid: json['uid'] == null ? '' : json['uid'] as String,
        createAt: json['createAt'] == null
            ? DateTime.now()
            : json['createAt'] as DateTime,
        updateAt: json['updateAt'] == null
            ? DateTime.now()
            : json['updateAt'] as DateTime,
        deleteAt: json['deleteAt'] == null
            ? null
            : json['deleteAt'] as DateTime // 지운건 데이타를 저장하지 않겠다는 거지?
        );
  }

  // 최초 실행되는 거기때문에 많이 비어 있어도 된다.
  factory Post.init(InstagramUser userInfo) {
    return Post(
        thumbnail: '',
        // TODO 나중에 사진 전송하기 전에 thumbnail 을 채워야지
        userInfo: userInfo,
        uid: userInfo.uid,
        description: '',
        // TODO 여기도 보면 다른잖아. 그러니깐 Post 는 새게시물을 얘기하는 거지.
        createAt: DateTime.now(),
        updateAt: DateTime.now());
  }

  // 여기서 또 immutable 하게 하기 위해서 copyWith 를 만들어준다. 데이터를 저장하는게 달라져서 그렇나?
  // 그러니깐 현재 있는 객체를 이용해서 하나 더 카피를 하겠다는 거잖아..
  Post copyWith(
      {String? id, // 이 Post 에 대한 고유의 id 이지.
      String? thumbnail,
      String? description,
      int? likeCount,
      InstagramUser? userInfo,
      String? uid, // 이건 중복으로 들어가 있는것 같은데.. 아니면 InstagramUser.uid 와의 차이는 뭘까?
      DateTime? createAt,
      DateTime? updateAt,
      DateTime? deleteAt}) {
    return Post(
        id: id ?? this.id,
        // 이 Post 에 대한 고유의 id 이지.
        thumbnail: thumbnail ?? this.thumbnail,
        description: description ?? this.description,
        likeCount: likeCount ?? this.likeCount,
        userInfo: userInfo ?? this.userInfo,
        uid: uid ?? this.uid,
        // 이건 중복으로 들어가 있는것 같은데.. 아니면 InstagramUser.uid 와의 차이는 뭘까?
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        deleteAt: deleteAt ?? this.deleteAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'thumbnail' : thumbnail,
      'description' : description,
      'likeCount' : likeCount,
      'userInfo' : userInfo?.toMap(),
      'uid' : uid,
      'createdAt' : createAt,
      'updatedAt' : updateAt,
      'deletedAt' : deleteAt,
    };
  }
}
