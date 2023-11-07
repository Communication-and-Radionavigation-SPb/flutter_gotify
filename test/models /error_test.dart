import 'package:flutter_gotify/models/error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ErrorModel, () {
    test('Error constructor', () {
      ErrorModel error = ErrorModel(
        error: "Test Error",
        errorCode: 500,
        errorDescription: "Test Error Description",
      );

      expect(error.error, "Test Error");
      expect(error.errorCode, 500);
      expect(error.errorDescription, "Test Error Description");
    });

    test('Error fromJson', () {
      Map<String, dynamic> json = {
        'error': "Test Error",
        'errorCode': 400,
        'errorDescription': "Test Error Description",
      };

      ErrorModel error = ErrorModel.fromJson(json);

      expect(error.error, "Test Error");
      expect(error.errorCode, 400);
      expect(error.errorDescription, "Test Error Description");
    });

    test('Error toJson', () {
      ErrorModel error = ErrorModel(
        error: "Test Error",
        errorCode: 200,
        errorDescription: "Test Error Description",
      );

      Map<String, dynamic> json = error.toJson();

      expect(json['error'], "Test Error");
      expect(json['errorCode'], 200);
      expect(json['errorDescription'], "Test Error Description");
    });
  });
}
