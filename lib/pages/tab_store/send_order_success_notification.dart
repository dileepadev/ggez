import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SendOrderSuccessNotification {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      playSound: true);

  playNotification(String orderID) {
    FlutterLocalNotificationsPlugin().show(
        0,
        'Your GGEZ Order Success',
        "Your order $orderID is complete. Check your email for the payment receipt.",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                playSound: true,
                //color: Colors.blue,
                largeIcon:
                    const DrawableResourceAndroidBitmap("@drawable/splash"),
                icon: '@drawable/splash')));
  }
}
