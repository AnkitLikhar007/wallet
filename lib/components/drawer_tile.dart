// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/text_styles.dart';

class DrawerTile extends StatelessWidget{

  final GlobalKey<ScaffoldState> scaffoldKey;
  final IconData iconData;
  final String labelText;
  final Widget targetScreen;
  final VoidCallback customOntap;
  DrawerTile({
    @required this.scaffoldKey,
    @required this.iconData,
    @required this.labelText,
    @required this.targetScreen,
    this.customOntap
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).primaryColorLight,
      ),
      title: Text(
        labelText,
        style: TextStyles.headlineTextStyle(context),
      ),
      onTap: targetScreen != null ? () => {
        FocusScope.of(context).unfocus(),
        scaffoldKey.currentState.openEndDrawer(),
      } : () => customOntap(),
    );
  }

 /* String routNameType(){
    switch(targetScreen.runtimeType){
      case LoginForm:
        return RouteNames.ROUTE_LOGIN;
        break;

      case FavListScr:
        return RouteNames.ROUTE_FAV;
        break;

      case LanguagesScr:
        return RouteNames.ROUTE_APP_LANG;
        break;

      case LanguagesContScr:
        return RouteNames.ROUTE_CONT_LANG;
        break;

      case SettingsScr:
        return RouteNames.ROUTE_SETTINGS;
        break;

      case HelpScr:
        return RouteNames.ROUTE_HELP;
        break;

      case BookshelfListScr:
        return RouteNames.ROUTE_BOOKSHELF;
        break;  

      case UpcomingScr:
        return RouteNames.ROUTE_UPCOMING;
        break;

      case NotificationsScr:
        return RouteNames.ROUTE_NOTIFICATIONS;
        break;
    }
    return "";
  }*/
}