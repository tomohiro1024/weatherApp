import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  Image? image;

  // 1時間ごとの天気情報
  List<Weather>? hourlyWeather;

  String? getAnimation(icon) {
    if (icon == '01d') {
      return 'assets/sunny.json';
    } else if (icon == '02d') {
      return 'assets/fewClouds.json';
    } else if (icon == '03d' || icon == '04d') {
      return 'assets/clouds.json';
    } else if (icon == '09d' || icon == '10d') {
      return 'assets/rain.json';
    } else if (icon == '11d') {
      return 'assets/thunder.json';
    } else if (icon == '13d') {
      return 'assets/snow.json';
    }
    return 'assets/sunny.json';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
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
                            if (currentWeather!.temp < 15) {
                              const snackBar = SnackBar(
                                backgroundColor: Colors.blueAccent,
                                content: Text('今日も寒いので気を付けましょう'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // if (currentWeather!.temp < 20) {
                            //   const snackBar = SnackBar(
                            //     backgroundColor: Colors.blueAccent,
                            //     content: Text('今日ha気を付けましょう'),
                            //   );
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar);
                            // }

                            hourlyWeather = await Weather.getForecast(
                                currentWeather!.lon, currentWeather!.lat);
                          }
                          print(response);
                          setState(() {});
                        },
                        textAlign: TextAlign.center,
                        decoration:
                            const InputDecoration(hintText: '郵便番号を入力して下さい'),
                      )),
                  const SizedBox(height: 50),
                  Text(
                    address!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${currentWeather == null ? 'ー' : currentWeather!.temp}°',
                    style: const TextStyle(fontSize: 60),
                  ),
                  const SizedBox(height: 10),

                  // hourlyWeather == null
                  //     ? Container()
                  //     : Image.network(
                  //         'https://openweathermap.org/img/wn/${hourlyWeather![0].icon}.png',
                  //         errorBuilder: (BuildContext? context,
                  //             Object? exception, StackTrace? stackTrace) {
                  //           return const Text('Your error widget...');
                  //         },
                  //         width: 50,
                  //       ),
                  currentWeather == null
                      ? Container()
                      : SizedBox(
                          height: 50,
                          child: Lottie.asset(
                              '${getAnimation(hourlyWeather![0].icon)}'),
                        ),
                  Text(currentWeather == null
                      ? 'ー'
                      : currentWeather!.description),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 50),
                  // 時間毎のUI
                  const Divider(
                    thickness: 1,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: hourlyWeather == null
                        ? Container()
                        : Row(
                            children: hourlyWeather!.map((weather) {
                              print(weather);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 8),
                                child: Column(
                                  children: [
                                    Text(
                                        '${DateFormat('H').format(weather.time)}時'),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${weather.icon}.png',
                                      width: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${weather.temp}°',
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
