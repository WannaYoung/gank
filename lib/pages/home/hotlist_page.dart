import 'package:gank/pages/common/webview_page.dart';
import 'package:gank/service/api.dart';
import 'package:gank/service/api_enum.dart';
import 'package:gank/service/dio_manager.dart';
import 'package:gank/models/list_entity.dart';
import 'package:flutter/material.dart';
import 'package:gank/service/http_method.dart';

class HotList extends StatefulWidget {
  const HotList({Key key, this.gankCategory}) : super(key: key);
  final GankCategory gankCategory;

  @override
  HotListState createState() => HotListState();
}

class HotListState extends State<HotList> {
  List<ListEntity> hotList = [];
  Map<String, String> categoryTitle = {
    "GanHuo": "干货",
    "Article": "文章",
    "Girl": "美女",
    "All": "全部"
  };

  @override
  void initState() {
    super.initState();
    getHotList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle[widget.gankCategory.toString().split(".").last])
      ),
      body: 
          ListView.builder( 
            itemCount: hotList.length, 
            itemBuilder: (BuildContext context, int position) {
                return getListRow(position);
            }
          )
      ); 
  }

  // 生成热门列表数据
  Widget getListRow(int index) {
    return ListTile(
        title: Text(
          hotList[index].title,
          style: TextStyle(
            fontWeight: FontWeight.w400, 
            fontSize: 17.0
          )
        ),
        subtitle: Text(
          hotList[index].desc,
          style: TextStyle(
            fontWeight: FontWeight.w300, 
            fontSize: 12.0,
          )
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        onTap: () {
          Navigator.of(context).push(
                      new MaterialPageRoute(builder: (_) {
                      return new Browser(
                        url: hotList[index].url,
                        title: hotList[index].title);
                      })
          );
        }
    );
  }

  // 获取热门列表
  getHotList() async {
    DioManager().requestList<ListEntity>(
        HttpMethod.GET,
        Api.getHotApi(GankHot.views, widget.gankCategory, 20),
        params: null,
        success: (data) {
          if (!mounted) return;
          setState(() {
            hotList = data;
          });
        }, error: (error) {
      print("error code = ${error.status}, massage = ${error.message}");
    });
  }

}