import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:gank/pages/tabbar/tab_bar.dart';

// 启动界面
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  void openHomePage() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => GankTabBar(),
        fullscreenDialog: true
      )
    );
  }

  void handleTime() {
    Future.delayed(Duration(seconds: 9999), () {
      setState(() {
        print("启动主界面");
        openHomePage();
      });
    });
  }
  
  @override
  void initState() {
    super.initState();
    handleTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Image.asset("imgs/splash/splash.jpg", fit: BoxFit.contain),
          ),
          Positioned(
            bottom: 60,
            left: 100,
            right: 100,
            child: RaisedButton(
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Text("跳过", style: TextStyle(color: Colors.white),),
              onPressed: () {
                print("启动主界面");
                openHomePage();
              },
            ),
          )
        ],
      ),
    );
  }
  
}