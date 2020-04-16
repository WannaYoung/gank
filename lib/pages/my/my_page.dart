import 'package:flutter/material.dart';

class GankMy extends StatefulWidget {
  GankMy({Key key}) : super(key: key);

  @override
  GankMyState createState() => GankMyState();
}

class GankMyState extends State<GankMy> {
  List<String> titles;
  List<Icon> icons;

  @override
  void initState() {
    super.initState();
    titles = ["检查更新", 
              "关于我们", 
              "退出登录"];
    icons = [Icon(Icons.update, color: Color(0xFF0194F0)),
            Icon(Icons.contacts, color: Color(0xFFFFAF00)),
            Icon(Icons.block, color: Color(0xFFEB4849))];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: ListView.builder(
            itemCount: titles.length, 
            itemBuilder: (BuildContext context, int position) {
              return getListRow(position);
            },
      ),
    );
  }

  Widget getListRow(int index) {
    return ListTile(
        title: new Text(titles[index],
            style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
        leading: icons[index],
        contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
    );
  }

}