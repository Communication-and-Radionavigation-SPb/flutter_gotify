import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(ClientModel, () {
    test('ClientModel constructor', () {
      ClientModel client = ClientModel(
        id: 1,
        lastUsed: "2023-10-31",
        name: "Test Client",
        token: "test_token",
      );

      expect(client.id, 1);
      expect(client.lastUsed, "2023-10-31");
      expect(client.name, "Test Client");
      expect(client.token, "test_token");
    });

    test('ClientModel fromJson', () {
      Map<String, dynamic> json = {
        'id': 2,
        'lastUsed': "2023-11-01",
        'name': "Test Client",
        'token': "test_token",
      };

      ClientModel client = ClientModel.fromJson(json);

      expect(client.id, 2);
      expect(client.lastUsed, "2023-11-01");
      expect(client.name, "Test Client");
      expect(client.token, "test_token");
    });

    test('ClientModel toJson', () {
      ClientModel client = ClientModel(
        id: 3,
        lastUsed: "2023-11-02",
        name: "Test Client",
        token: "test_token",
      );

      Map<String, dynamic> json = client.toJson();

      expect(json['id'], 3);
      expect(json['lastUsed'], "2023-11-02");
      expect(json['name'], "Test Client");
      expect(json['token'], "test_token");
    });
  });
}
