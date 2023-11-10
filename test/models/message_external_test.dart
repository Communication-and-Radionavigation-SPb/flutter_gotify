import 'dart:convert';

import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test', () {
    String json =
        """{"id":144,"appid":4,"message":"Hello, world!","title":"Very first message","priority":2,"extras":{"sensors::gps::data":{"latitude":31}},"date":"2023-11-10T14:53:58.367874771Z"}""";
    final data = jsonDecode(json);

    final message = MessageExternalModel.fromJson(data);
  });
}
