import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/model/study_tab.dart';
import 'package:dicom_image_control_app/provider/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStudyTabList();
  }

  /// 기간 조회 시 전체, 1일, 1주일 중 어떤 조건이 선택되었는지 저장
  String selectedPeriod = '전체';
  RxString loadingText = ''.obs;

  /// 기간 조회 버튼 선택 여부 저장
  bool isRangeButtonSelected = false;
  bool isWholeButtonSelected = true;
  bool isDayButtonSelected = false;
  bool isWeekButtonSelected = false;

  // 스터디 리스트
  List<StudyTab> studies = [];
  // 필터링된 스터디 리스트
  List<StudyTab> filteredStudies = [];
  // 시리즈 리스트. ThumbnailView에 넘겨준다.
  List<SeriesTab> seriesList = [];
  // Access Token

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

  /// 드롭다운버튼 항목 선택 시 선택값 변경 함수
  changeDropDownValue(String value, List<String> itemList) {
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
  resetAllFilters() {
    filteredStudies = [];
    selectedModality = staticModalityList[0];
    selectedExamStatus = staticExamStatusList[0];
    selectedReportStatus = staticReportStatusList[0];
    rangeStart = DateTime.now();
    rangeEnd = DateTime.now();
    pIdController.text = '';
    pNameController.text = '';
    changeDuration('전체');
    update();
  }

  /// 스터디탭 리스트 api 요청 및 변환 후 리턴하는 함수
  Future<void> getStudyTabList() async {
    ApiProvider provider = ApiProvider();
    studies = await provider.getStudyTabList();
  }

  /// 시리즈탭 api 요청 및 변환 후 리턴하는 함수
  Future<void> _getSeriesTabList(int studyKey) async {
    loadingText.value = 'LOADING.....';
    ApiProvider provider = ApiProvider();
    seriesList = await provider.getSeriesTabList(studyKey);
  }

  Future<void> _downloadStudyImagesZipFile(int studyKey) async {
    loadingText.value = 'DOWNLOAD.....';
    if (!await _isImageDownloaded(studyKey)) {
      ApiProvider provider = ApiProvider();
      // 이미지 zip파일 절대경로에 저장
      Map<String, dynamic> result =
          await provider.getStudyImagesZipFile(studyKey);
      if (result['result'] == true) {
        await _zipOpen(result['fileName']);
      } else {
        // 압축 해제 실패
      }
    }
  }

  Future<void> selectStudy(int studyKey) async {
    await _downloadStudyImagesZipFile(studyKey);
    await _getSeriesTabList(studyKey);
  }

  /// searchButton 컨트롤 함수
  void changeDuration(String state) {
    selectedPeriod = state;
    isRangeButtonSelected = state == '기간조회';
    isWholeButtonSelected = state == '전체';
    isDayButtonSelected = state == '1일';
    isWeekButtonSelected = state == '1주일';

    if (state == '전체') {
      rangeStart = DateTime(2000, 1, 1);
      rangeEnd = DateTime.now();
    } else if (state == '1일') {
      rangeStart = DateTime.now();
      rangeEnd = DateTime.now();
    } else if (state == '1주일') {
      rangeStart = DateTime.now().subtract(const Duration(days: 7));
      rangeEnd = DateTime.now();
    }

    update();
  }

  /// 이미 다운로드 받은 이미지일 경우 pass
  Future<bool> _isImageDownloaded(int studyKey) async {
    String path = '$filePath/study_$studyKey';
    return await Directory(path).exists();
  }

  /// 압축파일 해제 함수
  Future<void> _zipOpen(String zipFileName) async {
    final zipFilePath = '$filePath/$zipFileName.zip'; //받아온 zip파일의 이름이 들어갈 곳
    final destinationDirectory =
        '$filePath/$zipFileName'; //받아온 zip파일을 압축해제한 파일들이 들어갈 곳

    File zipFile = File(zipFilePath);

    if (zipFile.existsSync()) {
      List<int> bytes = zipFile.readAsBytesSync();
      Archive archive = ZipDecoder().decodeBytes(Uint8List.fromList(bytes));

      for (ArchiveFile file in archive) {
        String fileName = '$destinationDirectory/${file.name}';
        File outFile = File(fileName);
        // outFile.createSync(recursive: true);
        outFile.parent.createSync(recursive: true); // 디렉토리가 없으면 생성

        if (file.isFile) {
          outFile.writeAsBytesSync(file.content as List<int>);
        } else {
          Directory(fileName).create(recursive: true);
        }
      }
      print('압축 파일이 성공적으로 해제되었습니다.');
    } else {
      print('지정된 압축 파일이 존재하지 않습니다.');
    }
  }

  /// 스터디 조건 검색 함수 : pid, pname, modality, examStatus, reportStatus, period 조건 검색
  searchStudy() {
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
