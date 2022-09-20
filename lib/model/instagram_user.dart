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
}
