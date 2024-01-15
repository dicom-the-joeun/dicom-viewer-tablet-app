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

  /// 기간 조회 시 전체, 1일, 1주일 중 어떤 조건이 선택되었는지 저장
  String selectedPeriod = '전체';
  /// 기간 조회 버튼 선택 여부 저장
  bool isWholeButtonSelected = true;
  bool isDayButtonSelected = false;
  bool isWeekButtonSelected = false;

  // 스터디 리스트
  List<StudyTab> studies = [];
  // 필터링된 스터디 리스트
  List<StudyTab> filteredStudies = [];
  // 시리즈 리스트. ThumbnailView에 넘겨준다.
  List<StudyTab> seriesList = [];
  // Access Token
  String token = '';

  // 드롭다운버튼 리스트 초기화
  final modalityList = staticModalityList;
  final examStatusList = staticExamStatusList;
  final reportStatusList = staticReportStatusList;

  /// textField controller
  TextEditingController pIdController = TextEditingController();
  TextEditingController pNameController = TextEditingController();

  /// 드롭다운 선택값 변수 목록
  String selectedModality = staticModalityList[0];
  String selectedExamStatus = staticExamStatusList[0];
  String selectedReportStatus = staticReportStatusList[0];

  /// 캘린더에 선택된 날짜
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  /// 기간 조회 시작일자
  DateTime rangeStart = DateTime(2000, 1, 1);
  /// 기간 조회 종료일자
  DateTime rangeEnd = DateTime.now();
  // 뭔지 아직 모름
  CalendarFormat calendarFormat = CalendarFormat.month;

  /// 날짜 선택 : 캘린더에서 넘겨받은 값을 실제 변수에 저장
  daySelected(DateTime selectedDay) {
    selectedDay = this.selectedDay;
    update();
  }

  /// 범위 선택 : 캘린더에서 넘겨받은 값을 실제 변수에 저장
  rangeSelected(DateTime start, DateTime end) {
    rangeStart = start;
    rangeEnd = end;
    update();
  }


  /// 드롭다운버튼 항목 선택 시 선택값 변경 함수
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
    filteredStudies = [];
    selectedModality = staticModalityList[0];
    selectedExamStatus = staticExamStatusList[0];
    selectedReportStatus = staticReportStatusList[0];
    rangeStart = DateTime.now();
    rangeEnd = DateTime.now();
    pIdController.text = '';
    pNameController.text = '';
    changeButtonState('전체');
    update();
  }

  /// 스터디탭 리스트 api 요청 및 변환 후 리턴하는 함수
  Future<List<StudyTab>> getStudyTabList() async {
    // 스터디 리스트 초기화
    List<StudyTab> tempStudies = [];

    String url = '${dotenv.env['API_ENDPOINT']!}studies/';
    
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        List dataConvertedJSON = jsonDecode(responseBody);

        // 반복문으로 studies 리스트에 study 객체 담기
        for (var study in dataConvertedJSON) {
          // study를 Map형식으로 담아주기
          StudyTab tempStudy = StudyTab.fromMap(study);
          tempStudies.add(tempStudy);
        }
      } else {
        // 요청 실패한 경우
        debugPrint('스터디탭 리스트 요청 실패');
      }
    } catch (e) {
      debugPrint('스터디탭 리스트 요청 실패 : $e');
    }

    return tempStudies;
  }


  /// 시리즈탭 api 요청 및 변환 후 리턴하는 함수
  Future<List<SeriesTab>> getSeriesTabList(int studyKey) async {
    // 시리즈 리스트 초기화
    List<SeriesTab> seriesList = [];
    String url = '${dotenv.env['API_ENDPOINT']!}dcms/thumbnails?studykey=$studyKey';

    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
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

  /// searchButton 컨트롤 함수
  changeButtonState(String state) {
    switch (state) {
      case '전체':
        selectedPeriod = '전체';
        isWholeButtonSelected = true;
        isDayButtonSelected = false;
        isWeekButtonSelected = false;
        rangeStart = DateTime(2000, 1, 1);
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

  /// 스터디 조건 검색 함수 : pid, pname, modality, examStatus, reportStatus, period 조건 검색
  filterStudyList() {
    filteredStudies = studies.where((study) {
      bool idCondtion = (study.PID
              .toLowerCase()
              .contains(pIdController.text.toLowerCase().trim()) ||
          pIdController.text.isEmpty);
      bool nameCondition = (study.PNAME
              .toLowerCase()
              .contains(pNameController.text.toLowerCase().trim()) ||
          pNameController.text.isEmpty);
      bool modalityCondition = ((study.MODALITY == selectedModality) ||
          (selectedModality == staticModalityList[0]));
      bool examStatusCondition =
          ((study.EXAMSTATUS == _convertExamStatus(selectedExamStatus)) ||
              (selectedExamStatus == staticExamStatusList[0]));
      bool reportStatusConditon =
          ((study.REPORTSTATUS == selectedReportStatus) ||
              (selectedReportStatus == staticReportStatusList[0]));
      bool periodCondition =
          (int.parse(_convertDateToString(rangeStart)) <= study.STUDYDATE) &&
              (study.STUDYDATE <= int.parse(_convertDateToString(rangeEnd)));
      return idCondtion &&
          nameCondition &&
          modalityCondition &&
          examStatusCondition &&
          periodCondition &&
          reportStatusConditon;
    }).toList();

    update();
  }


  String _convertDateToString(DateTime date) {
    String year = date.year.toString();
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$year$month$day';
  }

  String _convertExamStatus(String examStatus) {
    return (examStatus == 'Not Requested') ? '아니오' : '예';
  }
}
