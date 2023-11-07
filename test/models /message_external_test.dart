import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(MessageExternalModel, () {
    test('MessageExternal constructor', () {
      MessageExternalModel message = MessageExternalModel(
        appid: 1,
        date: "2023-11-02",
        extras: {"key": "value"},
        id: 123,
        message: "Test Message",
        priority: 2,
        title: "Test Title",
      );

      expect(message.appid, 1);
      expect(message.date, "2023-11-02");
      expect(message.extras, {"key": "value"});
      expect(message.id, 123);
      expect(message.message, "Test Message");
      expect(message.priority, 2);
      expect(message.title, "Test Title");
    });

    test('MessageExternal fromJson', () {
      Map<String, dynamic> json = {
        'appid': 2,
        'date': "2023-11-03",
        'extras': {"key": "value"},
        'id': 456,
        'message': "Test Message",
        'priority': 3,
        'title': "Test Title",
      };

      MessageExternalModel message = MessageExternalModel.fromJson(json);

      expect(message.appid, 2);
      expect(message.date, "2023-11-03");
      expect(message.extras, {"key": "value"});
      expect(message.id, 456);
      expect(message.message, "Test Message");
      expect(message.priority, 3);
      expect(message.title, "Test Title");
    });

    test('MessageExternal toJson', () {
      MessageExternalModel message = MessageExternalModel(
        appid: 3,
        date: "2023-11-04",
        extras: {"key": "value"},
        id: 789,
        message: "Test Message",
        priority: 4,
        title: "Test Title",
      );

      Map<String, dynamic> json = message.toJson();

      expect(json['appid'], 3);
      expect(json['date'], "2023-11-04");
      expect(json['extras'], {"key": "value"});
      expect(json['id'], 789);
      expect(json['message'], "Test Message");
      expect(json['priority'], 4);
      expect(json['title'], "Test Title");
    });
  });
}
