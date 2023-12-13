import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future sucesspopup(BuildContext context,String txt){
return QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    text: txt,
    autoCloseDuration: const Duration(seconds: 10),
    showConfirmBtn: true,
    customAsset: 'assets/popup/success.gif',
    barrierDismissible: true
  );

}


Future warningpopup(BuildContext context,String txt){
    return QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: txt,
        autoCloseDuration: const Duration(seconds: 10),
        showConfirmBtn: true,
        customAsset: 'assets/popup/warning.gif',
        barrierDismissible: true

    );

}

Future errorpopup(BuildContext context,String txt){
    return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: txt,
        autoCloseDuration: const Duration(seconds: 10),
        showConfirmBtn: true,
        customAsset: 'assets/popup/error.gif',
        barrierDismissible: true

    );

}

Future<void> telegramapi(String txt) async {
  String url = 'https://api.telegram.org/bot6898953943:AAGFx3oJnaRSIAg51WuFbvBY3Y52SJn9ZjI/sendMessage';
  print(url);
  final response = await http.post(
      Uri.parse(url),
      body:
      {
        'chat_id': "@apigka",
        'text': txt,
        'parse_mode': 'html',

      }
  );

}












