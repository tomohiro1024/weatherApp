import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/weather.dart';
import 'package:weather_app/zip_code.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  Weather? currentWeather;
  String? address = '';
  String? errorMessage;
  String? prefAddress;
  Image? image;
  List<Weather>? hourlyWeather;
  bool isButtonEnabled = false;
  bool isVisible = false;
  bool isApi = false;
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future(() async {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        prefAddress = sharedPreferences.getString('address') ?? '';
      });
    });
  }

  String? getAnimation(icon) {
    if (icon == '01d' || icon == '01n') {
      return 'assets/sunny.json';
    } else if (icon == '02d' || icon == '02n') {
      return 'assets/fewClouds.json';
    } else if (icon == '03d' ||
        icon == '04d' ||
        icon == '03n' ||
        icon == '04n') {
      return 'assets/images/sunny.png';
    } else if (icon == '09d' ||
        icon == '10d' ||
        icon == '09n' ||
        icon == '10n') {
      return 'assets/rain.json';
    } else if (icon == '11d' || icon == '11n') {
      return 'assets/thunder.json';
    } else if (icon == '13d' || icon == '13n') {
      return 'assets/snow.json';
    }
    return 'assets/sunny.json';
  }

  Icon? getWeatherIcon(icon) {
    const defaultIcon = Icon(
      Icons.sunny,
      size: 200,
      color: Colors.redAccent,
    );

    const sunnyIcon = Icon(
      Icons.sunny,
      size: 200,
      color: Colors.redAccent,
    );
    if (icon == '01d' || icon == '01n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    } else if (icon == '02d' || icon == '02n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    } else if (icon == '03d' ||
        icon == '04d' ||
        icon == '03n' ||
        icon == '04n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    } else if (icon == '09d' ||
        icon == '10d' ||
        icon == '09n' ||
        icon == '10n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    } else if (icon == '11d' || icon == '11n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    } else if (icon == '13d' || icon == '13n') {
      return const Icon(
        Icons.sunny,
        size: 200,
        color: Colors.redAccent,
      );
    }
    return const Icon(
      Icons.sunny,
      size: 200,
      color: Colors.redAccent,
    );
  }

  List<Color> backgroundColor(icon) {
    if (icon == '01d' || icon == '01n') {
      return [
        Colors.red,
        Colors.cyan,
        Colors.blueAccent,
      ];
    }

    if (icon == null) {
      [
        Colors.cyanAccent,
        Colors.cyan,
        Colors.blueAccent,
      ];
    }

    return [
      Colors.cyanAccent,
      Colors.cyan,
      Colors.blueAccent,
    ];
  }

  Widget colorContainer(icon) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: backgroundColor(icon),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        colorContainer(currentWeather?.icon),
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Opacity(
                      opacity: 0.7,
                      child: Text('version: 1.2.2',
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 210,
                      child: TextField(
                        cursorColor: Colors.yellow,
                        keyboardType: TextInputType.number,
                        controller: _textEditingController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: '郵便番号の入力',
                          prefixIcon: Icon(
                            Icons.place,
                            color: Colors.yellow,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: isButtonEnabled
                          ? null
                          : () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                isButtonEnabled = true;
                              });
                              Map<String, String> response = {};
                              response =
                                  (await ZipCode.searchAddressFromZipCode(
                                      _textEditingController.text))!;

                              errorMessage = response['message'];
                              if (errorMessage != null) {
                                address = '';
                                final snackBar = SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(errorMessage!),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              if (response.containsKey('address')) {
                                isApi = true;

                                sharedPreferences.setString('address', address!);
                                setState(() {
                                  prefAddress =
                                      sharedPreferences.getString('address') ?? '';
                                });
                                currentWeather =
                                    (await Weather.getCurrentWeather(
                                        _textEditingController.text))!;
                                print('currentWeathercurrentWeather2222');

                                print(currentWeather!.icon);
                                
                                address = response['address'];

                                hourlyWeather = await Weather.getForecast(
                                    currentWeather!.lon, currentWeather!.lat);
                              }
                              await Future.delayed(const Duration(seconds: 2),
                                  () {
                                setState(() {
                                  isButtonEnabled = false;
                                  if (errorMessage != null && isApi == false) {
                                    isVisible = false;
                                  } else {
                                    isVisible = true;
                                  }
                                });
                              });

                              if (currentWeather!.temp < 15) {
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.blueAccent,
                                    content: Text('今日も寒いので風邪には気を付けましょう'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                              setState(() {});
                            },
                      child: const Text(
                        '天気取得',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: const Color(0xFFeedcb3),
                        side: const BorderSide(
                          color: Colors.yellow,
                          width: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(width: 35),
                    const Opacity(
                      opacity: 0.8,
                      child: Text('前回取得した住所:',
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                    const SizedBox(width: 5),
                    Opacity(
                      opacity: 0.8,
                      child: Text('$prefAddress',
                          style: const TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      address!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 10),
                    isVisible
                        ? Text(
                            '${currentWeather == null ? 'ー' : currentWeather!.temp}°',
                            style: const TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Container(),
                  ],
                ),
                const SizedBox(height: 5),
                currentWeather == null
                    ? Container()
                    : SizedBox(
                        height: 250,
                        child: getWeatherIcon(currentWeather!.icon)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          isVisible
                              ? const Icon(
                                  Icons.local_fire_department,
                                  size: 40,
                                  color: Colors.redAccent,
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          isVisible
                              ? RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: '最高気温 '),
                                      TextSpan(
                                        text: currentWeather == null
                                            ? 'ー'
                                            : '${currentWeather!.tempMax}°',
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          isVisible
                              ? const Icon(
                                  Icons.ac_unit,
                                  size: 40,
                                  color: Colors.cyanAccent,
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          isVisible
                              ? RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: '最低気温 '),
                                      TextSpan(
                                        text: currentWeather == null
                                            ? 'ー'
                                            : '${currentWeather!.tempMin}°',
                                        style: const TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          isVisible
                              ? const Icon(
                                  Icons.water_drop,
                                  size: 40,
                                  color: Colors.blueAccent,
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          isVisible
                              ? RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: '湿度 '),
                                      TextSpan(
                                        text: currentWeather == null
                                            ? 'ー'
                                            : '${currentWeather!.humidity}°',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          isVisible
                              ? const Icon(
                                  Icons.wind_power,
                                  size: 40,
                                  color: Colors.white70,
                                )
                              : Container(),
                          const SizedBox(height: 5),
                          isVisible
                              ? RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: '風速 '),
                                      TextSpan(
                                        text: currentWeather == null
                                            ? 'ー'
                                            : '${currentWeather!.wind} m/s',
                                        style: const TextStyle(
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // isVisible
                //     ? const Divider(
                //         thickness: 1,
                //         color: Colors.blue,
                //       )
                //     : Container(),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: hourlyWeather == null
                //       ? Container()
                //       : Row(
                //           children: hourlyWeather!.map((weather) {
                //             return Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 9, vertical: 8),
                //               child: Column(
                //                 children: [
                //                   Text(
                //                     '${DateFormat('H').format(weather.time)}時',
                //                     style: const TextStyle(
                //                       fontStyle: FontStyle.italic,
                //                     ),
                //                   ),
                //                   Image.network(
                //                     'https://openweathermap.org/img/wn/${weather.icon}.png',
                //                     width: 40,
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 8.0),
                //                     child: Text(
                //                       '${weather.temp}°',
                //                       style: const TextStyle(
                //                         fontSize: 19,
                //                         fontStyle: FontStyle.italic,
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             );
                //           }).toList(),
                //         ),
                // ),
                isVisible
                    ? Container()
                    : Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'あなたが郵便番号を入力\nするのを待っています...',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 20),
                            SpinKitPouringHourGlass(
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                // isVisible
                //     ? const Divider(
                //         thickness: 1,
                //         color: Colors.blue,
                //       )
                //     : Container(),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
