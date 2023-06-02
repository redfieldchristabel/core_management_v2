import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// The [BaseNotificationService] class handles local and remote notifications in a Flutter application.
///
/// It utilizes the [FlutterLocalNotificationsPlugin] for displaying local notifications and the
/// [FirebaseMessaging] plugin for handling remote notifications.
abstract class BaseNotificationService {
  /// The instance of the FlutterLocalNotificationsPlugin used for displaying local notifications.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// The Android notification channel for high importance notifications.
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  /// A default channel used by the [show] method to display a notification.
  ///
  /// Override this getter to use a custom channel.
  ///
  /// You need to rerun your Flutter application if you
  /// override this method.
  AndroidNotificationChannel get defaultChanel => channel;

  /// The initialization settings for the Android platform.
  get initializationSettingsAndroid => AndroidInitializationSettings(
        defaultIcon,
      ); // <- default icon name is @mipmap/ic_launcher

  /// The initialization settings for the iOS platform.
  var initializationSettingIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    requestCriticalPermission: true,
  );

  /// will create a new channel or update existing channel
  Future<void> initialiseChanel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(defaultChanel);
  }

  /// Constructs a new instance of the [NotificationService] class.
  ///
  /// It initializes the Flutter Local Notifications plugin by calling [initializeFlutterLocalNotificationPlugin].
  /// It also sets up the callback for handling notification opening when the app is in the foreground.
  BaseNotificationService() {
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => onDidReceiveNotificationResponse(
              NotificationResponse(
                notificationResponseType:
                    NotificationResponseType.selectedNotification,
                payload: json.encode(message.data),
              ),
            ));
  }

  /// Initializes the Flutter Local Notifications plugin.
  ///
  /// This method initializes the Flutter Local Notifications plugin with the provided [initializationSettings].
  /// It sets up the [onDidReceiveNotificationResponse] callback to handle notification responses.
  ///
  /// The [initializationSettings] parameter specifies the settings for initializing the plugin,
  /// including the Android and iOS settings.
  ///
  /// Example usage:
  /// ```dart
  /// final initializationSettings = InitializationSettings(
  ///   android: initializationSettingsAndroid,
  ///   iOS: initializationSettingsIOS,
  /// );
  ///
  /// await notificationService.initializeFlutterLocalNotificationPlugin();
  /// ```
  ///
  /// Throws an exception if the initialization fails.
  Future<void> initializeFlutterLocalNotificationPlugin() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  /// Creates a new notification channel or updates an existing one.
  ///
  /// This method resolves the platform-specific implementation for Android and creates the notification channel.
  ///
  /// Example usage:
  /// ```dart
  /// await notificationService.initializeChanel();
  /// ```
  Future<void> initializeChanel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Handles a foreground notification by displaying it to the user.
  ///
  /// [message] The remote message containing the notification data.
  /// [context] The BuildContext object for displaying the notification.
  void handleForegroundNotification(
    RemoteMessage message, {
    required BuildContext context,
  }) {
    print("ikan");
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    print("ikan : ${notification?.apple == null}");

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null) {
      print("ikan 4");

      flutterLocalNotificationsPlugin
          .show(
            notification.hashCode,
            notification.title,
            notification.body,
            _notificationDetails,
            payload: json.encode(message.data),
          )
          .then((value) => print("iksn 6"));
    }
  }

  NotificationDetails get _notificationDetails {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        defaultChanel.id,
        defaultChanel.name,
        channelDescription: defaultChanel.description,
        icon: defaultIcon,
        // other properties...
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        threadIdentifier: "sppc",
      ),
    );
  }

  /// Override this to change default icon use by [show] method.
  String get defaultIcon => '@mipmap/ic_launcher';

  /// A handler that handles a notification response after the app is terminated.
  Future<void> notificationOnOpenAppHandler() async {
    if (kDebugMode) {
      print("run this noty : ini");
    }

    // Will delay 2 seconds to initialize the app
    await Future.delayed(const Duration(seconds: 2));

    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (kDebugMode) {
      print(
        "run this noty : ini : ${initialMessage != null} , ${notificationAppLaunchDetails?.didNotificationLaunchApp ?? false}",
      );
    }
    // Handle notification created by "FCM" purely
    if (initialMessage != null) {
      onDidReceiveNotificationResponse(NotificationResponse(
        notificationResponseType: NotificationResponseType.selectedNotification,
        payload: json.encode(initialMessage.data),
      ));
    }
    // Handle notification created by "FlutterLocalNotificationsPlugin"
    else if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      if (notificationAppLaunchDetails!.notificationResponse != null) {
        onDidReceiveNotificationResponse(
          notificationAppLaunchDetails.notificationResponse!,
        );
      }
    }
  }

  /// Handles the notification response.
  ///
  /// [notificationResponse] The notification response object.
  Future<void> onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    print("run this noty : every, \npayload : ${notificationResponse.payload}");

    if (notificationResponse.payload == null) return;

    Map<String, dynamic> data = json.decode(notificationResponse.payload!);

    Uri? uri = Uri.tryParse(data['url']);

    print("decoded xxx uri : ${uri.toString()}");

    // List<RouteEntry> routeEntryList = List.empty(growable: true);

    // await routeService.routeNavigator(uri, routeEntryList);
  }

  /// Displays a local notification.
  ///
  /// The [id] parameter specifies the unique identifier for the notification.
  /// The [title] parameter is the title of the notification.
  /// The [description] parameter is the description or body text of the notification.
  /// The optional [payload] parameter can be used to attach additional data to the notification.
  /// The optional [notificationDetails] parameter can be used to use custom notification detail.
  ///
  /// Throws an exception if an error occurs while showing the notification.
  Future<void> show({
    int id = 0,
    required String title,
    required String description,
    String? payload,
    NotificationDetails? notificationDetails,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      description,
      notificationDetails ?? _notificationDetails,
      payload: payload,
    );
  }
}
