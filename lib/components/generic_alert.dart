// @dart=2.9
import 'package:flutter/material.dart';

class GenericAlert extends StatelessWidget {
  final String message;

  GenericAlert({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context),
        child: AlertDialog(
          title: Text(message),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),

          actions: <Widget>[
                     /* new FlatButton(
              onPressed: () {
                Navigator.pop(context);
                Future.delayed(Duration(milliseconds: 0), () {});
              },
              child: Text("abc"),
            ),
            new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("xyz"),
            ),*/
          ],
        ));
  }
}
