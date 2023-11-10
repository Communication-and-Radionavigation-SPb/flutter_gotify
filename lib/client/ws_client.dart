import 'dart:async';
import 'dart:convert';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GotifyWebSocketClient {
  final String baseUrl;
  final String appToken;
  final String clientToken;
  late WebSocketChannel _channel;

  GotifyWebSocketClient({
    required this.baseUrl,
    required this.appToken,
    required this.clientToken,
  });

  Future<void> connect() {
    Uri url = Uri.parse('$baseUrl/stream/?token=$appToken');

    if (url.scheme == 'http') {
      url = url.replace(scheme: 'ws');
    }

    _channel = WebSocketChannel.connect(url);

    return _channel.ready;
  }

  void disconnect() {
    _channel.sink.close();
  }

  Stream<MessageExternalModel> messages() {
    return _channel.stream.transform(StreamTransformer.fromHandlers(
      handleData: (data, sink) {
        try {
          final json = jsonDecode(data);
          final message = MessageExternalModel.fromJson(json);
          sink.add(message);
        } catch (e) {
          sink.addError(e);
        }
      },
    ));
  }
}
