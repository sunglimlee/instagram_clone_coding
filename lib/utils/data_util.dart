import 'package:uuid/uuid.dart';

class DataUtil {
  static String makeFilePath(String filename) {
    // 사진의 이름은 같을 수도 있기 때문에 이름은 uuid 를 사용해 주는게 좋다.
    // 임의의 파일이름을 생성시켜주는 라이브러리구나.
    var extension = filename.split(',');
    return '${const Uuid().v4()}.${extension.last.toString()}';
  }
}