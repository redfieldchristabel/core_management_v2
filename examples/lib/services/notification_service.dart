import 'package:core_management_v2/core_management_v2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService extends BaseNotificationService {
  NotificationService() : super(_firebaseMessagingBackgroundHandler);

  @override
  String get defaultIcon => '@mipmap/ic_launcher';
}

final NotificationService notificationService = NotificationService();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  final NotificationService notificationService = NotificationService();

  notificationService.show(
      title: 'background  : ${message.notification?.title ?? 'tiada'}',
      description: message.notification?.body ?? 'tiada');
}
