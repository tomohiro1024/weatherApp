import 'dart:convert';

import 'package:http/http.dart';

class ZipCode {
  static Future<String?> searchAddressFromZipCode(String zipCode) async {
    String url = 'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode';

    try {
      // urlの取得
      var result = await get(Uri.parse(url));
      // jsonDecode()によってresultの中身がjson型からMap型に変換する。
      Map<String, dynamic> date = jsonDecode(result.body);
      String address = date['results'][0]['address2'];
      return address;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
