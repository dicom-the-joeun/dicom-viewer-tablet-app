import 'dart:convert';

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
        print('스터디탭 리스트 요청 성공');
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var study in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          StudyTab tempStudy = StudyTab.fromMap(study);
          studies.add(tempStudy);
        }
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

    List<SeriesTab> seriesList = [];
    
    // 시리즈 리스트 초기화
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
}