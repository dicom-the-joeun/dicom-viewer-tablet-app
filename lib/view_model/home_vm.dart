import 'dart:convert';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/static/search_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class HomeVM extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    token = await SharedHandler().fetchData();
    studies = await getStudyTabList();
    update();
  }

  // 조건검색 시 어떤 기간이 선택되었는지 저장할 변수
  String selectedPeriod = '전체';
  // 선택되었는지 확인할 변수
  bool isWholeButtonSelected = true;
  bool isDayButtonSelected = false;
  bool isWeekButtonSelected = false;

  // 스터디 리스트
  List<StudyTab> studies = [];
  // 시리즈 리스트
  List<StudyTab> seriesList = [];
  // 조건검색된 스터디 리스트
  List<StudyTab> filterStudies = [];
  // Access Token
  String token = '';

  // 드롭다운 리스트 선언
  final modalityList = staticModalityList;
  final examStatusList = staticExamStatusList;
  final reportStatusList = staticReportStatusList;

  /// textField controller
  TextEditingController userIDController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  /// 드롭다운 선택값 변수 목록
  String selectedModality = staticModalityList[0];
  String selectedExamStatus = staticExamStatusList[0];
  String selectedReportStatus = staticReportStatusList[0];

  /// 캘린더 선택날짜
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // /// 검사일자 시작일, 종료일 초기값
  // DateTime startDay = DateTime(2000, 1, 1);
  // DateTime endDay = DateTime.now();

  DateTime rangeStart = DateTime.now();
  DateTime rangeEnd = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;

// 범위 선택
  rangeSelected(DateTime start, DateTime end) {
    rangeStart = start;
    rangeEnd = end;
    update();
  }

// 날짜 선택
  daySelected(DateTime selectedDay) {
    selectedDay = this.selectedDay;
    update();
  }

  /// 검사일자 변경 함수
  // Future<DateTime> updateDatePicker(context, DateTime inputDay) async {
  //   DateTime day = (await showDatePicker(
  //         context: context,
  //         firstDate: DateTime(2000, 1, 1),
  //         lastDate: DateTime(2099, 12, 31),
  //         currentDate: inputDay,
  //       )) ??
  //       inputDay;
  //   update();
  //   return day;
  // }

  /// 드롭다운 선택 시 선택값 변경 함수
  selectDropDown(String value, List<String> itemList) {
    if (itemList == modalityList) {
      selectedModality = value;
    } else if (itemList == examStatusList) {
      selectedExamStatus = value;
    } else {
      selectedReportStatus = value;
    }
    update();
  }

  /// 검색 조건 초기화 함수
  resetValues() {
    filterStudies = [];
    selectedModality = staticModalityList[0];
    selectedExamStatus = staticExamStatusList[0];
    selectedReportStatus = staticReportStatusList[0];
    rangeStart = DateTime.now();
    rangeEnd = DateTime.now();
    userIDController.text = '';
    userNameController.text = '';
    changeButtonState('전체');
    update();
  }

  /// 스터디탭 읽어와 리스트 형식으로 리턴
  Future<List<StudyTab>> getStudyTabList() async {
    // 스터디 리스트 초기화
    List<StudyTab> studies = [];
    // endpoint 가져오기
    String url = '${dotenv.env['API_ENDPOINT']!}studies/';

    try {
      // 비동기 요청
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // 응답 결과(리스트형식)을 담기
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var study in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          StudyTab tempStudy = StudyTab.fromMap(study);
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
  }

  Future<List<SeriesTab>> getSeriesTabList(int studyKey) async {
    // 시리즈 리스트 초기화
    List<SeriesTab> seriesList = [];
    // endpoint 가져오기
    String url =
        '${dotenv.env['API_ENDPOINT']!}dcms/thumbnails?studykey=$studyKey';

    try {
      // 비동기 요청
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        // 응답 결과(리스트형식)을 담기
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var series in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          SeriesTab tempSeries = SeriesTab.fromMap(series);
          seriesList.add(tempSeries);
        }
      } else {
        // 200 코드가 아닌 경우 빈 리스트 리턴
        seriesList = [];
      }
    } catch (e) {
      // 예외 처리 및 변환
      // String errorMessage = "서버 요청 중 오류가 발생했습니다: $e";
      // return Future.error(errorMessage);
    }

    return seriesList;
  }

  /// 조건 검색
  filterData(
      {String? pid,
      String? pname,
      String? equipment,
      String? examStatus,
      String? reportStatus}) {
    // 누적되지 않게 리셋
    filterStudies = [];

    for (var study in studies) {
      if (study.PID.toLowerCase() == pid!.trim().toLowerCase()) {
        filterStudies.add(study);
      }
    }

    update(); // 화면 갱신
  }

  /// 기간조회 컨트롤 함수
  changeButtonState(String state) {
    switch (state) {
      case '전체':
        selectedPeriod = '전체';
        isWholeButtonSelected = true;
        isDayButtonSelected = false;
        isWeekButtonSelected = false;
        rangeStart = DateTime(2000,1,1);
        rangeEnd = DateTime.now();
        break;
      case '1일':
        selectedPeriod = '1일';
        isWholeButtonSelected = false;
        isDayButtonSelected = true;
        isWeekButtonSelected = false;
        rangeStart = DateTime.now();
        rangeEnd = DateTime.now();
        break;
      case '1주일':
        selectedPeriod = '1주일';
        isWholeButtonSelected = false;
        isDayButtonSelected = false;
        isWeekButtonSelected = true;
        rangeStart = DateTime.now().subtract(const Duration(days: 7));
        rangeEnd = DateTime.now();
        break;
    }
    update();
  }

  searchStudy() {
    print(rangeStart);
    print(rangeEnd);
    filterStudies = studies.where((study) {
      bool idCondtion = (study.PID.toLowerCase() ==
              userIDController.text.toLowerCase().trim() ||
          userIDController.text.isEmpty);
      bool nameCondition = (study.PNAME.toLowerCase() ==
              userNameController.text.toLowerCase().trim() ||
          userNameController.text.isEmpty);
      bool modalityCondition = ((study.MODALITY == selectedModality) ||
          (selectedModality == staticModalityList[0]));
      bool examStatusCondition = ((study.EXAMSTATUS == selectedExamStatus) ||
          (selectedExamStatus == staticExamStatusList[0]));
      bool reportStatusConditon =
          ((study.REPORTSTATUS == selectedReportStatus) ||
              (selectedReportStatus == staticReportStatusList[0]));
      bool periodCondition = (int.parse(convertDateToString(rangeStart)) <= study.STUDYDATE) && (study.STUDYDATE <= int.parse(convertDateToString(rangeEnd))) ;
      return idCondtion &&
          nameCondition &&
          modalityCondition &&
          examStatusCondition &&
          periodCondition &&
          reportStatusConditon;
    }).toList();
    update();
  }

  String convertDateToString(DateTime date) {
    String year = date.year.toString();
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$year$month$day';
  }
}
