class ErrorModel {
  String error;
  int errorCode;
  String errorDescription;

  ErrorModel(
      {required this.error,
      required this.errorCode,
      required this.errorDescription});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'],
      errorCode: json['errorCode'],
      errorDescription: json['errorDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['errorCode'] = errorCode;
    data['errorDescription'] = errorDescription;
    return data;
  }
}
