import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive_io.dart';
import 'package:dicom_image_control_app/data/shared_handler.dart';
import 'package:dicom_image_control_app/model/series_tab.dart';
import 'package:dicom_image_control_app/data/search_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ThumbnailVM extends GetxController {
  /// access token
  RxString token = ''.obs;

  //로딩할 때 보이는 텍스트
  RxString loadingText = ''.obs;

  /// access token 가져왔는지 판단할 변수
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    token.value = await SharedHandler().fetchData();
    isLoading.value = false; // Set loading to false after data is fetched
    update();
  }

  /// 이미지 url 생성 함수
  String generateThumbnailImageUrl(
      {required List<SeriesTab> seriesList, required int index}) {
    String url = '${dotenv.env['API_ENDPOINT']!}dcms/image';
    String filePath = seriesList[index].PATH;
    String fileName = seriesList[index].FNAME;

    url = '$url?filepath=$filePath&filename=$fileName';
    return url;
  }

  /// 스터디, 시리즈키를 넘겨서 zip파일 앱 내부에 저장하는 함수
  getSeriesImages({required int studykey,}) async {

    String fileName = 'study_$studykey';
    File file = File('$filePath/$fileName.zip');

    // 1. 요청 보내기 (겟방식, 스터디, 시리즈키 넘기기)
    String url =
        '${dotenv.env['API_ENDPOINT']!}dcms/images/zip?studykey=$studykey';

    try {
      loadingText.value = '다운로드 중.....';
      update();

      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'}
      );
      // 2. 응답 받기 (예외처리)
      if (response.statusCode == 200) {
        // 3. 응답에 성공한 경우 (바디에서 파일 받아온다)
        loadingText.value = '압축 해제 중.....';
        update();
        // 내가 원하는 경로에 내가 지정한 파일이름으로 zip파일 저장
        await file.writeAsBytes(response.bodyBytes);
        // 파일이름 기준으로 그 파일 압축풀기
        await _zipOpen(fileName);
      } else {
        print('압축 해제 실패');
      }
    } catch (e) {
      debugPrint('캐치에 걸림 $e');
    }    
  }

  /// 압축파일 해제 함수
  Future<void> _zipOpen(String zipFileName) async {
    final zipFilePath = '$filePath/$zipFileName.zip';         //받아온 zip파일의 이름이 들어갈 곳
    final destinationDirectory = '$filePath/$zipFileName'; //받아온 zip파일을 압축해제한 파일들이 들어갈 곳

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

}


