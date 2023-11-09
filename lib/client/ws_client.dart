import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_gotify/models/application.dart';
import 'package:flutter_gotify/models/client.dart';
import 'package:flutter_gotify/models/message_external.dart';
import 'package:flutter_gotify/models/paging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GotifyWebSocketClient {
  final String baseUrl;
  final String token;
  final String messageToken;
  late WebSocketChannel _channel;

  GotifyWebSocketClient({
    required this.baseUrl,
    required this.token,
    required this.messageToken,
  });

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl/stream?token=$token'),
    );
  }

  void disconnect() {
    _channel.sink.close();
  }
}
