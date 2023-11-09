import 'package:flutter_gotify/background_system/notification_manager.dart';
import 'package:flutter_gotify/client/api_client.dart';

class GotifyNotification {
  final NotificationManager notificationManager = NotificationManager();
  final GotifyHttpClient client;

  GotifyNotification({required this.client});

  Future<void> displayGotifyNotifications() async {
    notificationManager.initialize();
    final messages = await client.getMessages(
      limit: 1,
    );
    for (var message in messages.$1) {
      print('$message');
      print(messages.$2);
      await notificationManager.showNotification(
          id: message.id, title: message.title, body: message.message);
    }
  }
}
