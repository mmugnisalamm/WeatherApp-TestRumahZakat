
class WeatherModel {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;
  int? id;
  String? main;
  String? desc;
  String? icon;
  double? clouds;
  double? windSpeed;
  double? windDeg;
  double? windGust;
  double? visibilty;
  double? pop;
  String? pod;
  String? date;

  WeatherModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
    this.id,
    this.main,
    this.desc,
    this.icon,
    this.clouds,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.visibilty,
    this.pop,
    this.pod,
    this.date,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    // Bagian "main"
    temp = json['main']['temp']?.toDouble();
    feelsLike = json['main']['feels_like']?.toDouble();
    tempMin = json['main']['temp_min']?.toDouble();
    tempMax = json['main']['temp_max']?.toDouble();
    pressure = json['main']['pressure'];
    seaLevel = json['main']['sea_level'];
    grndLevel = json['main']['grnd_level'];
    humidity = json['main']['humidity'];
    tempKf = json['main']['temp_kf']?.toDouble();
    if (json['weather'] != null && json['weather'].isNotEmpty) {
      id = json['weather'][0]['id'];
      main = json['weather'][0]['main'];
      desc = json['weather'][0]['description'];
      icon = json['weather'][0]['icon'];
    }
    clouds = json['clouds']['all']?.toDouble();
    windSpeed = json['wind']['speed']?.toDouble();
    windDeg = json['wind']['deg']?.toDouble();
    windGust = json['wind']['gust']?.toDouble();
    visibilty = json['visibility']?.toDouble();
    pop = json['pop']?.toDouble();
    pod = json['sys']['pod'];
    date = json['dt_txt'];
  }
}
