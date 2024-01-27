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

  /// 로그인 요청 후 성공 여부 리턴하는 함수
  Future<bool> login(String inputID, String inputPassword) async {
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
      ).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      // 로그인 성공 시
      if (validStatusCodes.contains(response.statusCode)) {
        result = true;
        String accessToken = response.headers['access_token']!;
        String refreshToken = response.headers['refresh_token']!;
        resetResultText();

        idController.text = '';
        pwController.text = '';

        await _saveLoginState(true);
        await saveTokens(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } else if (response.statusCode == 408){
        loginResultString = '';
        update();
      }
      else {
        pwController.text = '';
        loginResultString = '아이디나 패스워드를 확인해주세요.';
        update();
      }
    } catch (e) {
      
      debugPrint('error: $e');
    }

    return result;
  }

  /// 로그인 성공 여부 텍스트 초기화
  resetResultText() {
    loginResultString = '';
    update();
  }

  /// 토큰값 sharedPreference에 저장
  saveTokens(
      {required String accessToken, required String refreshToken}) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    
    try {
      pref.setString('access_token', accessToken);
      pref.setString('refresh_token', refreshToken);
    } catch (e) {
      debugPrint('$e');
    }finally{
      debugPrint('세이브토큰:  ${pref.getString('access_token')}');
    }
  }
  
  _saveLoginState(bool loginState) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      pref.setBool('login_state', loginState);
    } catch (e) {
      debugPrint('$e');
    }
  }

  /// 로그아웃 함수. 토큰 값 초기화
  logout(){
    // 토큰 초기화
    saveTokens(accessToken: '', refreshToken: '');
    // 로그인상태 바꾸기
    _saveLoginState(false);
  }
}
