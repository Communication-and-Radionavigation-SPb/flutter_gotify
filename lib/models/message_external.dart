class MessageExternalModel {
  int appid;
  String date;
  Map<String, dynamic>? extras;
  int id;
  String message;
  int priority;
  String? title;

  MessageExternalModel({
    required this.appid,
    required this.date,
    required this.extras,
    required this.id,
    required this.message,
    required this.priority,
    required this.title,
  });

  factory MessageExternalModel.fromJson(Map<String, dynamic> json) {
    return MessageExternalModel(
      appid: json['appid'],
      date: json['date'],
      extras: json['extras'],
      id: json['id'],
      message: json['message'],
      priority: json['priority'] ?? 0,
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appid'] = appid;
    data['date'] = date;
    data['extras'] = extras;
    data['id'] = id;
    data['message'] = message;
    data['priority'] = priority;
    data['title'] = title;
    return data;
  }
}
