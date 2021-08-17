// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:scotwallet/config/globals.dart';

class ELog {
  static void log(message) {
    if(Globals.LOG) {
      debugPrint("Elite Log: " + message.toString());
    }
  }
}