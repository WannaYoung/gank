import 'package:gank/models/banner_entity.dart';
import 'package:gank/pages/common/webview_page.dart';
import 'package:gank/pages/home/home_widget.dart';
import 'package:gank/pages/home/hotlist_page.dart';
import 'package:gank/service/api.dart';
import 'package:gank/service/api_enum.dart';
import 'package:gank/service/dio_manager.dart';
import 'package:gank/models/list_entity.dart';
import 'package:flutter/material.dart';
import 'package:gank/service/http_method.dart';
import 'package:gank/views/banner_gallery/banner_gallery_bean.dart';
import 'package:gank/views/banner_gallery/banner_gallery_library.dart';

class GankHome extends StatefulWidget {
  GankHome({Key key}) : super(key: key);

  @override
  GankHomeState createState() => GankHomeState();
}

class GankHomeState extends State<GankHome> {
  List<ListEntity> gankList = [];
  List<BannerEntity> bannerList = [];
  List<BannerGalleryBean> bannerGallery = [];

  List<String> hotTitles = ["干货", "文章", "美女", "全部"];
  List<Image> hotIcons = [
    Image.asset("imgs/home/home_gank.png"),
    Image.asset("imgs/home/home_article.png"),
    Image.asset("imgs/home/home_girl.png"),
    Image.asset("imgs/home/home_all.png")
  ];
  List<GankCategory> categories = [
    GankCategory.GanHuo,
    GankCategory.Article,
    GankCategory.Girl,
    GankCategory.GanHuo,
  ];

  @override
  void initState() {
    super.initState();
    getHomeBanner();
    getHomeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('干货')
      ),
      body: 
          ListView.builder( 
            itemCount: gankList.length+4, 
            itemBuilder: (BuildContext context, int position) {
              if (position == 0) {
                return BannerGalleryWidget(
                  data: bannerGallery,
                  onPageTap: (index) {
                    Navigator.of(context).push(
                      new MaterialPageRoute(builder: (_) {
                      return new Browser(
                        url: bannerList[index].url,
                        title: bannerList[index].title);
                      })
                    );
                  },
                );
              } else if (position == 1) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 5),
                  child: Text(
                          "热门",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                        )
                );
              } else if (position == 2) {
                return Container(
                  height: 90,
                  child: HotMenu(titles: hotTitles, icons: hotIcons, tapMenu: (tapIndex) {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                      return HotList(gankCategory: categories[tapIndex]);
                      })
                    ); 
                  })
                );
              } else if (position == 3) {
                return Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                  child: Text(
                          "最新",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18
                          ),
                        )
                );
              } else {
                return getListRow(position-4);
              }
            }
          )
      ); 
  }

  // 生成轮播图数据
  void getBannerGallery(List<BannerEntity> listData) {
    List<BannerGalleryBean> tempGallery = [];
    for (var i = 0; i < listData.length; i++) {
      tempGallery.add(
        BannerGalleryBean(
          id: i.toString(),
          photoUrl: listData[i].image,
          description: listData[i].title
        )
      );
    }
    if (!mounted) return;
    setState(() {
      bannerGallery = tempGallery;
      bannerList = listData;
    });
  }

  // 生成首页列表数据
  Widget getListRow(int index) {
    return ListTile(
        title: Text(
          gankList[index].title,
          style: TextStyle(
            fontWeight: FontWeight.w400, 
            fontSize: 17.0
          )
        ),
        subtitle: Text(
          gankList[index].desc,
          style: TextStyle(
            fontWeight: FontWeight.w300, 
            fontSize: 12.0,
          )
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        onTap: () {
          Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                      return Browser(
                        url: gankList[index].url,
                        title: gankList[index].title);
                      })
          );
        }
    );
  }

  // 获取轮播图
  getHomeBanner() async {
    DioManager().requestList<BannerEntity>(
        HttpMethod.GET,
        Api.banner,
        params: null,
        success: (data) {
          getBannerGallery(data);
        }, error: (error) {
      print("error code = ${error.status}, massage = ${error.message}");
    });
  }

  // 获取首页列表
  getHomeList() async {
    DioManager().requestList<ListEntity>(
        HttpMethod.GET,
        Api.getListApi(GankCategory.All, GankType.All, 1, 20),
        params: null,
        success: (data) {
          if (!mounted) return;
          setState(() {
            gankList = data;
          });
        }, error: (error) {
      print("error code = ${error.status}, massage = ${error.message}");
    });
  }

}