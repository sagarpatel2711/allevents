import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart';

import 'logger.dart';

class ApiManage {
  static Future<bool> checkInternet() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static final Client client = Client();

  static getCall({required String url}) async {
    var uri = Uri.parse(url);
    logger.i("uri : $uri");

    var response = await client.get(
      uri,
    );

    if (response.statusCode == 200) {
      return await jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      logger.e("status code 401 :   ${jsonDecode(response.body)}");
      return await jsonDecode(response.body);
    } else if (response.statusCode == 403) {
      logger.e("status code 403 :   ${jsonDecode(response.body)}");
      return await jsonDecode(response.body);
    } else if (response.statusCode == 500) {
      logger.e("status code 500 :   ${jsonDecode(response.body)}");
      return await jsonDecode(response.body);
    } else if (response.statusCode == 504) {
      logger.e("status code 504 :   ${jsonDecode(response.body)}");
      return await jsonDecode(response.body);
    }
  }
}
