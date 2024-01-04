import 'dart:convert';

import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeVM extends GetxController {
  final equipmentList = [
    '선택해주세요',
    'AS',
    'AU',
    'BI',
    'CD',
    'CF',
  ];

  final verifyList = [
    '선택해주세요',
    'Not requested',
    'Request completed',
  ];

  final decipherList = ['선택해주세요', '판독 상태', '읽지않음', '열람중', '예비판독', '판독'];

  /// textField controller
  TextEditingController userIDController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  /// 드롭다운 선택값 변수 목록
  String equipmentSelectedValue = '선택해주세요';
  String verifySelectedValue = '선택해주세요';
  String decipherSelectedValue = '선택해주세요';

  /// 캘린더 선택날짜
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  /// 검사일자 시작일, 종료일 초기값
  DateTime startDay = DateTime(2000, 1, 1);
  DateTime endDay = DateTime.now();

  /// 검사일자 변경 함수
  Future<DateTime> updateDatePicker(context, DateTime inputDay) async {
    DateTime day = (await showDatePicker(
          context: context,
          firstDate: DateTime(2000, 1, 1),
          lastDate: DateTime(2099, 12, 31),
          currentDate: inputDay,
        )) ??
        inputDay;
    update();
    return day;
  }

  /// 드롭다운 선택 시 선택값 변경 함수
  selectDropDown(String value, List<String> itemList) {
    if (itemList == equipmentList) {
      equipmentSelectedValue = value;
    } else if (itemList == verifyList) {
      verifySelectedValue = value;
    } else {
      decipherSelectedValue = value;
    }
    update();
  }

  /// 검색 조건 초기화 함수
  resetValues() {
    equipmentSelectedValue = '선택해주세요';
    verifySelectedValue = '선택해주세요';
    decipherSelectedValue = '선택해주세요';
    startDay = DateTime(2000, 1, 1);
    endDay = DateTime.now();
    userIDController.text = '';
    userNameController.text = '';
    update();
  }

  /// 스터디탭 읽어와 리스트 형식으로 리턴
  Future<List<StudyTab>> getStudyTabList() async {
    // 스터디 리스트 초기화
    List<StudyTab> studies = [];
    // endpoint 가져오기
    String url = dotenv.env['API_ENDPOINT']!;

    try {
      // 비동기 요청
      var response = await http.get(Uri.parse('${url}studies'));

      if (response.statusCode == 200) {
        // 응답 결과(리스트형식)을 담기
        List dataConvertedJSON = jsonDecode(response.body);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var study in dataConvertedJSON) {
          StudyTab tempStudy = StudyTab(
              PID: study['PID'],
              PNAME: study['PNAME'],
              MODALITY: study['MODALITY'],
              STUDYDESC: study['STUDYDESC'],
              STUDYDATE: study['STUDYDATE'],
              REPORTSTATUS: study['REPORTSTATUS'],
              SERIESCNT: study['SERIESCNT'],
              IMAGECNT: study['IMAGECNT'],
              EXAMSTATUS: study['EXAMSTATUS']);
          studies.add(tempStudy);
        }
      } else {
        // 200 코드가 아닌 경우 빈 리스트 리턴
        studies = [];
      }
    } catch (e) {
      // 예외 처리 및 변환
      // String errorMessage = "서버 요청 중 오류가 발생했습니다: $e";
      // return Future.error(errorMessage);
    }

    return studies;
    // }
  }
}
/*
getJSONData() async {
    var url = Uri.parse('https://zeushahn.github.io/Test/cards.json');
    var response = await http.get(url); // http로 정보를 가져올 때까지 기다려라
    //print(response.body);
    var dataConvertedJSON = json.decode(response.body);
    List result = dataConvertedJSON['results'];
    data.addAll(result);
    setState(() {});
  }
*/