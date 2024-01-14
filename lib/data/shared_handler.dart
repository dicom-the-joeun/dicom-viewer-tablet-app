import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedHandler {

  Future<String> _getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // late String token;

    try {
      return pref.getString('access_token')!;
    } catch (e) {
      debugPrint('$e');
      return '';
    }finally{
      debugPrint('세이브토큰:  ${pref.getString('access_token')}');
      
    }
    // return token;
  }

  _setAccessToken(
      {required String accessToken,}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      pref.setString('access_token', accessToken);
    } catch (e) {
      debugPrint('$e');
    }
  }


  _saveAccessToken() async {
    String url = '${dotenv.env['API_ENDPOINT']!}auth/refresh';
    var validStatusCodes = List.generate(100, (i) => 200 + i);

    String refreshToken = await _getRefreshToken();
    try {
      debugPrint('access token 재발급 요청');
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $refreshToken'}
      );

      // 로그인 성공 시
      if (validStatusCodes.contains(response.statusCode)) {
        // 토큰 값 받아오기
        String accessToken = response.headers['access_token']!;
        _setAccessToken(accessToken: accessToken);
        debugPrint('access token 재발급 성공');
      } else {
        _setAccessToken(accessToken: '');
        debugPrint('access token 재발급 실패');
      }
    } catch (e) {
      debugPrint('access token 재발급 요청 오류 : $e');
    }
  }

  Future<String> _getRefreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      return pref.getString('refresh_token') ?? '';
    } catch (e) {
      debugPrint('저장된 리프레시 토큰 가져오는 중 오류 : $e');
      return '';
    }finally{
      // print('세이브토큰:  ${pref.getString('refresh_token')}');
      
    }
    // return token;
  }

  Future<String> fetchData() async {
    // Fetch your data here
    await SharedHandler()._saveAccessToken();
    // print(token.value);
    return await SharedHandler()._getAccessToken();
    
  }

}
