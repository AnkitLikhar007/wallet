// @dart=2.9
import 'dart:convert';
import 'dart:io';

//import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:scotwallet/config/globals.dart';
import 'package:scotwallet/utils/elog.dart';

class ServiceBuilder {
/*  Future<String> callApiPost(String params, String url,
      BuildContext context) async {

    Dio dio =  Dio();

    ELog.log("params::"+params);
    Map<String, dynamic> headers = {
      HttpHeaders.contentTypeHeader: "application/json"};
    try {
      Response response = await dio.post(
        url,
        data: params,
        options: RequestOptions(
          method: 'post',
          headers: headers,
        ),
      ); //Dio

      String body = response.data.toString();
      ELog.log("Body: " + body);

      var respObj = json.decode(body);
      String result = respObj[Globals.JSON_KEY_RESULT].toString();
      if (result == Globals.JSON_RESULT_SUCCESS) {
        String value = respObj[Globals.JSON_KEY_VALUE].toString();
        ELog.log("success response::"+value);
        return value;
      } else {
        return "[\"failure\"]";
      }
    } catch (error, stackTrace) {
      ELog.log(error.toString());
    }
    return "[]";
  }*/
}