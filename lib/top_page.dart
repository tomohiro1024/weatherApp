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
  Weather currentWeather = Weather(
      10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12, 10), 50, 10);
  // 1時間ごとの天気情報
  List<Weather> hourlyWeather = [
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 10), 50, 10),
    Weather(11, 15, 5, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 11), 60, 10),
    Weather(12, 15, 5, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 12), 70, 10),
    Weather(13, 15, 5, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30, 13), 80, 10),
  ];
  // 日毎の天気情報
  List<Weather> dailyWeather = [
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 27), 50, 10),
    Weather(11, 16, 6, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 28), 60, 10),
    Weather(12, 17, 7, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 29), 70, 10),
    Weather(13, 18, 8, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30), 80, 10),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 27), 50, 10),
    Weather(11, 16, 6, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 28), 60, 10),
    Weather(12, 17, 7, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 29), 70, 10),
    Weather(13, 18, 8, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30), 80, 10),
    Weather(10, 15, 5, '晴れ', 5.5, 5.5, '晴れ', DateTime(2022, 1, 27), 50, 10),
    Weather(11, 16, 6, '曇り', 5.5, 5.5, '晴れ', DateTime(2022, 1, 28), 60, 10),
    Weather(12, 17, 7, '雨', 5.5, 5.5, '晴れ', DateTime(2022, 1, 29), 70, 10),
    Weather(13, 18, 8, '台風', 5.5, 5.5, '晴れ', DateTime(2022, 1, 30), 80, 10),
  ];

  List<String> weekDay = ['月', '火', '水', '木', '金', '土', '日'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    width: 220,
                    child: TextField(
                      onSubmitted: (value) async {
                        String? address;
                        address = await ZipCode.searchAddressFromZipCode(value);
                        print(address);
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: '郵便番号を入力して下さい'),
                    )),
                SizedBox(height: 30),
                Text(
                  'さいたま市',
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  '${currentWeather.temp}°',
                  style: TextStyle(fontSize: 70),
                ),
                Text(currentWeather.description),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text('最高気温: ${currentWeather.tempMax}°'),
                    ),
                    Text('最低気温: ${currentWeather.tempMin}°'),
                  ],
                ),
                SizedBox(height: 40),
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
    );
  }
}
