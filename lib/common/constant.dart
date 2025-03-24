import 'package:get_storage/get_storage.dart';

class Constant {
  final storage = GetStorage();

  static var url =
      "https://casino.timesofearth.online/v1/"; //"http://192.168.1.100:1001/";
  static var reportUrl = "";
  static var defaultUpiID;

  static int withdrawalAmountLimit = 0;
  static List<dynamic> defaultRecharge = [];
  static Map<String, String> AUTH0_AUDIENCE = {};
  static var AUTH0_CLIENT_ID = '';
  static var AUTH0_DOMAIN = '';
  static var AUTH0_REDIRECT_URI = '';
  static var AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
  static var pref;
  static var userSession;
  static String email = "";
  static var accessToken;
  static var size;
  static var notificationCount = 0;

// static var currentroute = Routes.dashboard;
// static var currentProfile = Routes.noprofile;
// static var currentactiveProfile = Routes.activeprofile;

  static String bossHero = "bosshero";

  ///OneSignal Notification
  static var osUserID;
}
