import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && (Platform.isLinux || Platform.isAndroid)
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'defaultName');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          break;
      }
    });
  }

  Future<void> showNotification({
    String? payload,
    required int id,
    required String? title,
    required String body,
    String? page,
  }) async {
    const NotificationDetails notificationDetails = NotificationDetails();
    await flutterLocalNotificationsPlugin.show(
      payload: page,
      id,
      title,
      body,
      notificationDetails,
    );
  }

  void dispose() {
    selectNotificationStream.close();
  }
}
