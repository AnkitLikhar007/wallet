// @dart=2.9
import 'package:flutter/material.dart';
import 'package:scotwallet/presentation/colors.dart';

class TextStyles {
  static TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(fontSize: 16, color: ScotCoinColors.white);
  }
  static TextStyle noteTextStyle(BuildContext context) {
    return TextStyle(fontSize: 14, color: ScotCoinColors.black);
  }
  static TextStyle headlineTextStyle(BuildContext context) {
    return TextStyle(fontSize: 17, color: ScotCoinColors.black);
  }
  static TextStyle headlineBoldTextStyle(BuildContext context) {
    return TextStyle(fontSize: 17, color: ScotCoinColors.black,fontWeight: FontWeight.bold);
  }
  static TextStyle tipsTextStyle(BuildContext context) {
    return TextStyle(fontSize: 15, color: ScotCoinColors.black);
  }
  static TextStyle sendReceiveTextStyle(BuildContext context) {
    return TextStyle(fontSize: 14, color: ScotCoinColors.black);
  }
  static TextStyle trTimeTextStyle(BuildContext context) {
    return TextStyle(fontSize: 14, color: ScotCoinColors.gray);
  }
  static TextStyle trDebitTextStyle(BuildContext context) {
    return TextStyle(fontSize: 12, color: ScotCoinColors.red,fontWeight: FontWeight.bold);
  }
  static TextStyle trCreditTextStyle(BuildContext context) {
    return TextStyle(fontSize: 12, color: ScotCoinColors.green,fontWeight: FontWeight.bold);
  }

}