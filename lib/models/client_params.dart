class ClientParamsModel {
  String name;

  ClientParamsModel({
    required this.name,
  });

  factory ClientParamsModel.fromJson(Map<String, dynamic> json) {
    return ClientParamsModel(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
