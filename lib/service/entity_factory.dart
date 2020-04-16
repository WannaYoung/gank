import 'package:gank/models/list_entity.dart';
import 'package:gank/models/banner_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else if (T.toString() == "ListEntity") {
      return ListEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else {
      return json as T;
    }
  }
}