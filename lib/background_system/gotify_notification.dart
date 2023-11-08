import 'package:flutter_gotify/background_system/notification_manager.dart';
import 'package:flutter_gotify/client/api_client.dart';

class GotifyNotification {
  final NotificationManager notificationManager = NotificationManager();
  final GotifyClient client;

  GotifyNotification({required this.client});

  Future<void> displayGotifyNotifications() async {
    notificationManager.initialize();
    final messages = await client.getMessages();
    for (var message in messages.$1) {
      await notificationManager.showNotification(
          id: message.id, title: message.title, body: message.message);
    }
  }
}
