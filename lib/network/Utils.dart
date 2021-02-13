
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyUtils
{
/*  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.androidId;
    } else {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    }
  }

  static Future<String> getDeviceToken(
      FirebaseMessaging _firebaseMessaging) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('fcmtoken');
    if (token==null) {
      token = await _firebaseMessaging.getToken();
      print(token);
      await prefs.setString('token', token);
    }
    return token;
  }



  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }*/
/*  static String _showTimeInFormat(String date)
  {
    DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat.yMMMMd();
    final DateFormat timeFormatter = DateFormat.jms();
    String dateAsString = formatter.format(dateTime)+' At '+timeFormatter.format(dateTime);
    return dateAsString;

  }*/


  static Future<Null> saveSharedPreferences(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
    return null;
  }

  static Future<String> getSharedPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String value = preferences.getString(key);
    return value;
  }
  static Future<String> getDeviceToken(
      FirebaseMessaging _firebaseMessaging) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await prefs.getString('fcmtoken');
    if (token==null) {
      token = await _firebaseMessaging.getToken();
      print(token);
      await prefs.setString('token', token);
    }
    return token;
  }


}