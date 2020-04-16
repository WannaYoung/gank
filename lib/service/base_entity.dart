import 'entity_factory.dart';

class BaseEntity<T> {
  int status;
  String message;
  T data;

  BaseEntity({this.status, this.message, this.data});

  factory BaseEntity.fromJson(json) {
    return BaseEntity(
      status: json["status"],
      message: json["msg"],
      // data值需要经过工厂转换为我们传进来的类型
      data: EntityFactory.generateOBJ<T>(json["data"]),
    );
  }
}

class BaseListEntity<T> {
  int status;
  int counts;
  String message;
  List<T> data;

  BaseListEntity({this.status, this.counts, this.message, this.data});

  factory BaseListEntity.fromJson(json) {
    List<T> mData = new List<T>();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }

    return BaseListEntity(
      status: json["status"],
      counts: json["counts"],
      message: json["msg"],
      data: mData,
    );
  }
}