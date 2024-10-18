import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/config/constant.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather.dart';

class WeatherScreen extends StatefulWidget {
  final String name, province, city;
  const WeatherScreen(
      {super.key,
      required this.name,
      required this.province,
      required this.city});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherController weatherController = Get.put(WeatherController());
  String? date;
  String? greetings;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Current date
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, MMMM dd, yyyy');
    String formattedDate = formatter.format(now);
    setState(() {
      date = formattedDate;
      greetings = getGreetingBasedOnTime();
    });
  }

  String getGreetingBasedOnTime() {
    final now = DateTime.now();
    final currentHour = now.hour;

    if (currentHour >= 5 && currentHour < 12) {
      return 'Pagi';
    } else if (currentHour >= 12 && currentHour < 16) {
      return 'Siang';
    } else if (currentHour >= 16 && currentHour < 19) {
      return 'Sore';
    } else {
      return 'Malam';
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text; // Kembalikan string kosong jika input kosong
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(() => const MyHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Cek status login dari SharedPreferences
        bool isLoggedIn = await _isLoggedIn();
        if (isLoggedIn) {
          // Jika sudah login, tampilkan dialog konfirmasi
          return await _showExitConfirmationDialog(context);
        } else {
          // Jika belum login, kembali ke layar login
          return true; // Izinkan pop
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sky1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 40, left: 20, right: 20),
                child: Stack(
                  children: [
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              capitalizeFirstLetter(widget.city),
                              style: TextStyle(
                                  color: colorWhite, fontSize: fontH1),
                            ),
                            Text(
                              date != null ? date! : "Loading date...",
                              style: TextStyle(
                                  color: colorWhite, fontSize: fontH4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: colorWhite,
                          size: 25,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            logout();
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: colorWhite,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        greetings != null
                            ? "Selamat $greetings, " + widget.name
                            : "Loading...",
                        style: TextStyle(color: colorWhite, fontSize: fontH2),
                      ),
                      Obx(() {
                        if (weatherController.loading.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Text(
                          '${weatherController.todayWeather?.temp} °C',
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: fontH1 + 25,
                          ),
                        );
                      }),
                    ],
                  ),
                  Obx(() {
                    if (weatherController.loading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (weatherController.todayWeather == null) {
                      return Center(
                          child: Text(
                        'No weather data available.',
                        style: TextStyle(color: colorWhite, fontSize: fontb1),
                      ));
                    }
                    return Column(
                      children: [
                        Text(
                          '${weatherController.todayWeather?.main}',
                          style: TextStyle(color: colorWhite, fontSize: fontH2),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            'http://openweathermap.org/img/wn/${weatherController.todayWeather?.icon}@2x.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    );
                  })
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: colorSecondaryTrans,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              size: 40,
                              color: colorWhite,
                            ),
                            Icon(
                              Icons.percent,
                              size: 20,
                              color: colorBlack,
                            ),
                          ],
                        ),
                        Obx(() {
                          if (weatherController.loading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text(
                            '${weatherController.todayWeather?.humidity}%',
                            style:
                                TextStyle(color: colorWhite, fontSize: fontH3),
                          );
                        }),
                        Text(
                          "Humidity",
                          style: TextStyle(color: colorWhite, fontSize: fontH3),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.speed,
                          size: 40,
                          color: colorWhite,
                        ),
                        Obx(() {
                          if (weatherController.loading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text(
                            '${weatherController.todayWeather?.pressure} hpa',
                            style:
                                TextStyle(color: colorWhite, fontSize: fontH3),
                          );
                        }),
                        Text(
                          "Pressure",
                          style: TextStyle(color: colorWhite, fontSize: fontH3),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.cloud,
                          size: 40,
                          color: colorWhite,
                        ),
                        Obx(() {
                          if (weatherController.loading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text(
                            '${weatherController.todayWeather?.clouds}%',
                            style:
                                TextStyle(color: colorWhite, fontSize: fontH3),
                          );
                        }),
                        Text(
                          "Cloudiness",
                          style: TextStyle(color: colorWhite, fontSize: fontH3),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.send,
                          size: 40,
                          color: colorWhite,
                        ),
                        Obx(() {
                          if (weatherController.loading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Text(
                            '${weatherController.todayWeather?.windSpeed} m/s',
                            style:
                                TextStyle(color: colorWhite, fontSize: fontH3),
                          );
                        }),
                        Text(
                          "Wind",
                          style: TextStyle(color: colorWhite, fontSize: fontH3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(top: 0, bottom: 10, right: 20, left: 20),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: colorSecondaryTrans,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Obx(() {
                    if (weatherController.loading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (weatherController.weatherList.isEmpty) {
                      return Center(
                          child: Text(
                        'No weather data available.',
                        style: TextStyle(color: colorWhite, fontSize: fontH3),
                      ));
                    }

                    return _buildWeatherRows();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherRows() {
    final groupedWeather = weatherController.groupWeatherByDate();
    final today = DateTime.now();

    return ListView(
      children: groupedWeather.entries.where((entry) {
        // Mengonversi string tanggal ke DateTime dan memfilter hanya yang lebih besar dari hari ini
        DateTime entryDate = DateTime.parse(entry.key);
        return entryDate.isAfter(today); // Menampilkan data mulai dari H+1
      }).map((entry) {
        String date = entry.key;
        List<WeatherModel> weatherList = entry.value;

        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  DateFormat('EEE\nMM/dd').format(DateTime.parse(date)),
                  style: TextStyle(
                      fontSize: fontH3,
                      fontWeight: FontWeight.normal,
                      color: colorWhite),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: weatherList.map((weather) {
                              String formattedTime = DateFormat('HH:mm')
                                  .format(DateTime.parse(weather.date!));

                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      formattedTime,
                                      style: TextStyle(
                                          color: colorWhite, fontSize: fontH3),
                                    ),
                                    Image.network(
                                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                                      width: 60,
                                    ),
                                    Text(
                                      '${weather.temp} °C',
                                      style: TextStyle(
                                          color: colorWhite, fontSize: fontH3),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') !=
        null; // Menganggap 'name' ada jika sudah login
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Tidak keluar
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop(); // Keluar dari aplikasi di Android
                  } else if (Platform.isIOS) {
                    exit(0); // Keluar dari aplikasi di iOS (langsung keluar)
                  }
                }, // Keluar
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false; // Mengembalikan false jika dialog ditutup tanpa memilih
  }
}
