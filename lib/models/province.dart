class ProvinceModel {
  int? id;
  String? name;

  ProvinceModel({this.id, this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
      id: json['id'] != null ? int.parse(json['id']) : null, // Convert id dari String ke int
      name: json['name'],
    );
  }
}