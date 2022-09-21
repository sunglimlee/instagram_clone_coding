class InstagramUser {
  String? uid;
  String? nickname;
  String? thumbnail;
  String? description;

  InstagramUser({this.uid, this.nickname, this.thumbnail, this.description});

  // factory 가 리턴값을 만들어내기때문에 static 처럼 사용할 수 있다.
  factory InstagramUser.fromJson(Map<String, dynamic> json) {
    return InstagramUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      nickname: json['nickname'] == null ? '' : json['nickname'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description:
          json['description'] == null ? '' : json['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // 이 user 데이터를 map 으로 어떻게 바꾸는데?
    return {
      'uid': uid,
      'nickname': nickname,
      'description': description,
      'thumbnail': thumbnail,
    };
  }

  InstagramUser copyWith({String? uid, String? nickname, String? thumbnail, String? description}) {
     return InstagramUser(
       uid: uid ?? this.uid,
       nickname: nickname ?? this.nickname,
       description: description ?? this.description,
       thumbnail: thumbnail ?? this.thumbnail,
     );
  }
}
