// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/text_styles.dart';

class GenericButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonTap;
  final Color color;

  GenericButton(
      {@required this.buttonText,
      @required this.buttonTap,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        onPressed: buttonTap,
        color: color,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyles.buttonTextStyle(context),
          ),
        ));
  }
}
