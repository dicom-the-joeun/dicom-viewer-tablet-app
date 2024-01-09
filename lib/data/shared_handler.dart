import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SharedHandler {

  Future<String> getAccessToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // late String token;

    try {
      return pref.getString('access_token')!;
    } catch (e) {
      print(e);
      return '';
    }finally{
      print('세이브토큰:  ${pref.getString('access_token')}');
      
    }
    // return token;
  }

  setAccessToken(
      {required String accessToken,}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      pref.setString('access_token', accessToken);
    } catch (e) {
      print(e);
    }
  }


  saveAccessToken() async {
    String url = '${dotenv.env['API_ENDPOINT']!}auth/refresh';
    var validStatusCodes = List.generate(100, (i) => 200 + i);

    String refreshToken = await getRefreshToken();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $refreshToken'}
      );

      // 로그인 성공 시
      if (validStatusCodes.contains(response.statusCode)) {
        // 토큰 값 받아오기
        String accessToken = response.headers['access_token']!;
        setAccessToken(accessToken: accessToken);

      } else {
        // 저장못함 ㅠㅠ
        setAccessToken(accessToken: '');
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  Future<String> getRefreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      return pref.getString('refresh_token')!;
    } catch (e) {
      print(e);
      return '';
    }finally{
      // print('세이브토큰:  ${pref.getString('refresh_token')}');
      
    }
    // return token;
  }

  Future<String> fetchData() async {
    // Fetch your data here
    await SharedHandler().saveAccessToken();
    // print(token.value);
    return await SharedHandler().getAccessToken();
    
  }

}
