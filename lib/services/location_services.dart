import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:weather_app/config/constant.dart';
import 'package:weather_app/config/index.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/province.dart';

class LocationServices {
  Future<List<ProvinceModel>> fetchProvince() async {
    try {
      final response = await dioService
      .get('$BASE_URL_AREA/provinces.json', queryParameters: {});

      if (response.data != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return (response.data as List)
            .map((item) => ProvinceModel.fromJson(item))
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

  Future<List<CityModel>> fetchCity({String? provinceId}) async {
    try {
      final response = await dioService
      .get('$BASE_URL_AREA/regencies/$provinceId.json', queryParameters: {});

      if (response.data != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return (response.data as List)
            .map((item) => CityModel.fromJson(item))
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