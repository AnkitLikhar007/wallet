// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/colors.dart';

import 'drawer_tile.dart';


class LeftDrawerMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  LeftDrawerMenu({@required this.scaffoldKey});

  @override
  State<StatefulWidget> createState() => LeftDrawerMenuState(this);
}

class LeftDrawerMenuState extends State<LeftDrawerMenu> {
  LeftDrawerMenu menu;

  LeftDrawerMenuState(this.menu);

  List<Widget> drawerList = [];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: Stack(
                children: <Widget>[
                  Container(
                      height: ((MediaQuery
                          .of(context)
                          .size
                          .width / 5) * 191 / 545) + 90,
                      child:
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Flexible(
                                child: Container(
                                  color: ScotCoinColors.purpleAccent,
                                )),
                            Flexible(
                                child: Container(
                                  color: ScotCoinColors.purple,
                                ))
                          ])),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: ScotCoinColors.white,
                      ),
                      onPressed: () =>
                      {
                        widget.scaffoldKey.currentState.openEndDrawer(),
                      },
                    ),
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Image.asset(
                              "images/logo.png",
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5,
                              fit: BoxFit.scaleDown,
                            ))
                      ],
                    ),
                  )
                ],
              )),
          DrawerTile(
            scaffoldKey: menu.scaffoldKey,
            iconData: Icons.settings,
            labelText: "Settings",
            //targetScreen: SettingsScr()
          ),
//          Divider(
//            height: 20,
//            color: Theme
//                .of(context)
//                .dividerColor,
//          ),
          DrawerTile(
            scaffoldKey: menu.scaffoldKey,
            iconData: Icons.book,
            labelText: "FAQ",
            // targetScreen: BookshelfListScr()
          ),
          DrawerTile(
            scaffoldKey: menu.scaffoldKey,
            iconData: Icons.favorite,
            labelText: "Contact Us",
            // targetScreen: FavListScr()
          ),

        ],
      ),
    );
  }

}