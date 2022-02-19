import 'dart:convert';

import 'package:http/http.dart';

class Weather {
  int temp;
  int tempMax;
  int tempMin;
  String description;
  double lon;
  double lat;
  String icon;
  DateTime time;
  int rainyPercent;
  int humidity;

  Weather(this.temp, this.tempMax, this.tempMin, this.description, this.lon,
      this.lat, this.icon, this.time, this.rainyPercent, this.humidity);

  // 現在の天気情報を取得するクラス
  static Future<Weather?> getCurrentWeather(String zipCode) async {
    String? _zipCode;
    // 郵便番号にハイフンが含まれている場合は正常に処理する
    if (zipCode.contains('-')) {
      _zipCode = zipCode;
    } else {
      // 郵便番号にハイフンが含まれていない場合は間にハイフンを入れる
      _zipCode = zipCode.substring(0, 3) + '-' + zipCode.substring(3);
    }
    //openWeatherMapAPIで現在の天気情報を取得するURL
    String url =
        'https://api.openweathermap.org/data/2.5/weather?zip=$_zipCode,JP&appid=20dabda8e9b77ce7502ea5882318bea2&lang=ja&units=metric';
    try {
      // urlの取得
      var result = await get(Uri.parse(url));
      Map<String, dynamic> date = jsonDecode(result.body);
      print(date);

      Weather currentWeather = Weather(
          date['main']['temp'].toInt(),
          date['main']['temp_max'].toInt(),
          date['main']['temp_min'].toInt(),
          date['weather'][0]['description'],
          date['coord']['lon'],
          date['coord']['lat'],
          '晴れ',
          DateTime(2020, 10, 2, 12),
          10,
          date['main']['humidity']);
      return currentWeather;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
