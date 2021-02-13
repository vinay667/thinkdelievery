
import 'package:connectivity/connectivity.dart';

class InternetCheck
{
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print('Mobile data');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print('WIFI');
      return true;
    }
    print('No Internet');
    return false;
  }
}
