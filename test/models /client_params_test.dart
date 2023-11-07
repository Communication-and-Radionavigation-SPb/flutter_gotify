import 'package:flutter_gotify/models/client_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ClientParamsModel, () {
    test('ClientParams constructor', () {
      ClientParamsModel params = ClientParamsModel(
        name: "Test Client",
      );

      expect(params.name, "Test Client");
    });

    test('ClientParams fromJson', () {
      Map<String, dynamic> json = {
        'name': "Test Client",
      };

      ClientParamsModel params = ClientParamsModel.fromJson(json);

      expect(params.name, "Test Client");
    });

    test('ClientParams toJson', () {
      ClientParamsModel params = ClientParamsModel(
        name: "Test Client",
      );

      Map<String, dynamic> json = params.toJson();

      expect(json['name'], "Test Client");
    });
  });
}
