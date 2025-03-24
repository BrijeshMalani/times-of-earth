import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ui_screen/news_home.dart';

// Global constant for storing OneSignal user ID
String? osUserID;

// AdMob ad unit IDs
const String bannerAdUnitId =
    'ca-app-pub-3940256099942544/6300978111'; // Test ad unit ID
const String interstitialAdUnitId =
    'ca-app-pub-3940256099942544/1033173712'; // Test ad unit ID

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  // Initialize AdMob
  await MobileAds.instance.initialize();

  if (!kIsWeb) {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("8121a2bf-d729-4acc-a11f-bf172147d1aa");

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    onesignalNotification();
  }

  runApp(MyApp());
}

onesignalNotification() async {
  if (kIsWeb) return;

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
    print("event.notification");
    print(event.notification);
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
    print("result");
    print(result);
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
    print("changes");
    print(changes);
  });

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
    print("changes");
    print(changes);
  });

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
    print("emailChanges");
    print(emailChanges);
  });

  final status = await OneSignal.shared.getDeviceState();
  osUserID = status?.userId;
  print("osUserID");
  print(osUserID);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News Portal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewsHome(),
    );
  }
}
