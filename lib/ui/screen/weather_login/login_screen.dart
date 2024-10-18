import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/components/WidgetLoading.dart';
import 'package:weather_app/config/constant.dart';
import 'package:weather_app/controllers/location_controller.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/province.dart';
import 'package:weather_app/ui/screen/weather_main/weather_screen.dart';

import '../../../components/custom_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocatioinController locatioinController = Get.put(LocatioinController());
  final _name = TextEditingController();
  ProvinceModel? _selectedProvince;
  CityModel? _selectedCity;
  bool isLoading = false;
  void simulatedLogin() {
    if (_name.text.isEmpty || _name.text == "") {
      CustomToast.showToast(context, 'error', 'Nama harus diisi!');
      return;
    }
    if (_selectedProvince == "" || _selectedProvince == null) {
      CustomToast.showToast(
          context, 'error', 'Pilih provinsi terlebih dahulu!');
      return;
    }
    if (_selectedCity == "" || _selectedCity == null) {
      CustomToast.showToast(context, 'error', 'Pilih kota terlebih dahulu!');
      return;
    }
    loginUser(_name.text, _selectedProvince?.name, _selectedCity?.name);
  }

  void loginUser(
      String? name, String? _selectedProvince, String? _selectedCity) async {
    setState(() {
      isLoading = true;
    });
    //Replace String
    final original = _selectedCity!;
    String newString = original
        .replaceAll('KABUPATEN ', '')
        .replaceAll('KOTA ', '')
        .replaceAll(' SELATAN', '')
        .replaceAll(' TIMUR', '')
        .replaceAll(' UTARA', '')
        .replaceAll(' BARAT', '')
        .replaceAll(' PUSAT', '');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name!);
    prefs.setString('province', _selectedProvince!);
    prefs.setString('city', newString);
    setState(() {
      isLoading = false;
    });
    Get.to(() => WeatherScreen(
          name: name,
          province: _selectedProvince,
          city: newString,
        ));
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString('name');
    final String? province = prefs.getString('province');
    final String? city = prefs.getString('city');
    print(username);
    if (username != null) {
      Get.to(() =>
          WeatherScreen(name: username, province: province!, city: city!));
    } else {
      print("Gagal");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/weather.png'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * (80 / 100),
                    height: 35,
                    child: TextField(
                      controller: _name,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: colorSecondary,
                          size: 15,
                        ),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: colorSecondary,
                          ),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.only(
                            bottom: 10.0, left: 10.0, right: 10.0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: colorSecondary,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        labelText: 'Full Name',
                        labelStyle:
                            TextStyle(color: colorSecondary, fontSize: 12),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (locatioinController.loading.value) {
                      return CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * (80 / 100),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          border: OutlineInputBorder(),
                          labelText: 'Select Province',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _selectedProvince,
                            onChanged: (ProvinceModel? newValue) {
                              setState(() {
                                _selectedProvince = newValue;
                                locatioinController.getCity(
                                    provinceId: newValue?.id.toString());
                              });
                            },
                            hint: Text('Select Province'),
                            items: locatioinController.provinceList
                                .map((ProvinceModel province) {
                              return DropdownMenuItem<ProvinceModel>(
                                value: province,
                                child: Text(province.name ?? ''),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (locatioinController.loading.value) {
                      return CircularProgressIndicator();
                    }
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * (80 / 100),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          border: OutlineInputBorder(),
                          labelText: 'Select City',
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<CityModel>(
                            value: _selectedCity,
                            onChanged: (CityModel? newValue) {
                              setState(() {
                                _selectedCity = newValue;
                              });
                            },
                            hint: Text('Select City'),
                            items: locatioinController.cityList
                                .map((CityModel city) {
                              return DropdownMenuItem<CityModel>(
                                value: city,
                                child: Text(city.name ?? ''),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          colorPrimary,
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 30,
                        )),
                      ),
                      onPressed: () {
                        print('Login button pressed');
                        // Navigator.pushReplacement(context,
                        //     new MaterialPageRoute(builder: (context) => MyApp()));
                        simulatedLogin();
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
            ),
            LoadingWidget(
              title: 'Sedang Login!',
              message: 'Mohon tunggu!',
              isLoading: isLoading,
            ),
          ],
        ),
      )),
    );
  }

  
}
