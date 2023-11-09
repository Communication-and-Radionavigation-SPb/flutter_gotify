class ApplicationModel {
  int? defaultPriority;
  String description;
  int id;
  String image;
  bool internal;
  String? lastUsed;
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
      defaultPriority: json['defaultPriority'],
      description: json['description'],
      id: json['id'],
      image: json['image'],
      internal: json['internal'],
      lastUsed: json['lastUsed'],
      name: json['name'],
      token: json['token'],
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

  @override
  String toString() {
    return ' application: $name $token';
  }
}
