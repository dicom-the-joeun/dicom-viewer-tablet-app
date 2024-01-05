import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginVM extends GetxController {
  /// textField controller
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  String loginResultString = '';

  // textField
  Future<bool> loginCheck(String inputID, String inputPassword) async {
    // 로그인 성공 여부
    bool result = false;
    // post body
    Map<String, dynamic> data = {
      'username': inputID.trim(),
      'password': inputPassword.trim(),
    };
    // 요청 url
    String url = '${dotenv.env['API_ENDPOINT']!}auth/login';
    // 
    var validStatusCodes = List.generate(100, (i) => 200 + i);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        },
        body: data,
      );

      // 로그인 성공 시
      if (validStatusCodes.contains(response.statusCode)){
        result = true;
        resetResultString();
        // print(response.headers['access_token']);
        await saveTokens(
          accessToken: response.headers['access_token']!, 
          refreshToken: response.headers['refresh_token']!,
        );
      }else{
        result = false;
        loginResultString = '아이디나 패스워드를 확인해주세요';
        update();
      }

    } catch (e) {
      debugPrint('error: $e');
    }

    return result;
  }

  resetResultString(){
    loginResultString = '';
    update();
  }

  /// 토큰값 sharedPreference에 저장
  saveTokens({required String accessToken, required String refreshToken}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try{
      pref.setString('access_token', accessToken);
      pref.setString('refresh_token', refreshToken);
    }catch(e){
      print(e);
    }
    
  }
}
