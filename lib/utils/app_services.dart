import 'dart:io';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:phone_email/networks/network_request.dart';
import 'package:phone_email/utils/app_constants.dart';

class AppService {
  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      /// return iOS device id
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      /// return Android device id
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  /*
  * Get email count using authorized number with JWT token
  * */
  static getLoginUserEmailCount(String token,
      {required Function(String, String) onEmailCount}) async {
    var decoded = JWT.decode(token);
    String jwtPhone =
        decoded.payload['country_code'] + decoded.payload['phone_no'];

    getEmailCount(token).then((value) {
      onEmailCount.call(jwtPhone, value);
    });
  }

  /*
  * Check JWT token is valid or not 
  * And also check is expired or not
  */
  static bool isValidJwtToken(String jwtToken) {
    try {
      final jwt = JWT.verify(jwtToken, SecretKey(AppConstants.API_KEY));
      print(jwt.payload);
      return jwt.payload != null;
    } on JWTExpiredException {
      print('jwt expired');
      return false;
    } on JWTException catch (ex) {
      print(ex.message);
      return false;
    }
  }
}
