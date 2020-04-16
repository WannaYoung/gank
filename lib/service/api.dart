import 'package:gank/service/api_enum.dart';

class Api {
  static final host = "https://gank.io/api/v2";
  static final banner = "/banners";

  // 分类Api
  static String getCategoryApi(GankCategory gankCategory) {
    return "/categories/${gankCategory.toString().split(".").last}";
  }

  // 列表Api
  static String getListApi(GankCategory gankCategory,
      GankType gankType, int page, int count) {
    return "/data/category/${gankCategory.toString().split(".").last}"
        "/type/${gankType.toString().split(".").last}/page/$page/count/$count";
  }

  // 详情Api
  static String getDetailApi(String postId) {
    return "/post/$postId";
  }

  // 评论Api
  static String getCommentApi(String postId) {
    return "/post/comments/$postId";
  }

  // 热门Api
  static String getHotApi(GankHot gankHot,
      GankCategory gankCategory, int count) {
    return "/hot/${gankHot.toString().split(".").last}/category/${gankCategory.toString().split(".").last}/count/$count";
  }

  // 随机Api
  static String getRandomApi(GankCategory gankCategory,
      GankType gankType, int count) {
    print(gankCategory.toString().split(".").last);
    return "/random/category/${gankCategory.toString().split(".").last}"
        "/type/${gankType.toString().split(".").last}/count/$count";
  }

  // 搜索Api
  static String getSearchApi(String searchText,
      GankCategory gankCategory, GankType gankType, int page, int count) {
    return "/search/$searchText/category/${gankCategory.toString().split(".").last}"
        "/type/${gankType.toString().split(".").last}/page/$page/count/$count";
  }

}


