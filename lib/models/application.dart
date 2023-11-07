class ApplicationModel {
  int defaultPriority;
  String description;
  int id;
  String image;
  bool internal;
  String lastUsed;
  String name;
  String token;

  ApplicationModel({
    required this.defaultPriority,
    required this.description,
    required this.id,
    required this.image,
    required this.internal,
    required this.lastUsed,
    required this.name,
    required this.token,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      defaultPriority: json['defaultPriority'] as int,
      description: json['description'] as String,
      id: json['id'] as int,
      image: json['image'] as String,
      internal: json['internal'] as bool,
      lastUsed: json['lastUsed'] as String,
      name: json['name'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'defaultPriority': defaultPriority,
      'description': description,
      'id': id,
      'image': image,
      'internal': internal,
      'lastUsed': lastUsed,
      'name': name,
      'token': token,
    };
  }
}
