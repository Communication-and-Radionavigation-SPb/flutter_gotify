class ApplicationParamsModel {
  int defaultPriority;
  String description;
  String name;

  ApplicationParamsModel({
    required this.defaultPriority,
    required this.description,
    required this.name,
  });

  factory ApplicationParamsModel.fromJson(Map<String, dynamic> json) {
    return ApplicationParamsModel(
      defaultPriority: json['defaultPriority'],
      description: json['description'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['defaultPriority'] = defaultPriority;
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}
