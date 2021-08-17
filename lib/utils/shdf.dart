// @dart=2.9
import 'package:shared_preferences/shared_preferences.dart';

class SHDFClass {
  static Future<String> readSharedPrefString(
      String name, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getString(name);
  }

  static saveSharedPrefValueString(String name, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(name, value);
  }

  static Future readShdfBoolean(String name, String defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getBool(name);
  }

  static saveSharedPrefValueBoolean(String name, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setBool(name, value);
  }

  static Future readShdfInt(String name, int defaultValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return await preferences.getInt(name);
  }

  static saveSharedPrefValueInt(String name, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setInt(name, value);
  }


  static saveSharedPrefListData(String name,  List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setStringList(name, value);
  }

  static readSharedPrefListData(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getStringList(name);
  }


}
