import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationManager {
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future<String> getfcmToken() async {
    String fcmToken = await _fcm.getToken();
    return fcmToken;
  }

  NotificationManager() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
    );
    _fcm.requestNotificationPermissions(
      IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
      ),
    );
  }
}
