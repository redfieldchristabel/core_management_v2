import 'package:core_management_v2/core_management_v2.dart';

class NotificationService extends BaseNotificationService {
  NotificationService() : super();

  @override
  String get defaultIcon => '@mipmap/ic_launcher';


}

final NotificationService notificationService = NotificationService();
