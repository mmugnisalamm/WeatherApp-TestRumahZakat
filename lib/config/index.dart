import 'package:dio/dio.dart';

const String API_KEY = "ab31b7f32059694d5722834377519f86";

const String DOMAIN_PATH_WEATHER = "https://api.openweathermap.org";
const String DOMAIN_PATH_AREA = "https://www.emsifa.com/api-wilayah-indonesia";

const String API_ENDPATH_WEATHER = "data/2.5";
const String API_ENDPATH_AREA = "api";

const String BASE_URL_WEATHER = "${DOMAIN_PATH_WEATHER}/${API_ENDPATH_WEATHER}";
const String BASE_URL_AREA = "${DOMAIN_PATH_AREA}/${API_ENDPATH_AREA}";

final dioService = Dio();