import 'package:shared_preferences/shared_preferences.dart';

class SharedHandler{

  
  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String token = '';

    try {
       token = pref.getString('access_token')!;
    } catch (e) {
      print(e);
    }

    return token;
  }
}