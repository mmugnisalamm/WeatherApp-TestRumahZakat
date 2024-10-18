import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherController extends GetxController {
  RxBool loading = false.obs;
  WeatherServices service = WeatherServices();
  List<WeatherModel> weatherList = [];
  final weather = WeatherModel().obs;
  WeatherModel? todayWeather;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWeather();
  }

  void getWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    loading(true);
    weatherList = await service.fetchWeather(city: prefs.getString("city"));
    // Mencari hari ini dan hari berikutnya (H+1)
    DateTime now = DateTime.now();

    // Mencari satu data cuaca hari ini
    try {
      todayWeather = weatherList.firstWhere((weather) {
        return weather.date != null &&
            weather.date!.startsWith(DateFormat('yyyy-MM-dd').format(now));
      });
    } catch (e) {
      todayWeather =
          null; // Atau dapat mengembalikan objek WeatherModel default
    }

    // Hanya menyimpan data dari hari berikutnya (H+1)
    weatherList = weatherList.where((weather) {
      if (weather.date != null) {
        DateTime weatherDate = DateTime.parse(weather.date!);
        // Pastikan kita hanya mendapatkan data untuk H+1
        return weatherDate.isAfter(now);
      }
      return false;
    }).toList();
    loading(false);
  }

  Map<String, List<WeatherModel>> groupWeatherByDate() {
    Map<String, List<WeatherModel>> groupedWeather = {};
    DateFormat dateFormatter = DateFormat('yyyy-MM-dd'); // Format tanggal saja

    for (var weather in weatherList) {
      if (weather.date != null) {
        try {
          DateTime parsedDate = DateTime.parse(weather.date!);
          String weatherDate = dateFormatter.format(parsedDate);

          if (!groupedWeather.containsKey(weatherDate)) {
            groupedWeather[weatherDate] = [];
          }
          groupedWeather[weatherDate]!.add(weather);
        } catch (e) {
          print('Error parsing date: $e');
        }
      }
    }

    return groupedWeather;
  }
}
