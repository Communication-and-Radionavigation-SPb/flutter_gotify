import 'package:flutter_gotify/background_system/notification_manager.dart';
import 'package:flutter_gotify/client/api_client.dart';
import 'package:flutter_gotify/client/ws_client.dart';

class GotifyNotification {
  final NotificationManager notificationManager = NotificationManager();

  Future<void> displayHttpNotifications({
    required GotifyHttpClient httpClient,
    int limit = 1,
  }) async {
    notificationManager.initialize();
    final messages = await httpClient.getMessages(
      limit: limit,
    );
    for (var message in messages.$1) {
      await notificationManager.showNotification(
        id: message.id,
        title: message.title,
        body: message.message,
      );
    }
  }

  Future<void> displayWebSocketNotification(
      {required GotifyWebSocketClient webSocketClient}) async {
    notificationManager.initialize();
    webSocketClient.messages().listen((message) async {
      await notificationManager.showNotification(
        id: message.id,
        title: message.title,
        body: message.message,
      );
    });
  }
}
