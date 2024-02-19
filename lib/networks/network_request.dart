import 'package:phone_email/utils/app_constants.dart';
import 'package:http/http.dart' as http;

Future<String> getEmailCount(String jwtToken) async {
  try {
    final response = await http.post(
      Uri.parse(AppConstants.EMAIL_URL),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'merchant_phone_email_jwt': jwtToken},
    );
    if (response.statusCode == 200) {
      // final Map<String, dynamic> data = json.decode(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load email count');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load email count');
  }
}