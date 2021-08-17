// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/colors.dart';
import 'package:scotwallet/presentation/text_styles.dart';

class GenericLoginButton extends StatelessWidget {
  final String buttonText;
  final IconData icon;
  final VoidCallback buttonTap;
  final Color color;

  GenericLoginButton(
      {@required this.buttonText,
      @required this.buttonTap,
      @required this.color,
      @required this.icon});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: buttonTap,
        color: color,
        child: Center(
            child: Row(
          children: [
            Icon(icon,color: ScotCoinColors.white,size: 15,),
            Padding(padding: EdgeInsets.only(left: 10),
              child: Text(
                buttonText,
                style: TextStyles.buttonTextStyle(context),
              ),
            ),
          ],
        )));
  }
}
