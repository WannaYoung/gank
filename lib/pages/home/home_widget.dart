import 'package:flutter/material.dart';

class HotMenu extends StatelessWidget {
  const HotMenu({Key key, this.titles, this.icons, this.tapMenu}) : super(key: key);

  final List<String> titles;
  final List<Image> icons;
  final Function(int) tapMenu;

  @override
  Widget build(BuildContext context) {
    List<Widget> hotMenus = [];
    for (var i = 0; i < titles.length; i++) {
      hotMenus.add(
        GestureDetector(
          onTap: () => tapMenu(i),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 50,
                  child: icons[i],
                ) 
              ),
              Text(
                titles[i],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                  fontSize: 14
                ),
              )
            ],
          )
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: hotMenus
    );
  }
}