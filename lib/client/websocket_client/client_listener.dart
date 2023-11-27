import 'package:web_socket_channel/web_socket_channel.dart';

import 'dart:async';

class GotifyWebSocketClientListener {
  WebSocketChannel channel;
  bool isClosed = false;
  Duration reconnectDelay = const Duration(seconds: 5);
  int maxReconnectAttempts = 5;
  int currentReconnectAttempt = 0;

  GotifyWebSocketClientListener(this.channel) {
    channel.stream.listen(
      (data) {},
      onDone: () {
        if (!isClosed) {
          reconnect();
        }
      },
      onError: (error) {
        handleError(error);
      },
      cancelOnError: true,
    );
  }

  void handleError(dynamic error) {
    print('WebSocket error: $error');
  }

  void reconnect() {
    if (currentReconnectAttempt < maxReconnectAttempts) {
      Future.delayed(reconnectDelay, () {
        currentReconnectAttempt++;
      });
    } else {
      print('Max reconnect attempts reached. Could not reconnect.');
    }
  }

  void close() {
    isClosed = true;
    channel.sink.close();
  }
}
