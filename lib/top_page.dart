import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/zip_code.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  // 現在の天気情報
  Weather? currentWeather;

  String? address = 'ー';

  String? errorMessage;

  // 1時間ごとの天気情報
  List<Weather> hourlyWeather = [
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10,
        1, 1),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10,
        1, 1),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10,
        1, 1),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10,
        1, 1),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10,
        1, 1),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10,
        1, 1),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10,
        1, 1),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10,
        1, 1),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10,
        1, 1),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10,
        1, 1),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10,
        1, 1),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10,
        1, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                      width: 220,
                      child: TextField(
                        onSubmitted: (value) async {
                          Map<String, String> response = {};
                          response =
                              (await ZipCode.searchAddressFromZipCode(value))!;

                          // responseの'message'というキーに値が入ってきた(エラーが出た)場合に入ってくる変数
                          errorMessage = response['message'];
                          if (errorMessage != null) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(errorMessage!),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          // responseの'address'というキーが含んでいた場合、変数addressに'address'の値を入れる
                          if (response.containsKey('address')) {
                            address = response['address'];
                            currentWeather =
                                (await Weather.getCurrentWeather(value))!;
                          }
                          print(response);
                          setState(() {});
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: '郵便番号を入力して下さい'),
                      )),
                  // errorMessageに値が入っていない(エラーじゃない)場合何も表示しない
                  // Text(
                  //   errorMessage == null ? '' : errorMessage!,
                  //   style: TextStyle(color: Colors.red),
                  // ),
                  SizedBox(height: 50),
                  Text(
                    address!,
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${currentWeather == null ? 'ー' : currentWeather!.temp}°',
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(height: 20),
                  Text(currentWeather == null
                      ? 'ー'
                      : currentWeather!.description),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                            '最高気温: ${currentWeather == null ? 'ー' : currentWeather!.tempMax}°'),
                      ),
                      Text(
                          '最低気温: ${currentWeather == null ? 'ー' : currentWeather!.tempMin}°'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                            '湿度: ${currentWeather == null ? 'ー' : currentWeather!.humidity}°'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                            '気圧: ${currentWeather == null ? 'ー' : currentWeather!.hpa} hPa'),
                      ),
                      Text(
                          '風速: ${currentWeather == null ? 'ー' : currentWeather!.wind} kt'),
                    ],
                  ),
                  SizedBox(height: 50),
                  // 時間毎のUI
                  Divider(height: 0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: hourlyWeather.map((weather) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 8),
                          child: Column(
                            children: [
                              Text('${DateFormat('H').format(weather.time)}時'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Icon(Icons.light_mode),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${weather.temp}°',
                                  style: TextStyle(fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Divider(height: 0),
                  // 日毎のUI
                  // Expanded(
                  //   child: SingleChildScrollView(
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  //       child: Column(
                  //         children: dailyWeather.map((weather) {
                  //           return Container(
                  //             height: 50,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Container(
                  //                     width: 50,
                  //                     child: Text(
                  //                         '${weekDay[weather.time.weekday - 1]}曜日')),
                  //                 Icon(Icons.light_mode),
                  //                 Container(
                  //                   width: 50,
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text('${weather.tempMax}°',
                  //                           style: TextStyle(fontSize: 17)),
                  //                       Text('${weather.tempMin}°',
                  //                           style: TextStyle(
                  //                               fontSize: 17,
                  //                               color:
                  //                                   Colors.black.withOpacity(0.5))),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
