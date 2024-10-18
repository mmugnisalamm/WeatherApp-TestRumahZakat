class CityModel {
  int? id;
  int? provinceId;
  String? name;

  CityModel({this.id, this.provinceId, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] != null ? int.parse(json['id']) : null,
      provinceId: json['province_id'] != null ? int.parse(json['province_id']) : null,
      name: json['name'],
    );
  }
}
