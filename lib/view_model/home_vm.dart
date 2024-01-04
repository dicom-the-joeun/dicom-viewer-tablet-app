import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  // 스터디탭 읽어와 리스트 형식으로 리턴
  Future<List<StudyTab>> getStudyTabList() async {
    // String url = dotenv.env['API_ENDPOINT']!;

    List<StudyTab> studies = [];
    return studies;
    // }
  }
}
