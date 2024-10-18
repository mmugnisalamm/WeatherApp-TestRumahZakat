import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather_app/config/constant.dart';
import 'package:weather_app/config/index.dart';
import 'package:weather_app/models/weather.dart';

class WeatherServices {
  Future<List<WeatherModel>> fetchWeather({String? city}) async {
    try {
      final response = await dioService
      .get('$BASE_URL_WEATHER/forecast', queryParameters: {'q': city, 'units':'metric', 'appid': API_KEY});

      if (response.data['list'] != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return (response.data['list'] as List)
            .map((item) => WeatherModel.fromJson(item))
            .toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.error != '' && e.message != null) {
        Get.snackbar("GAGAL!", e.message ?? "Terjadi kesalahan",
            snackPosition: SnackPosition.TOP, backgroundColor: colorWhite);
      } else {
        Get.snackbar("Sedang terjadi kesalahan pada server!",
            "Harap ulangi kembali nanti!",
            snackPosition: SnackPosition.TOP, backgroundColor: colorWhite);
      }
      return [];
    }
  }
}