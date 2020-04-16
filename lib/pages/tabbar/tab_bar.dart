import 'package:flutter/material.dart';
import 'package:gank/pages/home/home_page.dart';
import 'package:gank/pages/my/my_page.dart';

class GankTabBar extends StatefulWidget {
  @override
  GankTabBarState createState() => new GankTabBarState();
}

class GankTabBarState extends State<GankTabBar>  with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          GankHome(),
          GankMy()
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: tabController,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black26,
          tabs: <Widget>[
            new Tab(
              text: "首页",
              icon: new Icon(Icons.home),
            ),
            new Tab(
              text: "我的",
              icon: new Icon(Icons.verified_user),
            ),
          ],
        )
      ),
    );
  }
}