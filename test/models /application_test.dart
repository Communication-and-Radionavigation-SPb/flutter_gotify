import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ApplicationModel, () {
    test('Application constructor', () {
      ApplicationModel app = ApplicationModel(
        defaultPriority: 1,
        description: "Test Application",
        id: 123,
        image: "test_image.png",
        internal: true,
        lastUsed: "2023-10-31",
        name: "TestApp",
        token: "test_token",
      );

      expect(app.defaultPriority, 1);
      expect(app.description, "Test Application");
      expect(app.id, 123);
      expect(app.image, "test_image.png");
      expect(app.internal, true);
      expect(app.lastUsed, "2023-10-31");
      expect(app.name, "TestApp");
      expect(app.token, "test_token");
    });

    test('Application fromJson', () {
      Map<String, dynamic> json = {
        'defaultPriority': 2,
        'description': "Test Application",
        'id': 456,
        'image': "test_image.png",
        'internal': false,
        'lastUsed': "2023-11-01",
        'name': "TestApp",
        'token': "test_token",
      };

      ApplicationModel app = ApplicationModel.fromJson(json);

      expect(app.defaultPriority, 2);
      expect(app.description, "Test Application");
      expect(app.id, 456);
      expect(app.image, "test_image.png");
      expect(app.internal, false);
      expect(app.lastUsed, "2023-11-01");
      expect(app.name, "TestApp");
      expect(app.token, "test_token");
    });

    test('Application toJson', () {
      ApplicationModel app = ApplicationModel(
        defaultPriority: 3,
        description: "Test Application",
        id: 789,
        image: "test_image.png",
        internal: true,
        lastUsed: "2023-11-02",
        name: "TestApp",
        token: "test_token",
      );

      Map<String, dynamic> json = app.toJson();

      expect(json['defaultPriority'], 3);
      expect(json['description'], "Test Application");
      expect(json['id'], 789);
      expect(json['image'], "test_image.png");
      expect(json['internal'], true);
      expect(json['lastUsed'], "2023-11-02");
      expect(json['name'], "TestApp");
      expect(json['token'], "test_token");
    });
  });
}
