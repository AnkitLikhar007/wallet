// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/text_styles.dart';

class GenericGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonTap;
  final Color color;

  GenericGradientButton(
      {@required this.buttonText,
      @required this.buttonTap,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color(0xFF0D47A1),
        Color(0xFF42A5F5),
      ])),
      child: RaisedButton(
          onPressed: buttonTap,
          color: color,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyles.buttonTextStyle(context),
            ),
          )),
    );
  }
}

