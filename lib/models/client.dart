class ClientModel {
  int id;
  String lastUsed;
  String name;
  String token;

  ClientModel({
    required this.id,
    required this.lastUsed,
    required this.name,
    required this.token,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      lastUsed: json['lastUsed'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lastUsed'] = lastUsed;
    data['name'] = name;
    data['token'] = token;
    return data;
  }
}
