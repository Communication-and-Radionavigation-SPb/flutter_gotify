import 'package:flutter_gotify/models/application_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ApplicationParamsModel, () {
    test('ApplicationParams constructor', () {
      ApplicationParamsModel params = ApplicationParamsModel(
        defaultPriority: 1,
        description: "Test Description",
        name: "Test Name",
      );

      expect(params.defaultPriority, 1);
      expect(params.description, "Test Description");
      expect(params.name, "Test Name");
    });

    test('ApplicationParams fromJson', () {
      Map<String, dynamic> json = {
        'defaultPriority': 2,
        'description': "Test Description ",
        'name': "Test Name ",
      };

      ApplicationParamsModel params = ApplicationParamsModel.fromJson(json);

      expect(params.defaultPriority, 2);
      expect(params.description, "Test Description ");
      expect(params.name, "Test Name ");
    });

    test('ApplicationParams toJson', () {
      ApplicationParamsModel params = ApplicationParamsModel(
        defaultPriority: 3,
        description: "Test Description ",
        name: "Test Name ",
      );

      Map<String, dynamic> json = params.toJson();

      expect(json['defaultPriority'], 3);
      expect(json['description'], "Test Description ");
      expect(json['name'], "Test Name ");
    });
  });
}
