import 'dart:convert';
import 'dart:io';

import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  String baseUrl = dotenv.env['API_ENDPOINT']!;

  Future<List<StudyTab>> getStudyTabList() async {
    var handler = SharedHandler();
    String token = await handler.fetchData();
    List<StudyTab> studies = [];
    String url = '${baseUrl}studies/';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        debugPrint('스터디탭 리스트 요청 성공');
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var study in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          StudyTab tempStudy = StudyTab.fromMap(study);
          studies.add(tempStudy);
        }
      // STUDYKEY를 기준으로 리스트 정렬
      studies.sort((a, b) => a.STUDYKEY.compareTo(b.STUDYKEY));
      } else {
        // 요청 실패한 경우
        debugPrint('스터디탭 리스트 요청 실패');
      }
    } catch (e) {
      debugPrint('스터디탭 리스트 요청 실패 : $e');
    }

    return studies;
  }

  /// 시리즈탭 api 요청 및 변환 후 리턴하는 함수
  Future<List<SeriesTab>> getSeriesTabList(int studyKey) async {
    var handler = SharedHandler();
    String token = await handler.fetchData();
    // 시리즈 리스트 초기화
    List<SeriesTab> seriesList = [];
    
    String url = '${baseUrl}dcms/thumbnails?studykey=$studyKey';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        debugPrint('시리즈탭 요청 성공!');
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var series in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          SeriesTab tempSeries = SeriesTab.fromMap(series);
          seriesList.add(tempSeries);
        }
      } else {
        debugPrint('시리즈탭 요청 실패');
      }
    } catch (e) {
      debugPrint('시리즈탭 요청 실패 : $e');
    }

    return seriesList;
  }

  Future<Map<String, dynamic>> getStudyImagesZipFile(int studyKey) async {
    var handler = SharedHandler();
    String token = await handler.fetchData();
    String fileName = 'study_$studyKey';
    File file = File('$filePath/$fileName.zip');
    bool result = false;

    String url = '${baseUrl}dcms/images/${studyKey.toString()}';

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'}
      );
      // 2. 응답 받기 (예외처리)
      if (response.statusCode == 200) {
        result = true;
        // 3. 응답에 성공한 경우 (바디에서 파일 받아온다)
        // 내가 원하는 경로에 내가 지정한 파일이름으로 zip파일 저장
        await file.writeAsBytes(response.bodyBytes);
        // 파일이름 기준으로 그 파일 압축풀기
      } else {
        print('압축 해제 실패');
      }
    } catch (e) {
      debugPrint('캐치에 걸림 $e');
    }  
    return {"result": result, "fileName": fileName};
  }
}