import 'package:get/get.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/province.dart';
import 'package:weather_app/services/location_services.dart';

class LocatioinController extends GetxController {
  RxBool loading = false.obs;
  LocationServices service = LocationServices();
  RxList<ProvinceModel> provinceList = <ProvinceModel>[].obs;
  RxList<CityModel> cityList = <CityModel>[].obs;

  final province = ProvinceModel().obs;
  final city = CityModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProvince();
  }

  void getProvince() async {
    loading(true);
    var provinces = await service.fetchProvince();
    provinceList.assignAll(provinces);
    loading(false);
  }

  void getCity({String? provinceId}) async {
    loading(true);
    var cities = await service.fetchCity(provinceId: provinceId);
    cityList.assignAll(cities);
    loading(false);
  }
}
